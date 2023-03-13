// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:onlymessage/app/models/message.dart';

part 'chat_state.g.dart';

@match
enum ChatStatus {
  initial,
  loading,
  success,
  error,
}

class ChatState extends Equatable {
  final ChatStatus status;
  final List<Message> messages;
  final String localUserId;
  final String? errorMessage;

  const ChatState({
    required this.status,
    required this.messages,
    required this.localUserId,
    this.errorMessage,
  });

  ChatState.initial()
      : status = ChatStatus.initial,
        messages = [],
        localUserId = '',
        errorMessage = null;

  @override
  List<Object?> get props => [status, messages, localUserId, errorMessage];

  ChatState copyWith({
    ChatStatus? status,
    List<Message>? messages,
    String? localUserId,
    String? errorMessage,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      localUserId: localUserId ?? this.localUserId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
