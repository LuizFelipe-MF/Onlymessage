// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';
import 'package:onlymessage/app/core/exeptions/repository_exeption.dart';
import 'package:onlymessage/app/core/exeptions/unauthorize_exeption.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import 'package:onlymessage/app/models/auth_model.dart';

import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;
  AuthRepositoryImpl({
    required this.dio,
  });

  @override
  Future<AuthModel> login(String username, String password) async {
    try {
      final result = await dio.unauth().post('/auth/login', data: {
        "userName": username,
        "password": password,
      });

      return AuthModel.fromMap(result.data);
    } on DioError catch (e) {
      if (e.response?.statusCode == 403) {
        throw UnauthorizedExeption();
      }
      throw RepositoryExeption(message: 'Erro ao fazer login');
    }
  }

  @override
  Future<void> register(String username, String password) async {
    try {
      await dio.unauth().post('/account/signup', data: {
        "userName": username,
        "password": password,
      });
    } on DioError catch (e) {
      print(e);
      throw RepositoryExeption(message: 'Erro ao registrar usuário');
    }
  }
}
