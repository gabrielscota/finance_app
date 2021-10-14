import 'package:flutter/widgets.dart';

import './translations/translations.dart';

mixin R {
  static Translation string = PtBr();

  static void load(Locale locale) {
    switch (locale.toString()) {
      default:
        string = PtBr();
        break;
    }
  }
}
