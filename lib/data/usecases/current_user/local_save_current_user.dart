import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../cache/cache.dart';

class LocalSaveCurrentUser implements SaveCurrentUser {
  final SaveSecureCacheStorage saveSecureCacheStorage;

  LocalSaveCurrentUser({required this.saveSecureCacheStorage});

  @override
  Future<void> save({required String userJson}) async {
    try {
      await saveSecureCacheStorage.save(key: 'currentUser', value: userJson);
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
