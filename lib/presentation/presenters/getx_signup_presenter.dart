import 'dart:convert';

import 'package:get/get.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';
import '../protocols/protocols.dart';

class GetxSignUpPresenter extends GetxController
    with FormManager, LoadingManager, NavigationManager, UIErrorManager
    implements SignUpPresenter {
  final UserSignUp userSignUp;
  final SaveCurrentUser saveCurrentUser;
  final Validation validation;

  GetxSignUpPresenter({
    required this.userSignUp,
    required this.saveCurrentUser,
    required this.validation,
  });

  final RxString _name = ''.obs;
  final Rx<UIError> _nameError = Rx<UIError>(UIError.noError);
  Stream<UIError> get nameErrorStream => _nameError.stream;

  final RxString _email = ''.obs;
  final Rx<UIError> _emailError = Rx<UIError>(UIError.noError);
  Stream<UIError> get emailErrorStream => _emailError.stream;

  final RxString _cpf = ''.obs;
  final Rx<UIError> _cpfError = Rx<UIError>(UIError.noError);
  Stream<UIError> get cpfErrorStream => _cpfError.stream;

  final RxString _password = ''.obs;
  final Rx<UIError> _passwordError = Rx<UIError>(UIError.noError);
  Stream<UIError> get passwordErrorStream => _passwordError.stream;

  void validateName(String value) {
    _name.value = value;
    _nameError.value = _validateField('name');
    _validateForm();
  }

  void validateEmail(String value) {
    _email.value = value;
    _emailError.value = _validateField('email');
    _validateForm();
  }

  void validateCpf(String value) {
    _cpf.value = value;
    _cpfError.value = _validateField('cpf');
    _validateForm();
  }

  void validatePassword(String value) {
    _password.value = value;
    _passwordError.value = _validateField('password');
    _validateForm();
  }

  UIError _validateField(String field) {
    final formData = {
      'name': _name.value,
      'email': _email.value,
      'cpf': _cpf.value,
      'password': _password.value,
    };
    final error = validation.validate(field: field, input: formData);
    switch (error) {
      case ValidationError.invalidField:
        return UIError.invalidField;
      case ValidationError.requiredField:
        return UIError.requiredField;
      case ValidationError.invalidCpf:
        return UIError.invalidCpf;
      case ValidationError.noError:
        return UIError.noError;
      default:
        return UIError.noError;
    }
  }

  void _validateForm() {
    isFormValid = _nameError.value == UIError.noError &&
        _emailError.value == UIError.noError &&
        _cpfError.value == UIError.noError &&
        _passwordError.value == UIError.noError &&
        _name.value != '' &&
        _email.value != '' &&
        _cpf.value != '' &&
        _password.value != '';
  }

  Future<void> signup() async {
    try {
      mainError = UIError.noError;
      isLoading = true;
      final Map<String, dynamic> user = await userSignUp.signUp(
        params: SignUpParams(
          email: _email.value,
          user: UserEntity(
            uid: '',
            email: _email.value,
            username: _email.value.split('@')[0],
            cpf: _cpf.value,
            avatar: '',
            name: _name.value,
            useBiometric: false,
            createdAt: DateTime.now().toIso8601String(),
            updatedAt: DateTime.now().toIso8601String(),
            deletedAt: '',
          ),
          password: _password.value,
        ),
      );
      if (user['uid'] != null && (user['uid'].toString()).isNotEmpty) {
        await saveCurrentUser.save(userJson: jsonEncode(user));
        isLoading = false;
        navigateToWithArgsAndClearStack = const NavigationArguments(route: '/home');
      }
    } on DomainError catch (error) {
      switch (error) {
        case DomainError.invalidCredentials:
          mainError = UIError.invalidCredentials;
          break;
        default:
          mainError = UIError.unexpected;
          break;
      }
    } finally {
      isLoading = false;
    }
  }
}
