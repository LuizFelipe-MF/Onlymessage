// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'perfil_edit_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension PerfilEditStatusMatch on PerfilEditStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == PerfilEditStatus.initial) {
      return initial();
    }

    if (v == PerfilEditStatus.loading) {
      return loading();
    }

    if (v == PerfilEditStatus.success) {
      return success();
    }

    if (v == PerfilEditStatus.error) {
      return error();
    }

    throw Exception('PerfilEditStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == PerfilEditStatus.initial && initial != null) {
      return initial();
    }

    if (v == PerfilEditStatus.loading && loading != null) {
      return loading();
    }

    if (v == PerfilEditStatus.success && success != null) {
      return success();
    }

    if (v == PerfilEditStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
