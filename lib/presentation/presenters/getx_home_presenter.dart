import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxHomePresenter extends GetxController with NavigationManager, UIErrorManager implements HomePresenter {
  final LoadCurrentUser loadCurrentUser;

  GetxHomePresenter({required this.loadCurrentUser});

  final Rx<HomeUserViewModel> _currentUser = Rx<HomeUserViewModel>(HomeUserViewModel.empty());
  Stream<HomeUserViewModel> get currentUser => _currentUser.stream;

  final Rx<bool> _showBalance = Rx<bool>(false);
  Stream<bool> get showBalance => _showBalance.stream;
  void handleShowBalance() => _showBalance.value = !_showBalance.value;

  String get todayDate => DateFormat('MMMM, d').format(DateTime.now());

  Future<void> loadAccount() async {
    try {
      final UserEntity user = await loadCurrentUser.load();
      final HomeUserViewModel userViewModel = user.toHomeViewModel();
      _currentUser.value = userViewModel;
    } catch (_) {
      mainError = UIError.unexpected;
    }
  }
}
