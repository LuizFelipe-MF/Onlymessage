// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:onlymessage/app/models/friend.dart';
import 'package:onlymessage/app/models/user.dart';

part 'home_state.g.dart';

@match
enum HomeStatus {
  initial,
  loading,
  success,
  error,
}

class HomeState extends Equatable {
  final HomeStatus status;
  final UserAuth user;
  final List<Friend> friends;

  const HomeState({
    required this.status,
    required this.user,
    required this.friends,
  });

  HomeState.initial()
      : status = HomeStatus.initial,
        user = UserAuth(username: '', imageUrl: ''),
        friends = [];

  @override
  List<Object?> get props => [status, user, friends];

  HomeState copyWith({
    HomeStatus? status,
    UserAuth? user,
    List<Friend>? friends,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      friends: friends ?? this.friends,
    );
  }
}
