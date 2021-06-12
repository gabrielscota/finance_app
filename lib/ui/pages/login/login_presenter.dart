import '../../../presentation/mixins/mixins.dart';

abstract class LoginPresenter {
  Stream<NavigationArguments?> get navigateToWithArgsStream;

  void goToHomePage();
}
