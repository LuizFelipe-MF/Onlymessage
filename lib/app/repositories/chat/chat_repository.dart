import 'package:onlymessage/app/models/message.dart';

abstract class ChatRepository {
  Future<List<Message>> getMessages(String friendId);
  Future<void> sendMessage();
}
