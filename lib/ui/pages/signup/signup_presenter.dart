import '../../../presentation/mixins/mixins.dart';
import '../../helpers/helpers.dart';

abstract class SignUpPresenter {
  Stream<NavigationArguments> get navigateToWithArgsAndClearStackStream;

  Stream<bool?> get isLoadingStream;
  Stream<bool?> get isFormValidStream;

  Stream<UIError> get nameErrorStream;
  Stream<UIError> get emailErrorStream;
  Stream<UIError> get cpfErrorStream;
  Stream<UIError> get passwordErrorStream;

  bool get isFormValid;

  void validateName(String value);
  void validateEmail(String value);
  void validateCpf(String value);
  void validatePassword(String value);

  Future<void> signup();
}
