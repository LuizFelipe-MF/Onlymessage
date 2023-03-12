// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/core/ui/base_state/base_state.dart';
import 'package:onlymessage/app/core/ui/helpers/size_extensions.dart';
import 'package:onlymessage/app/core/ui/styles/text_styles.dart';

import 'package:onlymessage/app/models/friend_request.dart';
import 'package:onlymessage/app/pages/friends_request/friends_request_controller.dart';
import 'package:onlymessage/app/pages/friends_request/friends_request_state.dart';

class FriendsRequestPage extends StatefulWidget {
  final List<FriendRequest> friendRequestList;

  const FriendsRequestPage({
    super.key,
    required this.friendRequestList,
  });

  @override
  State<FriendsRequestPage> createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState
    extends BaseState<FriendsRequestPage, FriendsRequestController> {
  @override
  void onReady() {
    controller.load(widget.friendRequestList);
    controller.hubConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos de amizade'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(controller.state.friendsRequestList);
          return false;
        },
        child: BlocSelector<FriendsRequestController, FriendsRequestState,
            List<FriendRequest>>(
          selector: (state) => state.friendsRequestList,
          builder: (context, friendsRequestList) {
            return ListView.builder(
              itemCount: friendsRequestList.length,
              itemBuilder: (context, index) {
                final friendRequest = friendsRequestList[index];
                return friendRequestCard(friendRequest, index);
              },
            );
          },
        ),
      ),
    );
  }

  friendRequestCard(FriendRequest friendRequest, int index) {
    return Container(
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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/loading.gif',
                image: 'http://10.0.2.2:3001${friendRequest.uri}',
                width: 64,
                height: 64,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: context.percentWidth(.4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Text(
                  friendRequest.username,
                  style: context.textStyle.textMedium.copyWith(fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                controller.acceptFriendRequest(friendRequest.id, false, index);
              },
              icon: const Icon(
                Icons.close,
                color: Color(0XFFD02B2B),
                size: 32,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            IconButton(
              onPressed: () {
                controller.acceptFriendRequest(friendRequest.id, true, index);
              },
              icon: const Icon(
                Icons.check,
                color: Color(0XFF13A021),
                size: 32,
              ),
            )
          ],
        ),
      ),
    );
  }
}
