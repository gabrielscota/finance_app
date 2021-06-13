import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';

class RemoteAuthentication implements UserAuthentication {
  final FirebaseAuthentication firebaseAuthentication;

  RemoteAuthentication({required this.firebaseAuthentication});

  @override
  Future<String> auth({required AuthenticationParams params}) async {
    try {
      final UserCredential userCredential = await firebaseAuthentication.authWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      return userCredential.user?.uid ?? '';
    } on FirebaseAuthError catch (error) {
      throw error == FirebaseAuthError.wrongPassword || error == FirebaseAuthError.userNotFound
          ? DomainError.invalidCredentials
          : DomainError.unexpected;
    }
  }
}
