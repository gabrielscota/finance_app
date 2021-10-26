import '../../../domain/entities/entities.dart';
import '../../../ui/pages/pages.dart';

extension UserViewModelExtension on UserEntity {
  HomeUserViewModel toHomeViewModel() => HomeUserViewModel(
        name: name,
        avatar: avatar,
      );

  LoginBiometricUserViewModel toLoginBiometricViewModel() => LoginBiometricUserViewModel(
        name: name,
        avatar: avatar,
      );
}
