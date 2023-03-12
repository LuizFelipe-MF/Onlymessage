import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:onlymessage/app/models/message.dart';
import 'package:onlymessage/app/pages/chat/chat_state.dart';
import 'package:onlymessage/app/repositories/chat/chat_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signalr_core/signalr_core.dart';

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

  Future<void> sendMessage(String receiverId, String textMessage) async {
    try {
      emit(state.copyWith(status: ChatStatus.loading));
      final res = await _chatRepository.sendMessage(receiverId, textMessage);

      final newMessage = Message(
          id: res,
          userId: state.localUserId,
          textMessage: textMessage,
          sendeTime: DateTime.now().toString());

      addNewMessages(newMessage);
    } on DioError catch (e) {
      emit(state.copyWith(status: ChatStatus.error));
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

  Future<void> hubConnection() async {
    final sp = await SharedPreferences.getInstance();
    final token = sp.getString('token');

    final connection = HubConnectionBuilder().withUrl(
        'http://10.0.2.2:3001/chat/messagenotification', HttpConnectionOptions(
      accessTokenFactory: () async {
        return token;
      },
    )).build();

    await connection.start();

    connection.on('ReceiveMessageNotification', (message) {
      final newMessage = Message(
          id: message?[0]['message']['id'],
          userId: message?[0]['id'],
          textMessage: message?[0]['message']['textMessage'],
          sendeTime: message?[0]['message']['sendeTime']);

      addNewMessages(newMessage);
    });
  }

  void addNewMessages(Message message) {
    final currentMessages = [...state.messages];
    currentMessages.add(message);
    currentMessages.sort((x, y) => y.sendeTime.compareTo(x.sendeTime));
    emit(state.copyWith(
      messages: currentMessages,
    ));
  }
}
