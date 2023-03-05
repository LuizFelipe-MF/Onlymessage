// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

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

  const HomeState({
    required this.status,
    required this.user,
  });

  HomeState.initial()
      : status = HomeStatus.initial,
        user = UserAuth(username: '', imageUrl: '');

  @override
  List<Object?> get props => [status, user];

  HomeState copyWith({
    HomeStatus? status,
    UserAuth? user,
  }) {
    return HomeState(
      status: status ?? this.status,
      user: user ?? this.user,
    );
  }
}
