// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:onlymessage/app/core/exeptions/repository_exeption.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import 'package:onlymessage/app/models/users_to_add.dart';

import './user_to_add_repository.dart';

class UserToAddRepositoryImpl implements UserToAddRepository {
  final CustomDio dio;

  UserToAddRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<UsersToAdd>> getUsers(String search) async {
    try {
      List<UsersToAdd> list = [];
      final res = await dio.auth().get('/users/getusers/$search');
      List<dynamic> data = res.data;

      if (res.data != null) {
        list = data.map((e) => UsersToAdd.fromMap(e)).toList();
      }
      return list;
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao buscar usuários.');
    }
  }

  @override
  Future<void> addUser(String id) async {
    try {
      await dio.auth().post('/friends/friendrequest', data: {
        'friendId': id,
      });
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao tentar adicionar usuário.');
    }
  }
}
