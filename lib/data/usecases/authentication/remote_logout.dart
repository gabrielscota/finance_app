import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';

class RemoteLogout implements UserLogout {
  final FirebaseAuthentication firebaseAuthentication;

  RemoteLogout({required this.firebaseAuthentication});

  @override
  Future<void> logout() async {
    try {
      await firebaseAuthentication.logout();
    } on FirebaseAuthError {
      throw DomainError.unexpected;
    }
  }
}
