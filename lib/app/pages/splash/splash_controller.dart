import 'package:bloc/bloc.dart';
import 'package:onlymessage/app/pages/splash/splash_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends Cubit<SplashState> {
  SplashController()
      : super(
          const SplashState.initial(),
        );

  Future<void> verifyAccount() async {
    await Future.delayed(const Duration(seconds: 1));
    final sp = await SharedPreferences.getInstance();
    final hasToken = sp.containsKey('token');

    if (hasToken) {
      emit(state.copyWith(status: SplashStatus.success));
    } else {
      emit(state.copyWith(status: SplashStatus.error));
    }
  }
}
