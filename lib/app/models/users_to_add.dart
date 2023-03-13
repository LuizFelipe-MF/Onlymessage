import 'dart:convert';

import 'package:onlymessage/app/models/user.dart';

class UsersToAdd extends UserAuth {
  final String id;
  final bool isAlredyRequested;

  UsersToAdd({
    required this.id,
    required this.isAlredyRequested,
    required super.username,
    required super.imageUrl,
  });

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userName': username,
      'imageUrl': imageUrl,
      'isAlredyRequested': isAlredyRequested,
    };
  }

  factory UsersToAdd.fromMap(Map<String, dynamic> map) {
    return UsersToAdd(
      id: map['id'] as String,
      username: map['userName'] as String,
      imageUrl: map['imageUrl'] as String,
      isAlredyRequested: map['isAlredyRequested'] as bool,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory UsersToAdd.fromJson(String source) =>
      UsersToAdd.fromMap(json.decode(source) as Map<String, dynamic>);
}
