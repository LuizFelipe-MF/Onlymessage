import 'package:flutter/material.dart';
import 'package:onlymessage/app/pages/add_friends/add_friends_controller.dart';
import 'package:onlymessage/app/pages/add_friends/add_friends_page.dart';
import 'package:provider/provider.dart';

class AddFriendsRouter {
  AddFriendsRouter._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => AddFriendsController(
              context.read(),
            ),
          )
        ],
        child: const AddFriendsPage(),
      );
}
