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
  Future<Map<String, dynamic>> authWithGoogle() async {
    try {
      Map<String, dynamic> remoteUser = {};
      final UserCredential? userCredential = await firebaseAuthentication.signInWithGoogle();
      if (userCredential != null) {
        final CollectionReference users = cloudFirestore.getCollection(collectionName: 'users');
        final QuerySnapshot result = await users.where('uid', isEqualTo: userCredential.user?.uid).limit(1).get();
        if (result.docs.isEmpty) {
          remoteUser = RemoteUserSignUpModel.fromEntityWithGoogleSignUpParams(
            userCredential.user!.uid,
            userCredential.user!.email!,
            userCredential.user!.photoURL!,
            userCredential.user!.displayName!,
            DateTime.now().toIso8601String(),
            DateTime.now().toIso8601String(),
          ).toJson();
          users.doc(userCredential.user?.uid).set(remoteUser);
          return remoteUser;
        } else {
          return result.docs.first.data() as Map<String, dynamic>;
        }
      } else {
        return {};
      }
    } on FirebaseAuthError {
      throw DomainError.unexpected;
    }
  }
}
