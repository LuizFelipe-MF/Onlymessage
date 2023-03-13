import 'package:flutter/material.dart';
import 'package:onlymessage/app/pages/splash/splash_controller.dart';
import 'package:onlymessage/app/pages/splash/splash_page.dart';
import 'package:provider/provider.dart';

class SplashRouter {
  SplashRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => SplashController(),
          )
        ],
        child: const SplashPage(),
      );
}
