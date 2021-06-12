import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

mixin NavigationManager on GetxController {
  final _navigateToWithArgs = Rx<NavigationArguments>(const NavigationArguments(route: ''));
  Stream<NavigationArguments?> get navigateToWithArgsStream => _navigateToWithArgs.stream;
  set navigateToWithArgs(NavigationArguments value) => _navigateToWithArgs.subject.add(value);
}

class NavigationArguments extends Equatable {
  final String route;
  final Object? arguments;

  const NavigationArguments({required this.route, this.arguments});

  @override
  List<Object?> get props => [route, arguments];
}
