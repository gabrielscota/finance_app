import 'dart:convert';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../cache/cache.dart';

class LocalLoadCurrentUser implements LoadCurrentUser {
  final FetchSecureCacheStorage fetchSecureCacheStorage;

  LocalLoadCurrentUser({required this.fetchSecureCacheStorage});

  @override
  Future<UserEntity> load() async {
    try {
      final String? userJson = await fetchSecureCacheStorage.fetch(key: 'currentUser');
      final Map<String, dynamic> user = jsonDecode(userJson ?? '');
      return UserEntity(
        uid: (user['uid'] ?? '').toString(),
        email: (user['email'] ?? '').toString(),
        username: (user['username'] ?? '').toString(),
        cpf: (user['cpf'] ?? '').toString(),
        avatar: (user['avatar'] ?? '').toString(),
        name: (user['name'] ?? '').toString(),
        useBiometric: (user['useBiometric'] ?? false) as bool,
        createdAt: (user['createdAt'] ?? '').toString(),
        updatedAt: (user['updatedAt'] ?? '').toString(),
        deletedAt: (user['deletedAt'] ?? '').toString(),
      );
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
