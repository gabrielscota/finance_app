import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

LoadCurrentUser makeLocalLoadCurrentUser() => LocalLoadCurrentUser(
      fetchSecureCacheStorage: makeSecureStorageAdapter(),
    );
