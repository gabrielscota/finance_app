import '../../../presentation/mixins/mixins.dart';
import '../pages.dart';

abstract class LoginBiometricPresenter {
  Stream<NavigationArguments?> get navigateToWithArgsStream;
  Stream<NavigationArguments?> get navigateToWithArgsAndClearStackStream;
  Stream<LoginBiometricUserViewModel> get currentUser;
  Stream<bool?> get isLoadingStream;

  Future<void> loadAccount();
  Future<void> authWithBiometrics();

  void goToLoginWithPasswordPage();
}
