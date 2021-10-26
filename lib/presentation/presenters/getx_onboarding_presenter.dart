import 'package:get/get.dart';

import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxOnboardingPresenter extends GetxController with NavigationManager implements OnboardingPresenter {
  GetxOnboardingPresenter();

  void goToSignUpPage() {
    navigateToWithArgsAndClearStack = const NavigationArguments(route: '/signup');
  }
}
