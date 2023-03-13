import 'dart:convert';

class LastMessage {
  final String id;
  final String textMessage;
  final String sendeTime;
  final String whoSend;

  LastMessage({
    required this.id,
    required this.textMessage,
    required this.sendeTime,
    required this.whoSend,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'textMessage': textMessage,
      'sendeTime': sendeTime,
      'whoSend': whoSend,
    };
  }

  factory LastMessage.fromMap(Map<String, dynamic> map) {
    return LastMessage(
      id: map['id'] as String,
      textMessage: map['textMessage'] as String,
      sendeTime: map['sendeTime'] as String,
      whoSend: map['whoSend'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LastMessage.fromJson(String source) =>
      LastMessage.fromMap(json.decode(source) as Map<String, dynamic>);
}
