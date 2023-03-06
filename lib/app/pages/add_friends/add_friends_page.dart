import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/helpers/size_extensions.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';
import 'package:onlymessage/app/models/users_to_add.dart';
import 'package:onlymessage/app/pages/add_friends/add_friends_controller.dart';
import 'package:onlymessage/app/pages/add_friends/add_friends_state.dart';

class AddFriendsPage extends StatefulWidget {
  const AddFriendsPage({super.key});

  @override
  State<AddFriendsPage> createState() => _AddFriendsPageState();
}

class _AddFriendsPageState
    extends BaseState<AddFriendsPage, AddFriendsController> {
  final _searchEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Adicionar amigos',
          style: context.textStyle.textMedium
              .copyWith(color: const Color(0XFF5F5E6D)),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (value) {
                  controller.searchUsers(value);
                },
                controller: _searchEC,
                style: context.textStyle.textRegular.copyWith(fontSize: 16),
                decoration: InputDecoration(
                  suffixIcon: const Icon(
                    Icons.search,
                    color: Color(
                      0XFF5F5E6D,
                    ),
                    size: 22,
                  ),
                  hintText: 'Buscar...',
                  hintStyle: context.textStyle.textRegular.copyWith(
                    fontSize: 16,
                    color: const Color(0XFF5F5E6D),
                  ),
                ),
              ),
            ),
          ),
          BlocSelector<AddFriendsController, AddFriendsState, List<UsersToAdd>>(
            selector: (state) => state.users,
            builder: (context, users) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: users.length,
                  (context, index) {
                    final UsersToAdd user = users[index];

                    return userCard(user);
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  userCard(UsersToAdd user) => Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Color(0XFF2F2E3D),
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 16,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: FadeInImage.assetNetwork(
                      placeholder: 'assets/images/loading.gif',
                      image: 'http://10.0.2.2:3001${user.imageUrl}',
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: context.percentWidth(.6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Text(
                        user.username,
                        style:
                            context.textStyle.textMedium.copyWith(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              user.isAlredyRequested
                  ? const Icon(
                      Icons.check,
                      color: Color(0XFF2F2E3D),
                      size: 36,
                    )
                  : IconButton(
                      onPressed: () {
                        controller.addUser(user.id, _searchEC.text);
                      },
                      icon: const Icon(
                        Icons.person_add_alt_1_rounded,
                        color: Color(0XFF2F2E3D),
                        size: 36,
                      ),
                    )
            ],
          ),
        ),
      );
}
