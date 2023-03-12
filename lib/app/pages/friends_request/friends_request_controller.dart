import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/models/friend_request.dart';
import 'package:onlymessage/app/pages/friends_request/friends_request_state.dart';
import 'package:onlymessage/app/repositories/friends/friends_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';

class FriendsRequestController extends Cubit<FriendsRequestState> {
  final FriendsRepository _friendsRepository;

  FriendsRequestController(this._friendsRepository)
      : super(FriendsRequestState.initial());

  void load(List<FriendRequest> friendRequestList) {
    emit(state.copyWith(
        status: FriendsRequestStatus.success,
        friendsRequestList: friendRequestList));
  }

  Future<void> hubConnection() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');

    final connection = HubConnectionBuilder().withUrl(
        'http://10.0.2.2:3001/friendrequestnotification', HttpConnectionOptions(
      accessTokenFactory: () async {
        return token;
      },
    )).build();

    await connection.start();

    connection.on('ReceiveFriendRequestNotification', (request) {
      final currentList = [...state.friendsRequestList];

      final newRequest = FriendRequest(
        id: request![0]['id'],
        username: request[0]['userName'],
        uri: request[0]['imageUrl'],
        created: DateTime.now().toString(),
      );

      currentList.add(newRequest);
      emit(state.copyWith(friendsRequestList: currentList));
    });
  }

  void acceptFriendRequest(String id, bool hasAccept, int index) async {
    try {
      final List<FriendRequest> currentList = [...state.friendsRequestList];
      await _friendsRepository.acceptFriendRequest(id, hasAccept);
      currentList.removeAt(index);
      emit(state.copyWith(friendsRequestList: currentList));
    } on Exception catch (e) {
      // TODO
    }
  }
}
