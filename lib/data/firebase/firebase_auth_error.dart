import 'package:flutter/foundation.dart';

enum FirebaseAuthError {
  internalError,
  invalidEmail,
  invalidPassword,
  userNotFound,
  wrongPassword,
  weakPassword,
  emailAlreadyInUse,
}

extension FirebaseAuthErrorExtension on FirebaseAuthError {
  String get name => describeEnum(this);

  String get code {
    switch (this) {
      case FirebaseAuthError.userNotFound:
        return 'user-not-found';
      case FirebaseAuthError.wrongPassword:
        return 'wrong-password';
      case FirebaseAuthError.weakPassword:
        return 'weak-password';
      case FirebaseAuthError.emailAlreadyInUse:
        return 'email-already-in-use';
      default:
        return 'internal-error';
    }
  }
}
