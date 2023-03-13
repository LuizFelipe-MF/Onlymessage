import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

part 'register_state.g.dart';

@match
enum RegisterStatus {
  initial,
  loading,
  success,
  error,
}

class RegisterState extends Equatable {
  final RegisterStatus status;
  final String? errorMessage;

  const RegisterState({
    required this.status,
    this.errorMessage,
  });

  const RegisterState.initial()
      : status = RegisterStatus.initial,
        errorMessage = null;

  @override
  List<Object?> get props => [status, errorMessage];

  RegisterState copyWith({
    RegisterStatus? status,
    String? errorMessage,
  }) {
    return RegisterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
