// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';
import 'package:onlymessage/app/models/friend_request.dart';

part 'friends_request_state.g.dart';
@match
enum FriendsRequestStatus {
  initial,
  loading,
  success,
  error,
}

class FriendsRequestState extends Equatable {
  final FriendsRequestStatus status;
  final List<FriendRequest> friendsRequestList;

  const FriendsRequestState({
    required this.status,
    required this.friendsRequestList,
  });

  FriendsRequestState.initial()
      : status = FriendsRequestStatus.initial,
        friendsRequestList = [];

  @override
  List<Object> get props => [status, friendsRequestList];

  FriendsRequestState copyWith({
    FriendsRequestStatus? status,
    List<FriendRequest>? friendsRequestList,
  }) {
    return FriendsRequestState(
      status: status ?? this.status,
      friendsRequestList: friendsRequestList ?? this.friendsRequestList,
    );
  }
}
