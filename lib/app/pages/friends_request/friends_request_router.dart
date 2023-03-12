import 'package:flutter/widgets.dart';
import 'package:onlymessage/app/pages/friends_request/friends_request_controller.dart';
import 'package:onlymessage/app/pages/friends_request/friends_request_page.dart';
import 'package:provider/provider.dart';

class FriendsRequestRouter {
  FriendsRequestRouter._();

  static Widget get page => MultiProvider(providers: [
        Provider(
          create: (context) => FriendsRequestController(
            context.read(),
          ),
          builder: (context, child) {
            final args = ModalRoute.of(context)!.settings.arguments
                as Map<String, dynamic>;

            return FriendsRequestPage(
              friendRequestList: args['friendRequestList'],
            );
          },
        )
      ]);
}
