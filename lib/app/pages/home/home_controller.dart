import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlymessage/app/models/user.dart';
import 'package:onlymessage/app/pages/home/home_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends Cubit<HomeState> {
  HomeController() : super(HomeState.initial());

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
}
