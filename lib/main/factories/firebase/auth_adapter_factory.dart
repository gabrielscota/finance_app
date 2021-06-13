import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/firebase/firebase.dart';
import '../../../infra/firebase/firebase.dart';

FirebaseAuthentication makeFirebaseAuth() => AuthAdapter(
      firebaseAuth: FirebaseAuth.instance,
    );
