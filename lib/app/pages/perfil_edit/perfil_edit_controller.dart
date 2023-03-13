import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:onlymessage/app/models/user.dart';
import 'package:onlymessage/app/pages/perfil_edit/perfil_edit_state.dart';
import 'package:onlymessage/app/repositories/perfil_edit/perfil_edit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PerfilEditController extends Cubit<PerfilEditState> {
  final PerfilEditRepository _perfilEditRepository;

  PerfilEditController(this._perfilEditRepository)
      : super(PerfilEditState.initial());

  Future<void> updateUserInformations(String username, String password) async {
    try {
      emit(state.copyWith(status: PerfilEditStatus.loading));
      await _perfilEditRepository.updateUserInformations(username, password);

      final sp = await SharedPreferences.getInstance();
      sp.setString('username', username);

      emit(
        state.copyWith(
          status: PerfilEditStatus.success,
          successMessage: 'Informações alteradas com sucesso.',
          user: state.user?.copyWith(username: username),
        ),
      );
    } catch (e) {
      emit(state.copyWith(
          status: PerfilEditStatus.error,
          errorMessage: 'Erro ao tentar alterar informações.'));
    }
  }

  void updateImage(File path) async {
    try {
      emit(state.copyWith(status: PerfilEditStatus.loading));
      final sp = await SharedPreferences.getInstance();
      final res = await _perfilEditRepository.updateUserImage(path);

      sp.setString('imageUrl', res);

      emit(state.copyWith(
          temporaryImage: path,
          status: PerfilEditStatus.success,
          user: state.user?.copyWith(imageUrl: res)));
    } on DioError catch (e) {
      emit(state.copyWith(
          status: PerfilEditStatus.error,
          errorMessage: 'Erro ao tentar alterar foto de perfil.'));
    }
  }

  void load(UserAuth user) {
    emit(state.copyWith(user: user));
  }
}
