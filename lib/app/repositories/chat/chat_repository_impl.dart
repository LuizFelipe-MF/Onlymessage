// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:onlymessage/app/core/exeptions/repository_exeption.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import 'package:onlymessage/app/models/message.dart';
import 'package:onlymessage/app/models/temp_model.dart';

import './chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final CustomDio dio;

  ChatRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<Message>> getMessages(String friendId) async {
    final List<Message> list = [];
    final List<Message> a;
    final List<Message> b;

    try {
      final res = await dio.auth().get('/chat/messages/$friendId');
      final result = res.data.map((e) => TempModel.fromJson(e)).toList();

      if (res.data == null && result == null) {
        return list;
      }

      a = result[0]
          .messages!
          .map(
            (e) => Message(
              id: e.id,
              textMessage: e.textMessage,
              sendeTime: e.sendeTime,
              userId: result[0].id,
            ),
          )
          .toList()
          .cast<Message>();
      b = result[1]
          .messages!
          .map(
            (e) => Message(
              id: e.id,
              textMessage: e.textMessage,
              sendeTime: e.sendeTime,
              userId: result[1].id,
            ),
          )
          .toList()
          .cast<Message>();

      list.addAll(a);
      list.addAll(b);
      list.sort((x, y) => y.sendeTime.compareTo(x.sendeTime));
      return list;
    } on DioError catch (e) {
      return list;
    }
  }

  @override
  Future<String> sendMessage(String receiverId, String textMessage) async {
    try {
      final res = await dio.auth().post('/chat/sendmessage', data: {
        'receiverId': receiverId,
        'textMessage': textMessage,
      });
      return res.data['id'];
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao enviar mensagem');
    }
  }
}
