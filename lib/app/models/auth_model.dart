import 'dart:convert';
import 'package:onlymessage/app/models/user.dart';

class AuthModel {
  final String token;
  final String refreshToken;
  final UserAuth user;
  final String expiration;

  AuthModel({
    required this.token,
    required this.refreshToken,
    required this.user,
    required this.expiration,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'refreshToken': refreshToken,
      'user': user.toMap(),
      'expiration': expiration,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      token: map['token'] as String,
      refreshToken: map['refreshToken'] as String,
      user: UserAuth.fromMap(map['user'] as Map<String, dynamic>),
      expiration: map['expiration'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(String source) =>
      AuthModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
