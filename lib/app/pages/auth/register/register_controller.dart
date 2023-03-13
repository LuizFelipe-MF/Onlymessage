// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';

import 'package:onlymessage/app/pages/auth/register/register_state.dart';
import 'package:onlymessage/app/repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authRepository;

  RegisterController(
    this._authRepository,
  ) : super(const RegisterState.initial());

  Future<void> register(String username, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.loading));
      await _authRepository.register(username, password);
      emit(state.copyWith(status: RegisterStatus.success));
    } catch (e) {
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
