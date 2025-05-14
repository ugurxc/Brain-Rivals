import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../user_repository.dart';


class FirebaseUserRepository  implements UserRepository{
  FirebaseUserRepository({
		FirebaseAuth? firebaseAuth,
	})  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

	final FirebaseAuth _firebaseAuth;
	final usersCollection = FirebaseFirestore.instance.collection('users');
  final CollectionReference _challenges = FirebaseFirestore.instance.collection('challenges');

    final CollectionReference notifications =
      FirebaseFirestore.instance.collection('notifications');

	/// Stream of [MyUser] which will emit the current user when
	/// the authentication state changes.
	///
	/// Emits [MyUser.empty] if the user is not authenticated.
	@override
	Stream<User?> get user {
		return _firebaseAuth.authStateChanges().map((firebaseUser) {
			final user = firebaseUser;
			return user;
		});
	}

	@override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
				email: myUser.email,
				password: password
			);

			myUser = myUser.copyWith(
				id: user.user!.uid
			);

			return myUser;
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

	@override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
				email: email,
				password: password
			);
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      log(e.toString());
			rethrow;
    }
  }

	@override
	Future<void> setUserData(MyUser user) async {
		try {
			await usersCollection.doc(user.id).set(user.toEntity().toDocument());
		} catch(e) {
			log(e.toString());
			rethrow;
		}
	}

	@override
  Future<MyUser> getMyUser(String myUserId) async {
    try {
      return usersCollection.doc(myUserId).get().then((value) =>
				MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!))
			);
    } catch (e) {
			log(e.toString());
      rethrow;
    }
  }
   @override
  Future<List<MyUser>> searchUsers(String query) async{
     final result = await FirebaseFirestore.instance
      .collection('users')
      .where('name', isGreaterThanOrEqualTo: query)
      .where('name', isLessThanOrEqualTo: '$query\uf8ff')
      .get();

  return result.docs.map((doc) => MyUser.fromEntity(MyUserEntity.fromDocument(doc.data()))).toList();
  }

	@override
	 Future<String> uploadPicture(String file, String userId) async {
		try {
		  File imageFile = File(file);
			Reference firebaseStoreRef = FirebaseStorage
				.instance
				.ref()
				.child('$userId/PP/${userId}_lead');
			await firebaseStoreRef.putFile(
        imageFile,
      );
			String url = await firebaseStoreRef.getDownloadURL();
			await usersCollection
				.doc(userId)
				.update({'picture': url});
			return url;
		} catch (e) {
		  log(e.toString());
			rethrow;
		}
	}
  
   @override
   Future<void> updateUserPicture(String userId, String newPicture)async {
     await usersCollection
      .doc(userId)
      .update({'picture': newPicture});
   }


     final CollectionReference friendRequests = 
    FirebaseFirestore.instance.collection('friend_requests');

  // Yeni metodlar
