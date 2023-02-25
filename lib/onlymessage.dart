import 'package:flutter/material.dart';
import 'package:onlymessage/app/core/provider/aplication_binding.dart';
import 'package:onlymessage/app/core/ui/theme/theme_config.dart';
import 'package:onlymessage/app/pages/splash/splash_page.dart';

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
          '/': (context) => const SplashPage(),
        },
      ),
    );
  }
}
