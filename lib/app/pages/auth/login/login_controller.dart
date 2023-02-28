import 'package:bloc/bloc.dart';
import 'package:onlymessage/app/core/exeptions/unauthorize_exeption.dart';
import 'package:onlymessage/app/pages/auth/login/login_state.dart';
import 'package:onlymessage/app/repositories/auth/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository _authRepository;

  LoginController(this._authRepository)
      : super(
          const LoginState.initial(),
        );

  Future<void> login(String username, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.loading));

      final authModel = await _authRepository.login(username, password);
      final sp = await SharedPreferences.getInstance();

      sp.setString('token', authModel.token);
      sp.setString('refreshToken', authModel.refreshToken);
      sp.setString('username', authModel.user.imageUrl);
      sp.setString('imageUrl', authModel.user.imageUrl);

      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedExeption catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.loginError,
            errorMessage: 'E-mail ou senha incorretos.'),
      );
    } catch (e) {
      emit(
        state.copyWith(
            status: LoginStatus.error, errorMessage: 'Erro ao realizar login.'),
      );
    }
  }
}
