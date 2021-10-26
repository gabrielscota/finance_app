import 'package:get/get.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

import '../../domain/entities/entities.dart';
import '../../domain/helpers/helpers.dart';
import '../../domain/usecases/usecases.dart';
import '../../ui/helpers/helpers.dart';
import '../../ui/pages/pages.dart';
import '../helpers/helpers.dart';
import '../mixins/mixins.dart';

class GetxLoginBiometricPresenter extends GetxController
    with LoadingManager, NavigationManager, UIErrorManager
    implements LoginBiometricPresenter {
  final LoadCurrentUser loadCurrentUser;

  GetxLoginBiometricPresenter({required this.loadCurrentUser});

  final Rx<LoginBiometricUserViewModel> _currentUser =
      Rx<LoginBiometricUserViewModel>(LoginBiometricUserViewModel.empty());
  Stream<LoginBiometricUserViewModel> get currentUser => _currentUser.stream;

  Future<void> loadAccount() async {
    try {
      final UserEntity user = await loadCurrentUser.load();
      final LoginBiometricUserViewModel userViewModel = user.toLoginBiometricViewModel();
      _currentUser.value = userViewModel;
    } catch (_) {
      mainError = UIError.unexpected;
    }
  }

  Future<void> authWithBiometrics() async {
    try {
      mainError = UIError.noError;
      isLoading = true;
      final _localAuthentication = LocalAuthentication();
      final bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;

      if (canCheckBiometrics) {
        final bool didAuthenticated = await _localAuthentication.authenticate(
          stickyAuth: true,
          localizedReason: 'Autentique-se para continuar',
          useErrorDialogs: false,
          biometricOnly: true,
          androidAuthStrings: const AndroidAuthMessages(
            biometricHint: '',
            biometricNotRecognized: 'Não foi possível reconhecer a digital, tente novamente!',
            biometricRequiredTitle: 'Biometria é obrigatória!',
            biometricSuccess: 'Digital reconhecida com sucesso!',
            cancelButton: 'Cancelar',
            signInTitle: 'Autenticação',
            goToSettingsButton: 'Configurações',
            goToSettingsDescription: 'Por favor configura uma digital.',
          ),
          iOSAuthStrings: const IOSAuthMessages(
            cancelButton: 'Cancelar',
            goToSettingsButton: 'Configurações',
            goToSettingsDescription: 'Por favor, configure um Touch ID.',
            lockOut: 'Por favor, habilite seu Touch ID.',
          ),
        );

        if (didAuthenticated == true) {
          await Future.delayed(const Duration(seconds: 1));
          isLoading = false;
          navigateToWithArgsAndClearStack = const NavigationArguments(route: '/home');
        } else {
          isLoading = false;
        }
      }
    } on DomainError {
      mainError = UIError.unexpected;
      isLoading = false;
    }
  }

  void goToLoginWithPasswordPage() {
    navigateToWithArgs = const NavigationArguments(route: '/login');
  }
}
