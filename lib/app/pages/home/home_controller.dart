// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:onlymessage/app/models/friend.dart';
import 'package:onlymessage/app/models/user.dart';
import 'package:onlymessage/app/pages/home/home_state.dart';
import 'package:onlymessage/app/repositories/friends/friends_repository.dart';

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
}
