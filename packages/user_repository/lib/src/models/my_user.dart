

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:user_repository/user_repository.dart';

// ignore: must_be_immutable
class MyUser extends Equatable {
  final String id;
  final String email;
  final String name;
  String? picture;
  List<String> friends;

  MyUser({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    this.friends = const [], // Varsayılan değer
  });

  static final empty = MyUser(
    id: '',
    email: '',
    name: '',
    friends: const [], // Boş liste olarak düzelt
  );

  MyUser copyWith({
    String? id,
    String? email,
    String? name,
    String? picture,
    List<String>? friends,
  }) {
    return MyUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      friends: friends ?? this.friends, // Yeni alan
    );
  }

  MyUserEntity toEntity() {
    return MyUserEntity(
      id: id,
      email: email,
      name: name,
      picture: picture,
      friends: friends, // Entity'e aktar
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      id: entity.id,
      email: entity.email,
      name: entity.name,
      picture: entity.picture,
      friends: entity.friends, // Model'e aktar
    );
  }




  @override
  List<Object?> get props => [id, email, name, picture, friends];
}

class AppNotification  extends Equatable {
  final String id;
  final String userId;
  final String type;
  final String senderId;
  final String message;
  final String status;
  final DateTime createdAt;
  final String relatedRequestId;

  const AppNotification ({
    required this.id,
    required this.userId,
    required this.type,
    required this.senderId,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.relatedRequestId,
  });

  static AppNotification  fromEntity(NotificationEntity entity) {
    return AppNotification (
      id: entity.id,
      userId: entity.userId,
      type: entity.type,
      senderId: entity.senderId,
      message: entity.message,
      status: entity.status,
      createdAt: entity.createdAt,
      relatedRequestId: entity.relatedRequestId,
    );
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
      id: id,
      userId: userId,
      type: type,
      senderId: senderId,
      message: message,
      status: status,
      createdAt: createdAt,
      relatedRequestId: relatedRequestId,
    );
  }

  @override
  List<Object?> get props => [id, userId, type, senderId, status];
}


// message.dart


class Message extends Equatable {
  final String id;
  final String senderId;
  final String text;
  final DateTime createdAt;
  final bool isRead;

  const Message({
    required this.id,
    required this.senderId,
    required this.text,
    required this.createdAt,
    this.isRead = false,
  });

  factory Message.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      id: doc.id,
      senderId: data['senderId'],
      text: data['text'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      isRead: data['isRead'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt),
      'isRead': isRead,
    };
  }

  @override
  List<Object?> get props => [id, senderId, text, createdAt, isRead];
}

class Conversation extends Equatable {
  final String id;
  final List<String> participants;
  final DateTime lastUpdated;
  final String lastMessage;
  final String lastSenderId;

  const Conversation({
    required this.id,
    required this.participants,
    required this.lastUpdated,
    required this.lastMessage,
    required this.lastSenderId,
  });

  factory Conversation.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Conversation(
      id: doc.id,
      participants: List<String>.from(data['participants']),
      lastUpdated: (data['lastUpdated'] as Timestamp).toDate(),
      lastMessage: data['lastMessage'],
      lastSenderId: data['lastSenderId'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'participants': participants,
      'lastUpdated': FieldValue.serverTimestamp(),
      'lastMessage': lastMessage,
      'lastSenderId': lastSenderId,
    };
  }

  @override
  List<Object?> get props => [id, participants, lastUpdated, lastMessage];
}

class Challenge {
   final IconData icon;
   final bool challengerPlayed;
  final bool challengedPlayed;
  final String id;
  final String challengerID;
  final String challengedID;
  final String category;
  final int challengerScore;
  final int challengedScore;
  final DateTime createdAt;
  final String status;

  const Challenge(  {
    required this.icon,
    required this.challengerPlayed,
    required this.challengedPlayed,
    required this.id,
    required this.challengerID,
    required this.challengedID,
    required this.category,
    required this.challengerScore,
    required this.challengedScore,
    required this.createdAt,
    required this.status,
  });

  factory Challenge.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final iconData = data['icon'] as Map<String, dynamic>;
    return Challenge(
      icon:  IconData(
      iconData['codePoint'],
      fontFamily: iconData['fontFamily'],
      fontPackage: iconData['fontPackage'], // FontAwesome için bu genellikle 'font_awesome_flutter'
    ),
      id: doc.id,
       challengerPlayed: data['challengerScore'] >= 0,
      challengedPlayed: data['challengedScore'] >= 0,
      challengerID: data['challengerID'],
      challengedID: data['challengedID'],
      category: data['category'],
      challengerScore: data['challengerScore'],
      challengedScore: data['challengedScore'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      status: data['status'],
    );
  }
}