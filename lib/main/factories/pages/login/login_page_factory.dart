import 'package:flutter/material.dart';

import '../../../../ui/pages/pages.dart';
import '../../factories.dart';

Widget makeLoginPage() => LoginPage(presenter: makeGetxLoginPresenter());

Widget makeLoginBiometricPage() => LoginBiometricPage(presenter: makeGetxLoginBiometricPresenter());
