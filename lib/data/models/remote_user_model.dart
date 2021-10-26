import '../../domain/entities/entities.dart';
import '../firebase/firebase.dart';
import 'models.dart';

class RemoteUserModel {
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

  const RemoteUserModel({
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

  factory RemoteUserModel.fromJson(Json json) {
    if (!json.containsKey('uid')) {
      throw FirebaseFirestoreError.invalidData;
    }
    return RemoteUserModel(
      uid: (json['uid'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      username: (json['username'] ?? '').toString(),
      cpf: (json['cpf'] ?? '').toString(),
      avatar: (json['avatar'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      useBiometric: (json['useBiometric'] ?? false) as bool,
      createdAt: (json['createdAt'] ?? '').toString(),
      updatedAt: (json['updatedAt'] ?? '').toString(),
      deletedAt: (json['deletedAt'] ?? '').toString(),
    );
  }

  factory RemoteUserModel.fromEntity(UserEntity entity) {
    return RemoteUserModel(
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

  UserEntity toEntity() => UserEntity(
        uid: uid,
        email: email,
        username: username,
        cpf: cpf,
        avatar: avatar,
        name: name,
        useBiometric: useBiometric,
        createdAt: createdAt,
        updatedAt: updatedAt,
        deletedAt: deletedAt,
      );

  Json toJson() => {
        'uid': uid,
        'email': email,
        'username': username,
        'cpf': cpf,
        'avatar': avatar,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'deletedAt': deletedAt,
      };
}
