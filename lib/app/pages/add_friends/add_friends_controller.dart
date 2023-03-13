import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:onlymessage/app/pages/add_friends/add_friends_state.dart';
import 'package:onlymessage/app/repositories/user_to_add/user_to_add_repository.dart';

class AddFriendsController extends Cubit<AddFriendsState> {
  final UserToAddRepository _userToAddRepository;

  AddFriendsController(this._userToAddRepository)
      : super(AddFriendsState.initial());

  Future<void> searchUsers(String search) async {
    try {
      emit(state.copyWith(status: AddFriendsStatus.loading));
      final res = await _userToAddRepository.getUsers(search);
      emit(
        state.copyWith(status: AddFriendsStatus.success, users: res),
      );
    } catch (e) {
      emit(state.copyWith(
        status: AddFriendsStatus.error,
        users: [],
      ));
    }
  }

  void addUser(String id, String search) async {
    try {
      await _userToAddRepository.addUser(id);
      searchUsers(search);
    } on DioError catch (e) {
      emit(state.copyWith(status: AddFriendsStatus.error));
    }
  }
}
