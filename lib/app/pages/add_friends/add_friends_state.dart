// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:onlymessage/app/models/users_to_add.dart';

part 'add_friends_state.g.dart';

@match
enum AddFriendsStatus {
  initial,
  loading,
  success,
  error,
}

class AddFriendsState extends Equatable {
  final AddFriendsStatus status;
  final List<UsersToAdd> users;

  const AddFriendsState({
    required this.status,
    required this.users,
  });

  AddFriendsState.initial()
      : status = AddFriendsStatus.initial,
        users = [];

  @override
  List<Object?> get props => [status, users];

  AddFriendsState copyWith({
    AddFriendsStatus? status,
    List<UsersToAdd>? users,
  }) {
    return AddFriendsState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
