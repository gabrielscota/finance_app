import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

UserLogout makeRemoteLogout() => RemoteLogout(
      firebaseAuthentication: makeFirebaseAuth(),
    );
