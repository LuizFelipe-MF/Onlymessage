// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:onlymessage/app/core/exeptions/repository_exeption.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import 'package:onlymessage/app/models/friend.dart';
import 'package:onlymessage/app/models/friend_request.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './friends_repository.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  final CustomDio dio;

  FriendsRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<Friend>> getFriends() async {
    try {
      List<Friend> list = [];
      final res = await dio.auth().get('/friends/getfriendships');
      List<dynamic> data = res.data;

      if (res.data != null) {
        list = data.map((e) => Friend.fromMap(e)).toList();

        final hasLastMessage =
            list.where((e) => e.lastMessage != null).toList();
        final hasntLastMessage =
            list.where((e) => e.lastMessage == null).toList();

        if (hasLastMessage.length > 1) {
          list.sort(
            (x, y) => DateTime.parse(y.lastMessage?.sendeTime ?? '').compareTo(
              DateTime.parse(x.lastMessage?.sendeTime ?? ''),
            ),
          );
        }

        list.clear();
        list.addAll(hasLastMessage);
        list.addAll(hasntLastMessage);
      }

      return list;
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao buscar usuários.');
    }
  }

  @override
  Future<List<FriendRequest>> getFriendsRequest() async {
    try {
      final res = await dio.auth().get('/friends/getfriendrequests');
      List<dynamic> data = res.data;

      List<FriendRequest> list = [];

      if (res.data != null) {
        list = data.map((e) => FriendRequest.fromMap(e)).toList();
      }

      return list;
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao buscar pedidos de amizade.');
    }
  }

  @override
  Future<void> acceptFriendRequest(String id, bool hasAccept) async {
    try {
      await dio.auth().post('/friends/friendship', data: {
        'id': id,
        'isAccepted': hasAccept,
      });
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao buscar pedidos de amizade.');
    }
  }

  @override
  Future<void> removeFriend(String id) async {
    try {
      await dio.auth().delete('/friends/removefriendship/$id', data: {});
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao tentar remover amigo.');
    }
  }
}
