


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



import '../user_repository.dart';

abstract class UserRepository {
  Stream<User?> get user;
	
	Future<void> signIn(String email, String password);

	Future<void> logOut();

	Future<MyUser> signUp(MyUser myUser, String password);

	Future<void> resetPassword(String email);

	Future<void> setUserData(MyUser user);

	Future<MyUser> getMyUser(String myUserId);

	Future<String> uploadPicture(String file, String userId);

  Future<void> updateUserPicture(String userId, String newPicture);

  Future<List<MyUser>> searchUsers(String query);
  
  Future<void> sendFriendRequest(String senderId, String receiverId);
  Future<void> acceptFriendRequest(String requestId);
  Future<List<Map<String, dynamic>>> getPendingRequests(String userId);
  Future<List<MyUser>> getFriends(String userId);
  Stream<List<Map<String, dynamic>>> friendRequestsStream(String userId);


Stream<List<AppNotification>> getNotifications(String userId);
  Future<void> createNotification(AppNotification  notification);
  Future<void> updateNotificationStatus(String notificationId, String status);
  Future<void> handleFriendRequest(String requestId, bool isAccepted);



    Future<int> getUnreadNotificationCount(String userId);
  Future<void> markAllNotificationsAsRead(String userId);
  Future<void> deleteReadNotifications(String userId);
  Future<void> deleteNotification(String notificationId);
    Stream<List<MyUser>> getFriendsStream(String userId);
  Future<void> removeFriend(String userId, String friendId);

    Future<String> getOrCreateConversation(String userId1, String userId2);
  Stream<List<Message>> getMessages(String conversationId);
  Future<void> sendMessage(String conversationId, Message message);
  Stream<List<Conversation>> getConversations(String userId);
  Future<void> markMessagesAsRead(String conversationId, String userId);
  Future<int> getUnreadMessagesCount(String userId);


    Future<String> createChallenge(String challengerID, String challengedID, String category , IconData icon);
  Future<void> updateChallengeScore(String challengeID, bool isChallenger, int score);
  Stream<Challenge> getChallengeUpdates(String challengeID);
  Stream<List<Challenge>> getUserChallenges(String userID);
   Future<MyUser> getUser(String userID);
   Future<void> completeChallenge(String challengeId);
    Future<void> updateChallengeQuestions(String challengeID, List<String> questionIDs);
     Future<void> updateUserStats(String winnerID, String loserID);
     Stream<MyUser> streamMyUser(String userId);
}

