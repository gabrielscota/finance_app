import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

mixin SystemNavigationUIOverlays {
  void statusBarIconBrightness(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Theme.of(context).colorScheme.background,
      statusBarBrightness: Theme.of(context).brightness,
      statusBarIconBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
    ));
  }
}