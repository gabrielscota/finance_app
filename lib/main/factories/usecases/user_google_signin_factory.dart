import '../../../data/usecases/usecases.dart';
import '../../../domain/usecases/usecases.dart';
import '../factories.dart';

UserGoogleSignIn makeRemoteUserGoogleSignIn() => RemoteGoogleSignIn(
      firebaseAuthentication: makeFirebaseAuth(),
      cloudFirestore: makeCloudFirestore(),
    );
