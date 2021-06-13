import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

UserAuthentication makeRemoteUserAuthentication() => RemoteAuthentication(
      firebaseAuthentication: makeFirebaseAuth(),
    );
