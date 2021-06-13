import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';
import '../../firebase/firebase.dart';
import '../../models/models.dart';

class RemoteGoogleSignIn implements UserGoogleSignIn {
  final FirebaseAuthentication firebaseAuthentication;
  final CloudFirestore cloudFirestore;

  RemoteGoogleSignIn({
    required this.firebaseAuthentication,
    required this.cloudFirestore,
  });

  @override
  Future<String> authWithGoogle({required GoogleSignUpParams params}) async {
    try {
      final UserCredential? userCredential = await firebaseAuthentication.signInWithGoogle();
      if (userCredential != null) {
        final CollectionReference users = cloudFirestore.getCollection(collectionName: 'users');
        final QuerySnapshot result = await users.where('uid', isEqualTo: userCredential.user?.uid).limit(1).get();
        if (result.docs.isEmpty) {
          final Map<String, dynamic> remoteUser = RemoteUserSignUpModel.fromEntityWithGoogleSignUpParams(
            params.user,
            userCredential.user!.uid,
            userCredential.user!.email!,
            userCredential.user!.displayName!,
          ).toJson();
          users.doc(userCredential.user?.uid).set(remoteUser);
        }
      }

      return userCredential?.user?.uid ?? '';
    } on FirebaseAuthError {
      throw DomainError.unexpected;
    }
  }
}
