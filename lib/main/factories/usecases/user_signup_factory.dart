import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

UserSignUp makeRemoteUserSignUp() => RemoteSignUp(
      firebaseAuthentication: makeFirebaseAuth(),
      cloudFirestore: makeCloudFirestore(),
    );
