// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends_request_state.dart';

// **************************************************************************
// MatchExtensionGenerator
// **************************************************************************

extension FriendsRequestStatusMatch on FriendsRequestStatus {
  T match<T>(
      {required T Function() initial,
      required T Function() loading,
      required T Function() success,
      required T Function() error}) {
    final v = this;
    if (v == FriendsRequestStatus.initial) {
      return initial();
    }

    if (v == FriendsRequestStatus.loading) {
      return loading();
    }

    if (v == FriendsRequestStatus.success) {
      return success();
    }

    if (v == FriendsRequestStatus.error) {
      return error();
    }

    throw Exception(
        'FriendsRequestStatus.match failed, found no match for: $this');
  }

  T matchAny<T>(
      {required T Function() any,
      T Function()? initial,
      T Function()? loading,
      T Function()? success,
      T Function()? error}) {
    final v = this;
    if (v == FriendsRequestStatus.initial && initial != null) {
      return initial();
    }

    if (v == FriendsRequestStatus.loading && loading != null) {
      return loading();
    }

    if (v == FriendsRequestStatus.success && success != null) {
      return success();
    }

    if (v == FriendsRequestStatus.error && error != null) {
      return error();
    }

    return any();
  }
}
