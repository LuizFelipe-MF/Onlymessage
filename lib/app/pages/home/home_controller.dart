// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:onlymessage/app/models/friend_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:onlymessage/app/models/user.dart';
import 'package:onlymessage/app/pages/home/home_state.dart';
import 'package:onlymessage/app/repositories/friends/friends_repository.dart';
import 'package:signalr_core/signalr_core.dart';

class HomeController extends Cubit<HomeState> {
  final FriendsRepository _friendRepository;

  HomeController(
    this._friendRepository,
  ) : super(HomeState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading));

    final sp = await SharedPreferences.getInstance();
    final username = sp.getString('username') ?? '';
    final imageUrl = sp.getString('imageUrl') ?? '';

    await getLocalUserId();

    emit(state.copyWith(
      status: HomeStatus.success,
      user: UserAuth(username: username, imageUrl: imageUrl),
    ));
  }

  Future<void> logout() async {
    final sp = await SharedPreferences.getInstance();
    sp.clear();
  }

  void updateUserData(UserAuth perfilEditResult) {
    emit(state.copyWith(user: perfilEditResult));
  }

  Future<void> getFriends() async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));
      final friends = await _friendRepository.getFriends();
      emit(state.copyWith(
        status: HomeStatus.success,
        friends: friends,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        friends: [],
      ));
    }
  }

  Future<void> getFriendRequests() async {
    try {
      emit(state.copyWith(status: HomeStatus.initial));

      final res = await _friendRepository.getFriendsRequest();

      emit(state.copyWith(status: HomeStatus.success, friendsRequestList: res));
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, friendsRequestList: []));
    }
  }

  Future<void> getLocalUserId() async {
    emit(state.copyWith(status: HomeStatus.loading));
    final sp = await SharedPreferences.getInstance();
    final jwt = sp.getString('token') ?? '';

    final decodedJwt = JwtDecoder.decode(jwt);

    emit(state.copyWith(
      status: HomeStatus.success,
      localUserId: decodedJwt['nameid'],
    ));
  }

  Future<void> hubConnection() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');

    final connection = HubConnectionBuilder().withUrl(
        'http://10.0.2.2:3001/chat/messagenotification', HttpConnectionOptions(
      accessTokenFactory: () async {
        return token;
      },
    )).build();

    await connection.start();

    connection.on('ReceiveMessageNotification', (message) {
      getFriends();
    });
  }

  Future<void> friendRequestHubConnection() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');

    final friendRequestConnection = HubConnectionBuilder().withUrl(
        'http://10.0.2.2:3001/friendrequestnotification', HttpConnectionOptions(
      accessTokenFactory: () async {
        return token;
      },
    )).build();

    await friendRequestConnection.start();

    friendRequestConnection.on('ReceiveFriendRequestNotification', (request) {
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

  void updateFriendsRequestList(List<FriendRequest> result) {
    emit(state.copyWith(friendsRequestList: result));
    getFriends();
  }

  removeFriend(String friendId, int index) async {
    try {
      await _friendRepository.removeFriend(friendId);
      final currentFriends = [...state.friends];

      currentFriends.removeAt(index);
      emit(state.copyWith(friends: currentFriends));
    } on Exception catch (e) {
      emit(state.copyWith(status: HomeStatus.error));
    }
  }
}
