import '../../../presentation/mixins/mixins.dart';
import '../../helpers/helpers.dart';

abstract class LoginPresenter {
  Stream<NavigationArguments?> get navigateToWithArgsStream;
  Stream<UIError?> get emailErrorStream;
  Stream<UIError?> get passwordErrorStream;
  Stream<UIError?> get mainErrorStream;
  Stream<bool?> get isFormValidStream;
  Stream<bool?> get isLoadingStream;

  void validateEmail(String email);
  void validatePassword(String password);
  Future<void> auth();
  Future<void> authWithGoogle();
  void goToSignUp();
}
