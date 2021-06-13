import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

SaveCurrentUser makeLocalSaveCurrentUser() => LocalSaveCurrentUser(
      saveSecureCacheStorage: makeSecureStorageAdapter(),
    );
