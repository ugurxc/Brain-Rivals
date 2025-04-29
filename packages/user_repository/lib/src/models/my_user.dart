

import 'package:equatable/equatable.dart';
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