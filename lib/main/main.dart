import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import '../ui/components/components.dart';
import 'factories/factories.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: _navigatorKey,
      title: 'Fi-Nance',
      darkTheme: AppTheme.darkThemeData,
      defaultTransition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      enableLog: true,
      theme: AppTheme.lightThemeData,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('pt', 'BR'),
      ],
      fallbackLocale: const Locale('pt', 'BR'),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: makeSplashPage,
          transition: Transition.noTransition,
          transitionDuration: const Duration(milliseconds: 0),
        ),
        GetPage(
          title: 'Home Page',
          name: '/home',
          page: makeHomePage,
        ),
        GetPage(
          title: 'Login Page',
          name: '/login',
          page: makeLoginPage,
        ),
        GetPage(
          title: 'Login Biometric Page',
          name: '/login/biometric',
          page: makeLoginBiometricPage,
        ),
        GetPage(
          title: 'Onboarding Page',
          name: '/onboarding',
          page: makeOnboardingPage,
        ),
        GetPage(
          title: 'SignUp Page',
          name: '/signup',
          page: makeSignUpPage,
        ),
      ],
      unknownRoute: GetPage(
        title: 'Unknow Page',
        name: '/unknow',
        page: makeUnknowPage,
      ),
    );
  }
}
