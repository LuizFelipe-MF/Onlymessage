import 'package:flutter/widgets.dart';
import 'package:onlymessage/app/pages/perfil_edit/perfil_edit_controller.dart';
import 'package:onlymessage/app/pages/perfil_edit/perfil_edit_page.dart';
import 'package:provider/provider.dart';

class PerfilEditRouter {
  PerfilEditRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => PerfilEditController(
              context.read(),
            ),
          )
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          return PerfilEditPage(
            user: args['user'],
          );
        },
      );
}
