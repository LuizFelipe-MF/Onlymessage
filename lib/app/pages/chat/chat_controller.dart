import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:onlymessage/app/pages/chat/chat_state.dart';
import 'package:onlymessage/app/repositories/chat/chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatController extends Cubit<ChatState> {
  final ChatRepository _chatRepository;

  ChatController(this._chatRepository) : super(ChatState.initial());

  Future<void> getMessages(String friendId) async {
    try {
      emit(state.copyWith(status: ChatStatus.loading));

      final res = await _chatRepository.getMessages(friendId);

      emit(state.copyWith(
        status: ChatStatus.success,
        messages: res,
      ));
    } on DioError catch (e) {
      emit(state.copyWith(
        status: ChatStatus.error,
        messages: [],
      ));
    }
  }

  Future<void> getLocalUserId() async {
    emit(state.copyWith(status: ChatStatus.loading));
    final sp = await SharedPreferences.getInstance();
    final jwt = sp.getString('token') ?? '';

    final decodedJwt = JwtDecoder.decode(jwt);

    emit(state.copyWith(
      status: ChatStatus.success,
      localUserId: decodedJwt['nameid'],
    ));
  }
}
