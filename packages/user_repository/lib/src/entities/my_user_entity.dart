import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class MyUserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? picture;
  final List<String> friends; // Yeni alan

  const MyUserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.picture,
    this.friends = const [], // Varsayılan değer
  });

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'picture': picture,
      'friends': friends, // Firestore'a ekle
      'searchKeywords': name.toLowerCase().split(''), // Arama optimizasyonu
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      id: doc['id'] as String,
      email: doc['email'] as String,
      name: doc['name'] as String,
      picture: doc['picture'] as String?,
      friends: (doc['friends'] as List<dynamic>).cast<String>(), // Listeyi çevir
    );
  }

  @override
  List<Object?> get props => [id, email, name, picture, friends];
}

class NotificationEntity extends Equatable {
  final String id;
  final String userId;
  final String type;
  final String senderId;
  final String message;
  final String status;
  final DateTime createdAt;
  final String relatedRequestId;

  const NotificationEntity({
    required this.id,
    required this.userId,
    required this.type,
    required this.senderId,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.relatedRequestId,
  });

  Map<String, dynamic> toDocument() {
    return {
      'userId': userId,
      'type': type,
      'senderId': senderId,
      'message': message,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'relatedRequestId': relatedRequestId,
    };
  }

  static NotificationEntity fromDocument(String docId, Map<String, dynamic> doc) {
    return NotificationEntity(
      id: docId,
      userId: doc['userId'] as String,
      type: doc['type'] as String,
      senderId: doc['senderId'] as String,
      message: doc['message'] as String,
      status: doc['status'] as String,
      createdAt: (doc['createdAt'] as Timestamp).toDate(),
      relatedRequestId: doc['relatedRequestId'] as String,
    );
  }

  @override
  List<Object?> get props => [id, userId, type, senderId, status];
}