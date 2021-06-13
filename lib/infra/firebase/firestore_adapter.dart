import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/firebase/firebase.dart';

class FirestoreAdapter extends CloudFirestore {
  final FirebaseFirestore firebaseFirestore;

  FirestoreAdapter({required this.firebaseFirestore});

  @override
  CollectionReference getCollection({required String collectionName}) {
    try {
      final CollectionReference collectionReference = firebaseFirestore.collection(collectionName);
      return collectionReference;
    } catch (_) {
      throw FirebaseFirestoreError.internalError;
    }
  }

  @override
  Stream<QuerySnapshot> getStreamCollection({required String collectionName}) {
    try {
      final Stream<QuerySnapshot> collectionStream = firebaseFirestore.collection(collectionName).snapshots();
      return collectionStream;
    } catch (_) {
      throw FirebaseFirestoreError.internalError;
    }
  }
}
