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
      final String? uid = await fetchSecureCacheStorage.fetch(key: 'uid');
      return UserEntity(
        uid: uid!,
        email: '',
        username: '',
        avatar: '',
        name: '',
        createdAt: '',
        updatedAt: '',
        deletedAt: '',
      );
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
