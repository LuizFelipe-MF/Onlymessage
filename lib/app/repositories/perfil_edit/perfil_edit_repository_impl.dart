import 'dart:io';

import 'package:dio/dio.dart';
import 'package:onlymessage/app/core/exeptions/repository_exeption.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import './perfil_edit_repository.dart';

class PerfilEditRepositoryImpl implements PerfilEditRepository {
  final CustomDio dio;
  PerfilEditRepositoryImpl({
    required this.dio,
  });

  @override
  Future<void> updateUserInformations(String username, String password) async {
    try {
      await dio.auth().put('/account/updateinformations', data: {
        'username': username,
        'password': password == "" ? null : password,
      });
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao tentar salvar alterações.');
    }
  }

  @override
  Future<String> updateUserImage(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path, filename: fileName),
      });
      final response =
          await dio.auth().put("/account/changeimage", data: formData);

      return response.data['imageUrl'];
    } on DioError catch (e) {
      throw RepositoryExeption(message: 'Erro ao tentar salvar alterações.');
    }
  }
}
