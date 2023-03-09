import 'dart:convert';

import 'package:onlymessage/app/models/user.dart';

class Friend extends UserAuth {
  final String id;
  final String friendId;
  final String? lastMessage;

  Friend({
    required this.id,
    required this.friendId,
    this.lastMessage,
    required super.username,
    required super.imageUrl,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'friendId': friendId,
      'lastMessage': lastMessage,
      'userName': username,
      'imageUrl': imageUrl,
    };
  }

  factory Friend.fromMap(Map<String, dynamic> map) {
    return Friend(
      id: map['id'] as String,
      friendId: map['friendId'] as String,
      username: map['userName'] as String,
      imageUrl: map['imageUrl'] as String,
      lastMessage: map['lastMessage']['textMessage'] as String?,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Friend.fromJson(String source) =>
      Friend.fromMap(json.decode(source) as Map<String, dynamic>);
}
