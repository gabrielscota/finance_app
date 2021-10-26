import '../../domain/entities/entities.dart';

class RemoteUserSignUpModel {
  final String uid;
  final String email;
  final String username;
  final String cpf;
  final String avatar;
  final String name;
  final bool useBiometric;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  const RemoteUserSignUpModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.cpf,
    required this.avatar,
    required this.name,
    required this.useBiometric,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  factory RemoteUserSignUpModel.fromEntity(UserEntity entity) {
    return RemoteUserSignUpModel(
      uid: entity.uid,
      email: entity.email,
      username: entity.username,
      cpf: entity.cpf,
      avatar: entity.avatar,
      name: entity.name,
      useBiometric: entity.useBiometric,
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
      cpf: entity.cpf,
      avatar: entity.avatar,
      name: entity.name,
      useBiometric: entity.useBiometric,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      deletedAt: entity.deletedAt,
    );
  }

  factory RemoteUserSignUpModel.fromEntityWithGoogleSignUpParams(
    String uid,
    String email,
    String avatar,
    String name,
    String createdAt,
    String updatedAt,
  ) {
    return RemoteUserSignUpModel(
      uid: uid,
      email: email,
      username: email.split('@')[0],
      cpf: '',
      avatar: avatar,
      name: name,
      useBiometric: false,
      createdAt: createdAt,
      updatedAt: updatedAt,
      deletedAt: '',
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'cpf': cpf,
        'avatar': avatar,
        'name': name,
        'useBiometric': useBiometric,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
      };
}
