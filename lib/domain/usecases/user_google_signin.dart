import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class UserGoogleSignIn {
  Future<String> authWithGoogle({required GoogleSignUpParams params});
}

class GoogleSignUpParams extends Equatable {
  final UserEntity user;

  const GoogleSignUpParams({required this.user});

  @override
  List<Object> get props => [user];
}
