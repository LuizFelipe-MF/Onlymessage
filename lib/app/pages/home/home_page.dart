import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/helpers/size_extensions.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';
import 'package:onlymessage/app/models/friend.dart';
import 'package:onlymessage/app/models/user.dart';
import 'package:onlymessage/app/pages/home/home_controller.dart';
import 'package:onlymessage/app/pages/home/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  void onReady() async {
    await controller.load();
    controller.getFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: BlocSelector<HomeController, HomeState, UserAuth>(
              selector: (state) => state.user,
              builder: (context, user) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 38.0,
                    horizontal: 20,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/loading.gif',
                          image: 'http://10.0.2.2:3001${user.imageUrl}',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: context.percentWidth(.5),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            user.username,
                            style: context.textStyle.textSemiBold
                                .copyWith(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          PopupMenuButton(
                            color: const Color(0XFF1C1C24),
                            icon: const Icon(
                              Icons.settings_rounded,
                              color: Color(0XFF2F2E3D),
                              size: 32,
                            ),
                            onSelected: (value) async {
                              switch (value) {
                                case 1:
                                  final perfilEditResult =
                                      await Navigator.of(context)
                                          .pushNamed('/perfilEdit', arguments: {
                                    'user': user,
                                  });

                                  if (perfilEditResult != null) {
                                    controller.updateUserData(
                                      perfilEditResult as UserAuth,
                                    );
                                  }
                                  break;
                                case 2:
                                  Navigator.of(context).pushNamed('/addUsers');
                                  break;
                                case 3:
                                  final navigator = Navigator.of(context);
                                  await controller.logout();
                                  navigator.popAndPushNamed('/auth/login');
                                  break;
                                default:
                              }
                            },
                            itemBuilder: (context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                value: 1,
                                child: Text(
                                  'Editar perfil',
                                  style: context.textStyle.textRegular,
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Text(
                                  'Adicionar amigos',
                                  style: context.textStyle.textRegular,
                                ),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Text(
                                  'Sair da conta',
                                  style: context.textStyle.textRegular
                                      .copyWith(color: Colors.red),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          BlocSelector<HomeController, HomeState, List<Friend>>(
            selector: (state) => state.friends,
            builder: (context, friends) {
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                childCount: friends.length,
                (context, index) {
                  final friend = friends[index];
                  
                  return friendCard(friend);
                },
              ));
            },
          )
        ],
      ),
    );
  }

  friendCard(Friend friend) => InkWell(
        onTap: () async {
          final perfilEditResult =
              await Navigator.of(context).pushNamed('/chat', arguments: {
            'friendInformations': friend,
          });
        },
        child: Container(
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
                        image: 'http://10.0.2.2:3001${friend.imageUrl}',
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: context.percentWidth(.6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              friend.username,
                              style: context.textStyle.textMedium
                                  .copyWith(fontSize: 16),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 14,
                            ),
                            Visibility(
                              visible: friend.lastMessage != null,
                              child: Text(
                                friend.lastMessage ?? '',
                                style: context.textStyle.textRegular
                                    .copyWith(color: const Color(0XFF5F5E6D)),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                friendPopupMenu(),
              ],
            ),
          ),
        ),
      );

  friendPopupMenu() => PopupMenuButton(
        color: const Color(0XFF1C1C24),
        icon: const Icon(
          Icons.more_vert_rounded,
          color: Color(0XFF2F2E3D),
          size: 32,
        ),
        onSelected: (value) async {
          switch (value) {
            case 1:
              break;
          }
        },
        itemBuilder: (context) => <PopupMenuEntry>[
          PopupMenuItem(
            value: 1,
            child: Text(
              'Remover amizade',
              style: context.textStyle.textRegular.copyWith(color: Colors.red),
            ),
          )
        ],
      );
}
