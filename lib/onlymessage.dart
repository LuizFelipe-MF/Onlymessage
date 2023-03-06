import 'package:flutter/material.dart';
import 'package:onlymessage/app/core/provider/aplication_binding.dart';
import 'package:onlymessage/app/core/ui/theme/theme_config.dart';
import 'package:onlymessage/app/pages/add_friends/add_friends_router.dart';
import 'package:onlymessage/app/pages/auth/login/login_router.dart';
import 'package:onlymessage/app/pages/auth/register/register_router.dart';
import 'package:onlymessage/app/pages/home/home_router.dart';
import 'package:onlymessage/app/pages/perfil_edit/perfil_edit_router.dart';
import 'package:onlymessage/app/pages/splash/splash_router.dart';

class Onlymessage extends StatelessWidget {
  const Onlymessage({super.key});

  @override
  Widget build(BuildContext context) {
    return AplicationBinding(
      child: MaterialApp(
        theme: ThemeConfig.theme,
        debugShowCheckedModeBanner: false,
        title: 'Onlymessage',
        routes: {
          '/': (context) => SplashRouter.page,
          '/home': (context) => HomeRouter.page,
          '/auth/login': (context) => LoginRouter.page,
          '/auth/register': (context) => RegisterRouter.page,
          '/perfilEdit': (context) => PerfilEditRouter.page,
          '/addUsers': (context) => AddFriendsRouter.page,
        },
      ),
    );
  }
}
