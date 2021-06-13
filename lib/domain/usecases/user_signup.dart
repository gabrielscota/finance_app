import 'package:equatable/equatable.dart';

import '../entities/entities.dart';

abstract class UserSignUp {
  Future<String> signUp({required SignUpParams params});
}

class SignUpParams extends Equatable {
  final String email;
  final String password;
  final UserEntity user;

  const SignUpParams({required this.email, required this.user, required this.password});

  @override
  List<Object> get props => [email, password, user];
}
