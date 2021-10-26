import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

LoginPresenter makeGetxLoginPresenter() => GetxLoginPresenter(
      authentication: makeRemoteUserAuthentication(),
      authenticationWithGoogle: makeRemoteUserGoogleSignIn(),
      saveCurrentUser: makeLocalSaveCurrentUser(),
      validation: makeLoginValidation(),
    );

LoginBiometricPresenter makeGetxLoginBiometricPresenter() => GetxLoginBiometricPresenter(
      loadCurrentUser: makeLocalLoadCurrentUser(),
    );
