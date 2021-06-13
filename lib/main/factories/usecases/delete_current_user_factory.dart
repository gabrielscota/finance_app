import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

DeleteCurrentUser makeLocalDeleteCurrentUser() => LocalDeleteCurrentUser(
      deleteSecureCacheStorage: makeSecureStorageAdapter(),
    );
