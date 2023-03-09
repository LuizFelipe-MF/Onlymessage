import 'package:flutter/widgets.dart';
import 'package:onlymessage/app/pages/home/home_controller.dart';
import 'package:onlymessage/app/pages/home/home_page.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => HomeController(
              context.read(),
            ),
          )
        ],
        child: const HomePage(),
      );
}
