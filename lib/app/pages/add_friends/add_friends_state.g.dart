// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_friends_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension AddFriendsStatusMatch on AddFriendsStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == AddFriendsStatus.initial) {
      return initial();
    }

    if (v == AddFriendsStatus.loading) {
      return loading();
    }

    if (v == AddFriendsStatus.success) {
      return success();
    }

    if (v == AddFriendsStatus.error) {
      return error();
    }

    throw Exception('AddFriendsStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == AddFriendsStatus.initial && initial != null) {
      return initial();
    }

    if (v == AddFriendsStatus.loading && loading != null) {
      return loading();
    }

    if (v == AddFriendsStatus.success && success != null) {
      return success();
    }

    if (v == AddFriendsStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
