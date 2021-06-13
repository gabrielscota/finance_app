import 'dart:math' as math;

import '../../domain/entities/entities.dart';

class RemoteUserSignUpModel {
  final String uid;
  final String email;
  final String username;
  final String avatar;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const RemoteUserSignUpModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.avatar,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory RemoteUserSignUpModel.fromEntity(UserEntity entity) {
    return RemoteUserSignUpModel(
      uid: entity.uid,
      email: entity.email,
      username: entity.username,
      avatar: entity.avatar,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }

  factory RemoteUserSignUpModel.fromEntityWithUid(UserEntity entity, String uid) {
    return RemoteUserSignUpModel(
      uid: uid,
      email: entity.email,
      username: entity.username,
      avatar: entity.avatar,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }

  factory RemoteUserSignUpModel.fromEntityWithGoogleSignUpParams(
    UserEntity entity,
    String uid,
    String email,
    String name,
  ) {
    return RemoteUserSignUpModel(
      uid: uid,
      email: email,
      username: '${email.split('@')[0]}${math.Random().nextInt(1000)}',
      avatar: entity.avatar,
      name: name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'avatar': avatar,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
      };
}
