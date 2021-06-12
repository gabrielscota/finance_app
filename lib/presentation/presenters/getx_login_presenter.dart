import 'package:get/get.dart';

import '../../ui/pages/pages.dart';
import '../mixins/mixins.dart';

class GetxLoginPresenter extends GetxController with NavigationManager implements LoginPresenter {
  @override
  void goToHomePage() {
    navigateToWithArgs = const NavigationArguments(route: '/home');
  }
}
