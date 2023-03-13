import 'dart:convert';

class Message {
  final String id;
  final String userId;
  final String textMessage;
  final DateTime sendeTime;

  Message({
    required this.id,
    required this.userId,
    required this.textMessage,
    required String sendeTime,
  }) : sendeTime = DateTime.parse(sendeTime);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'textMessage': textMessage,
      'sendeTime': sendeTime,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] as String,
      userId: map['userId'] as String,
      textMessage: map['textMessage'] as String,
      sendeTime: map['sendeTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);
}
