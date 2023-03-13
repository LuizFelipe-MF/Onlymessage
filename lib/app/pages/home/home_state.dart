// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:onlymessage/app/models/friend.dart';
import 'package:onlymessage/app/models/friend_request.dart';
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
  final String localUserId;
  final List<FriendRequest> friendsRequestList;

  const HomeState({
    required this.status,
    required this.user,
    required this.friends,
    required this.localUserId,
    required this.friendsRequestList,
  });

  HomeState.initial()
      : status = HomeStatus.initial,
        user = UserAuth(username: '', imageUrl: ''),
        friends = [],
        localUserId = '',
        friendsRequestList = [];

  @override
  List<Object?> get props => [status, user, friends, friendsRequestList];

  HomeState copyWith({
    HomeStatus? status,
    UserAuth? user,
    List<Friend>? friends,
    String? localUserId,
    List<FriendRequest>? friendsRequestList,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
      friends: friends ?? this.friends,
      localUserId: localUserId ?? this.localUserId,
      friendsRequestList: friendsRequestList ?? this.friendsRequestList,
    );
  }
}
