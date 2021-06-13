import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';
import '../protocols/protocols.dart';

class GetxLoginPresenter extends GetxController
    with FormManager, LoadingManager, NavigationManager, UIErrorManager
    implements LoginPresenter {
  final UserAuthentication authentication;
  final UserGoogleSignIn authenticationWithGoogle;
  final SaveCurrentUser saveCurrentUser;
  final Validation validation;

  String _email = '';
  String _password = '';

  final Rx<UIError> _emailError = Rx<UIError>(UIError.noError);
  final Rx<UIError> _passwordError = Rx<UIError>(UIError.noError);

  Stream<UIError?> get emailErrorStream => _emailError.stream;
  Stream<UIError?> get passwordErrorStream => _passwordError.stream;

  GetxLoginPresenter({
    required this.validation,
    required this.authentication,
    required this.authenticationWithGoogle,
    required this.saveCurrentUser,
  });

  void validateEmail(String email) {
    _email = email;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  void validatePassword(String password) {
    _password = password;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'email': _email,
      'password': _password,
    };
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      case ValidationError.noError:
        return UIError.noError;
    }
  }

  void _validateForm() {
    isFormValid = _emailError.value == UIError.noError &&
        _passwordError.value == UIError.noError &&
        _email != '' &&
        _password != '';
  }

  Future<void> auth() async {
    try {
      mainError = UIError.noError;
      isLoading = true;
      await Future.delayed(const Duration(seconds: 2));
      final userUID = await authentication.auth(
        params: AuthenticationParams(email: _email, password: _password),
      );
      await saveCurrentUser.save(userUID: userUID);
      navigateToWithArgs = const NavigationArguments(route: '/home');
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          mainError = UIError.invalidCredentials;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
      isLoading = false;
    }
  }

  Future<void> authWithGoogle() async {
    try {
      mainError = UIError.noError;
      isLoading = true;
      await Future.delayed(const Duration(seconds: 2));
      final userUID = await authenticationWithGoogle.authWithGoogle(
        params: GoogleSignUpParams(
          user: UserEntity(
            uid: '',
            email: '',
            username: '',
            avatar: '',
            name: '',
            createdAt: DateTime.now().toIso8601String(),
            updatedAt: DateTime.now().toIso8601String(),
            deletedAt: '',
          ),
        ),
      );
      await saveCurrentUser.save(userUID: userUID);
      isLoading = false;
      navigateToWithArgs = const NavigationArguments(route: '/home');
    } on DomainError {
      mainError = UIError.unexpected;
      isLoading = false;
    }
  }

  void goToSignUp() {
    navigateToWithArgs = const NavigationArguments(route: '/signup');
  }
}
