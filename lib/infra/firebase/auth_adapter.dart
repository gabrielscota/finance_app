import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../data/firebase/firebase.dart';

class AuthAdapter extends FirebaseAuthentication {
  final FirebaseAuth firebaseAuth;

  AuthAdapter({required this.firebaseAuth});

  @override
  Future<UserCredential> authWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (error) {
      if (error.code == FirebaseAuthError.invalidEmail.code) {
        throw FirebaseAuthError.invalidEmail;
      } else if (error.code == FirebaseAuthError.userDisabled.code) {
        throw FirebaseAuthError.userDisabled;
      } else if (error.code == FirebaseAuthError.userNotFound.code) {
        throw FirebaseAuthError.userNotFound;
      } else if (error.code == FirebaseAuthError.wrongPassword.code) {
        throw FirebaseAuthError.wrongPassword;
      } else {
        throw FirebaseAuthError.internalError;
      }
    }
  }

  @override
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } catch (error) {
      throw FirebaseAuthError.internalError;
    }
  }

  @override
  Future<UserCredential> signUpWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (error) {
      if (error.code == FirebaseAuthError.emailAlreadyInUse.code) {
        throw FirebaseAuthError.emailAlreadyInUse;
      } else if (error.code == FirebaseAuthError.invalidEmail.code) {
        throw FirebaseAuthError.invalidEmail;
      } else if (error.code == FirebaseAuthError.weakPassword.code) {
        throw FirebaseAuthError.weakPassword;
      } else {
        throw FirebaseAuthError.internalError;
      }
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException {
      throw FirebaseAuthError.internalError;
    }
  }
}
