import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';
import '../../models/models.dart';

class RemoteSignUp implements UserSignUp {
  final FirebaseAuthentication firebaseAuthentication;
  final CloudFirestore cloudFirestore;

  RemoteSignUp({
    required this.firebaseAuthentication,
    required this.cloudFirestore,
  });

  @override
  Future<String> signUp({required SignUpParams params}) async {
    try {
      final UserCredential userCredential = await firebaseAuthentication.signUpWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      final CollectionReference users = cloudFirestore.getCollection(collectionName: 'users');
      final Map<String, dynamic> remoteUser =
          RemoteUserSignUpModel.fromEntityWithUid(params.user, userCredential.user!.uid).toJson();
      users.doc(userCredential.user?.uid).set(remoteUser);
      return userCredential.user?.uid ?? '';
    } on FirebaseAuthError catch (error) {
      switch (error) {
        case FirebaseAuthError.weakPassword:
          throw DomainError.weakPassword;
        case FirebaseAuthError.emailAlreadyInUse:
          throw DomainError.emailInUse;
        default:
          throw DomainError.unexpected;
      }
    }
  }
}
