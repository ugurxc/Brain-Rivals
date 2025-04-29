import 'package:equatable/equatable.dart';

import 'package:user_repository/user_repository.dart';

class Notification extends Equatable {
  final String id;
  final String userId;
  final String type;
  final String senderId;
  final String message;
  final String status;
  final DateTime createdAt;
  final String relatedRequestId;

  const Notification({
    required this.id,
    required this.userId,
    required this.type,
    required this.senderId,
    required this.message,
    required this.status,
    required this.createdAt,
    required this.relatedRequestId,
  });

  static Notification fromEntity(NotificationEntity entity) {
    return Notification(
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
  List<Object?> get props => [
        id,
        userId,
        type,
        senderId,
        message,
        status,
        createdAt,
        relatedRequestId,
      ];
}