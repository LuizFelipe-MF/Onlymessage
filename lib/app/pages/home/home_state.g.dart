// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension HomeStatusMatch on HomeStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == HomeStatus.initial) {
      return initial();
    }

    if (v == HomeStatus.loading) {
      return loading();
    }

    if (v == HomeStatus.success) {
      return success();
    }

    if (v == HomeStatus.error) {
      return error();
    }

    throw Exception('HomeStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == HomeStatus.initial && initial != null) {
      return initial();
    }

    if (v == HomeStatus.loading && loading != null) {
      return loading();
    }

    if (v == HomeStatus.success && success != null) {
      return success();
    }

    if (v == HomeStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
