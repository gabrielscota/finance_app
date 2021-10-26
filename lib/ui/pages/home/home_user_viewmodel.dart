class HomeUserViewModel {
  final String name;
  final String avatar;

  HomeUserViewModel({
    required this.name,
    required this.avatar,
  });

  factory HomeUserViewModel.empty() {
    return HomeUserViewModel(
      name: '',
      avatar: '',
    );
  }
}
