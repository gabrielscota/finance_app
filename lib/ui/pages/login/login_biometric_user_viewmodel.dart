class LoginBiometricUserViewModel {
  final String name;
  final String avatar;

  LoginBiometricUserViewModel({
    required this.name,
    required this.avatar,
  });

  factory LoginBiometricUserViewModel.empty() {
    return LoginBiometricUserViewModel(
      name: '',
      avatar: '',
    );
  }
}
