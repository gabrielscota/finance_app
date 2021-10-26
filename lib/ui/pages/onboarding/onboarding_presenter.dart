import '../../../presentation/mixins/mixins.dart';

abstract class OnboardingPresenter {
  Stream<NavigationArguments> get navigateToWithArgsAndClearStackStream;

  void goToSignUpPage();
}
