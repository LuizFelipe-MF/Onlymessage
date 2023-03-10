import 'package:flutter/material.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import 'package:onlymessage/app/repositories/auth/auth_repository.dart';
import 'package:onlymessage/app/repositories/auth/auth_repository_impl.dart';
import 'package:onlymessage/app/repositories/chat/chat_repository.dart';
import 'package:onlymessage/app/repositories/chat/chat_repository_impl.dart';
import 'package:onlymessage/app/repositories/friends/friends_repository.dart';
import 'package:onlymessage/app/repositories/friends/friends_repository_impl.dart';
import 'package:onlymessage/app/repositories/perfil_edit/perfil_edit_repository.dart';
import 'package:onlymessage/app/repositories/perfil_edit/perfil_edit_repository_impl.dart';
import 'package:onlymessage/app/repositories/user_to_add/user_to_add_repository.dart';
import 'package:onlymessage/app/repositories/user_to_add/user_to_add_repository_impl.dart';
import 'package:provider/provider.dart';

class AplicationBinding extends StatelessWidget {
  final Widget child;

  const AplicationBinding({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CustomDio(),
        ),
        Provider<AuthRepository>(
          create: (context) => AuthRepositoryImpl(
            dio: context.read(),
          ),
        ),
        Provider<PerfilEditRepository>(
          create: (context) => PerfilEditRepositoryImpl(
            dio: context.read(),
          ),
        ),
        Provider<UserToAddRepository>(
          create: (context) => UserToAddRepositoryImpl(
            dio: context.read(),
          ),
        ),
        Provider<FriendsRepository>(
          create: (context) => FriendsRepositoryImpl(
            dio: context.read(),
          ),
        ),
        Provider<ChatRepository>(
          create: (context) => ChatRepositoryImpl(
            dio: context.read(),
          ),
        ),
      ],
      child: child,
    );
  }
}
