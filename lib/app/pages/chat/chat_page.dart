import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/helpers/size_extensions.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';
import 'package:onlymessage/app/models/friend.dart';
import 'package:onlymessage/app/models/message.dart';
import 'package:onlymessage/app/pages/chat/chat_controller.dart';
import 'package:onlymessage/app/pages/chat/chat_state.dart';

class ChatPage extends StatefulWidget {
  final Friend friendInformations;

  const ChatPage({
    super.key,
    required this.friendInformations,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends BaseState<ChatPage, ChatController> {
  final _sendMessageEC = TextEditingController();

  @override
  void onReady() async {
    await controller.hubConnection();
    await controller.getLocalUserId();
    await controller.getMessages(widget.friendInformations.friendId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 2,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image:
                    'http://10.0.2.2:3001${widget.friendInformations.imageUrl}',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            SizedBox(
              width: context.percentWidth(0.5),
              child: Text(
                widget.friendInformations.username,
                style: context.textStyle.textRegular.copyWith(fontSize: 18),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
      body: Stack(
        children: [
          CustomScrollView(
            reverse: true,
            slivers: [
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              ),
              BlocSelector<ChatController, ChatState, List<Message>>(
                selector: (state) => state.messages,
                builder: (context, messages) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: messages.length,
                      (context, index) {
                        final message = messages[index];
                        final localId = controller.state.localUserId;

                        return _messages(message, localId);
                      },
                    ),
                  );
                },
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 32,
                ),
              ),
            ],
          ),
          Positioned(
              child: Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _sendMessageEC,
                      style:
                          context.textStyle.textRegular.copyWith(fontSize: 16),
                      decoration: InputDecoration(
                          hintText: 'Digite algo...',
                          hintStyle: context.textStyle.textRegular
                              .copyWith(color: const Color(0XFF5F5E6D)),
                          filled: true,
                          fillColor: const Color(0XFF1C1C24)),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Color(0XFF2F2E3D)),
                    child: IconButton(
                      onPressed: () {
                        if (_sendMessageEC.text.isNotEmpty) {
                          controller.sendMessage(
                              widget.friendInformations.friendId,
                              _sendMessageEC.text);
                          _sendMessageEC.clear();
                        }
                      },
                      icon: const Icon(Icons.send_rounded),
                      color: const Color(0XFF5F5E6D),
                      iconSize: 32,
                    ),
                  ),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }

  Widget _messages(Message message, String localId) {
    if (message.userId == localId) {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              constraints: BoxConstraints(
                  minWidth: 10, maxWidth: context.percentWidth(.55)),
              decoration: const BoxDecoration(
                color: Color(0XFF2C176A),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  message.textMessage,
                  style: context.textStyle.textMedium.copyWith(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image:
                        'http://10.0.2.2:3001${widget.friendInformations.imageUrl}',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  widget.friendInformations.username,
                  style: context.textStyle.textMedium
                      .copyWith(color: const Color(0xFF5F5E6D), fontSize: 14),
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Container(
                constraints: BoxConstraints(
                    minWidth: 10, maxWidth: context.percentWidth(.55)),
                decoration: const BoxDecoration(
                  color: Color(0XFF1C1C24),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    message.textMessage,
                    style: context.textStyle.textMedium.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
      );
    }
  }
}
