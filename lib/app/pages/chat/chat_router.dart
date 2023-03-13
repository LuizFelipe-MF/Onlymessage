import 'package:flutter/widgets.dart';
import 'package:onlymessage/app/pages/chat/chat_controller.dart';
import 'package:onlymessage/app/pages/chat/chat_page.dart';
import 'package:provider/provider.dart';

class ChatRouter {
  ChatRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ChatController(
              context.read(),
            ),
          )
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;

          return ChatPage(
            friendInformations: args['friendInformations'],
          );
        },
      );
}
