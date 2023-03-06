import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/helpers/size_extensions.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';
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
  void onReady() {
    controller.load();
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
          )
        ],
      ),
    );
  }
}
