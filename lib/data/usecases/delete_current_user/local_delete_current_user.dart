import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../cache/cache.dart';

class LocalDeleteCurrentUser implements DeleteCurrentUser {
  final DeleteSecureCacheStorage deleteSecureCacheStorage;

  LocalDeleteCurrentUser({required this.deleteSecureCacheStorage});

  @override
  Future<void> delete({required String key}) async {
    try {
      await deleteSecureCacheStorage.delete(key: key);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
