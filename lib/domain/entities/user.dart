import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String email;
  final String username;
  final String avatar;
  final String name;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.username,
    required this.avatar,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  @override
  List<Object?> get props => [
        uid,
        email,
        username,
        avatar,
        name,
        createdAt,
        updatedAt,
        deletedAt,
      ];
}
