import '../../../presentation/mixins/mixins.dart';
import '../../helpers/helpers.dart';
import '../pages.dart';

abstract class HomePresenter {
  Stream<NavigationArguments?> get navigateToWithArgsStream;
  Stream<UIError?> get mainErrorStream;

  Stream<HomeUserViewModel> get currentUser;

  Stream<bool> get showBalance;
  void handleShowBalance();

  String get todayDate;

  Future<void> loadAccount();
}
