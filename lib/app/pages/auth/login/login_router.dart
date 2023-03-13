import 'package:flutter/material.dart';
import 'package:onlymessage/app/pages/auth/login/login_controller.dart';
import 'package:onlymessage/app/pages/auth/login/login_page.dart';
import 'package:provider/provider.dart';

class LoginRouter {
  LoginRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
              create: (context) => LoginController(
                    context.read(),
                  ))
        ],
        child: const LoginPage(),
      );
}