@override
  Future<void> sendFriendRequest(String senderId, String receiverId) async {
    // Var olan istek kontrolü
    final existing = await friendRequests
        .where('from', isEqualTo: senderId)
        .where('to', isEqualTo: receiverId)
        .get();

    if (existing.docs.isNotEmpty) {
      throw Exception('Bu kullanıcıya zaten istek gönderdiniz');
    }

    // Yeni istek oluştur
    final requestDoc = await friendRequests.add({
      'from': senderId,
      'to': receiverId,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'processedAt': null,
    });

    // Bildirim oluştur
    final notification = AppNotification (
      id: '',
      userId: receiverId,
      type: 'friend_request',
      senderId: senderId,
      message: 'Yeni arkadaşlık isteği aldınız',
      status: 'unread',
      createdAt: DateTime.now(),
      relatedRequestId: requestDoc.id,
    );
    await createNotification(notification);
  }

  @override
  Future<void> acceptFriendRequest(String requestId) async {
    final doc = friendRequests.doc(requestId);
    final request = await doc.get();
    
    await FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.update(doc, {'status': 'accepted'});
      
      final fromUserRef = usersCollection.doc(request['from']);
      final toUserRef = usersCollection.doc(request['to']);
      
      transaction.update(fromUserRef, {
        'friends': FieldValue.arrayUnion([request['to']])
      });
      
      transaction.update(toUserRef, {
        'friends': FieldValue.arrayUnion([request['from']])
      });
    });
  }

  @override
  Future<List<Map<String, dynamic>>> getPendingRequests(String userId) async {
    final snapshot = await friendRequests
        .where('to', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .get();

    return snapshot.docs.map((doc) => {
      'id': doc.id,
      ...doc.data() as Map<String, dynamic>
    }).toList();
  }

  @override
/*   Stream<List<Map<String, dynamic>>> friendRequestsStream(String userId) {
    return friendRequests
        .where('to', isEqualTo: userId)
        .where('status', isEqualTo: 'pending')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data() as Map<String, dynamic>})
            .toList());
  } */
 Stream<List<Map<String, dynamic>>> friendRequestsStream(String userId) {
  return FirebaseFirestore.instance
      .collection('friend_requests')
      .where('from', isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) {
            return {
              'id': doc.id,
              'from': doc['from'],
              'to': doc['to'],
              'status': doc['status'],
            };
          }).toList());
}

  @override
  Future<List<MyUser>> getFriends(String userId) async {
    final userDoc = await usersCollection.doc(userId).get();
    final friendsIds = (userDoc['friends'] as List<dynamic>).cast<String>();
    
    if (friendsIds.isEmpty) return [];
    
    final friends = await usersCollection
        .where(FieldPath.documentId, whereIn: friendsIds)
        .get();
    
    return friends.docs
        .map((doc) => MyUser.fromEntity(MyUserEntity.fromDocument(doc.data())))
        .toList();
  }
    @override
  Stream<List<AppNotification >> getNotifications(String userId) {
    return notifications
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppNotification .fromEntity(
                  NotificationEntity.fromDocument(
                    doc.id,
                    doc.data() as Map<String, dynamic>,
                  ),
                ))
            .toList());
  }

  @override
  Future<void> createNotification(AppNotification  notification) async {
    final entity = notification.toEntity();
    await notifications.add(entity.toDocument());
  }

  @override
  Future<void> updateNotificationStatus(
      String notificationId, String status) async {
    await notifications.doc(notificationId).update({'status': status});
  }

  @override
  Future<void> handleFriendRequest(String requestId, bool isAccepted) async {
    final requestDoc = await friendRequests.doc(requestId).get();
    if (!requestDoc.exists) throw Exception('İstek bulunamadı');

    final requestData = requestDoc.data() as Map<String, dynamic>;
    final currentUserId = _firebaseAuth.currentUser!.uid;

    // İstek durumunu güncelle
    await requestDoc.reference.update({
      'status': isAccepted ? 'accepted' : 'rejected',
      'processedAt': FieldValue.serverTimestamp(),
    });

    // Bildirim oluştur
    final notification = AppNotification (
      id: '',
      userId: requestData['from'],
      type: 'request_response',
      senderId: currentUserId,
      message: isAccepted
          ? 'Arkadaşlık isteğiniz kabul edildi 🎉'
          : 'Arkadaşlık isteğiniz reddedildi',
      status: 'unread',
      createdAt: DateTime.now(),
      relatedRequestId: requestId,
    );
    await createNotification(notification);

    if (isAccepted) {
      await _updateFriendsList(
        requestData['from'],
        requestData['to'],
      );
    }
  }

  Future<void> _updateFriendsList(String user1Id, String user2Id) async {
    final batch = FirebaseFirestore.instance.batch();
    final user1Ref = usersCollection.doc(user1Id);
    final user2Ref = usersCollection.doc(user2Id);

    batch.update(user1Ref, {
      'friends': FieldValue.arrayUnion([user2Id])
    });
    
    batch.update(user2Ref, {
      'friends': FieldValue.arrayUnion([user1Id])
    });

    await batch.commit();
  }

    @override
  Future<int> getUnreadNotificationCount(String userId) async {
    final snapshot = await notifications
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'unread')
        .count()
        .get();
    return 1;
  }

  @override
  Future<void> markAllNotificationsAsRead(String userId) async {
    final snapshot = await notifications
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'unread')
        .get();

    final batch = FirebaseFirestore.instance.batch();
    for (final doc in snapshot.docs) {
      batch.update(doc.reference, {'status': 'read'});
    }
    await batch.commit();
  }

  @override
  Future<void> deleteReadNotifications(String userId) async {
    final snapshot = await notifications
        .where('userId', isEqualTo: userId)
        .where('status', isEqualTo: 'read')
        .get();

    final batch = FirebaseFirestore.instance.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await notifications.doc(notificationId).delete();
  }

   @override
  Stream<List<MyUser>> getFriendsStream(String userId) {
    return usersCollection.doc(userId).snapshots().asyncMap((snapshot) async {
      final friendsIds = (snapshot['friends'] as List<dynamic>).cast<String>();
      if (friendsIds.isEmpty) return [];
      
      final friendsSnapshot = await usersCollection
          .where(FieldPath.documentId, whereIn: friendsIds)
          .get();

      return friendsSnapshot.docs
          .map((doc) => MyUser.fromEntity(MyUserEntity.fromDocument(doc.data())))
          .toList();
    });
  }

  @override
  Future<void> removeFriend(String userId, String friendId) async {
    final batch = FirebaseFirestore.instance.batch();
    
    final userRef = usersCollection.doc(userId);
    batch.update(userRef, {
      'friends': FieldValue.arrayRemove([friendId])
    });

    final friendRef = usersCollection.doc(friendId);
    batch.update(friendRef, {
      'friends': FieldValue.arrayRemove([userId])
    });

    await batch.commit();
  }
   ///////////////////////////////////
   ///
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   @override
  Future<String> getOrCreateConversation(String userId1, String userId2) async {
    final participants = [userId1, userId2]..sort();
    
    final query = await _firestore
        .collection('conversations')
        .where('participants', isEqualTo: participants)
        .limit(1)
        .get();

    if (query.docs.isNotEmpty) return query.docs.first.id;

    final docRef = await _firestore.collection('conversations').add({
      'participants': participants,
      'lastUpdated': FieldValue.serverTimestamp(),
      'lastMessage': '',
      'lastSenderId': '',
    });

    return docRef.id;
  }

  @override
  Stream<List<Message>> getMessages(String conversationId) {
    return _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Message.fromSnapshot(doc))
            .toList());
  }

  @override
  Future<void> sendMessage(String conversationId, Message message) async {
    final conversationRef = _firestore.collection('conversations').doc(conversationId);
    final messagesRef = conversationRef.collection('messages');

    final batch = _firestore.batch();

    // Mesaj ekle
    final messageRef = messagesRef.doc();
    batch.set(messageRef, message.toMap());

    // Konuşmayı güncelle
    batch.update(conversationRef, {
      'lastMessage': message.text,
      'lastSenderId': message.senderId,
      'lastUpdated': FieldValue.serverTimestamp(),
    });

    await batch.commit();
  }

  @override
  Stream<List<Conversation>> getConversations(String userId) {
    return _firestore
        .collection('conversations')
        .where('participants', arrayContains: userId)
        .orderBy('lastUpdated', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Conversation.fromSnapshot(doc))
            .toList());
  }

  @override
  Future<void> markMessagesAsRead(String conversationId, String userId) async {
    final messages = await _firestore
        .collection('conversations')
        .doc(conversationId)
        .collection('messages')
        .where('senderId', isNotEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    final batch = _firestore.batch();
    for (final doc in messages.docs) {
      batch.update(doc.reference, {'isRead': true});
    }
    await batch.commit();
  }

  @override
  Future<int> getUnreadMessagesCount(String userId) async {
    final snapshot = await _firestore
        .collectionGroup('messages')
        .where('senderId', isNotEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .count()
        .get();

    return snapshot.count ?? 0;
  }


  @override
  Future<String> createChallenge(String challengerID, String challengedID, String category) async {
    final docRef = await _challenges.add({
      'challengerID': challengerID,
      'challengedID': challengedID,
      'category': category,
      'challengerScore': 0,
      'challengedScore': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'status': 'active'
    });
    return docRef.id;
  }

  @override
  Future<void> updateChallengeScore(String challengeID, bool isChallenger, int score) async {
    final field = isChallenger ? 'challengerScore' : 'challengedScore';
    await _challenges.doc(challengeID).update({
      field: score,
      'status': score > 0 ? 'completed' : 'active'
    });
  }

  @override
  Stream<Challenge> getChallengeUpdates(String challengeID) {
    return _challenges.doc(challengeID).snapshots().map(Challenge.fromSnapshot);
  }

  @override
  Stream<List<Challenge>> getUserChallenges(String userID) {
    return _challenges
        .where('status', whereIn: ['active', 'completed'])
        .where('challengerID', isEqualTo: userID)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map(Challenge.fromSnapshot)
            .toList());
  }

}