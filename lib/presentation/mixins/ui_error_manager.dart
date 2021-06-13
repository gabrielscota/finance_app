import 'package:get/get.dart';

import '../../ui/helpers/helpers.dart';

mixin UIErrorManager on GetxController {
  final _mainError = Rx<UIError>(UIError.noError);
  Stream<UIError?> get mainErrorStream => _mainError.stream;
  set mainError(UIError value) => _mainError.subject.add(value);
}
