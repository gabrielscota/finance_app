import '../../../../presentation/presenters/presenters.dart';
import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

SignUpPresenter makeGetxSignUpPresenter() => GetxSignUpPresenter(
      userSignUp: makeRemoteUserSignUp(),
      saveCurrentUser: makeLocalSaveCurrentUser(),
      validation: makeSignUpValidation(),
    );
