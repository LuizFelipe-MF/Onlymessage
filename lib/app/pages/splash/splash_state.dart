// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'splash_state.g.dart';

@match
enum SplashStatus {
  loading,
  success,
  error,
}

class SplashState extends Equatable {
  final SplashStatus status;

  const SplashState({
    required this.status,
  });

  const SplashState.initial() : status = SplashStatus.loading;

  @override
  List<Object> get props => [status];

  SplashState copyWith({
    SplashStatus? status,
  }) {
    return SplashState(
      status: status ?? this.status,
    );
  }
}
