// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'splash_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension SplashStatusMatch on SplashStatus {
  T match<T>(
      {required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == SplashStatus.loading) {
      return loading();
    }

    if (v == SplashStatus.success) {
      return success();
    }

    if (v == SplashStatus.error) {
      return error();
    }

    throw Exception('SplashStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == SplashStatus.loading && loading != null) {
      return loading();
    }

    if (v == SplashStatus.success && success != null) {
      return success();
    }

    if (v == SplashStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
