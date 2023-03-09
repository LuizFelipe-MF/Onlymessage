// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:onlymessage/app/core/exeptions/repository_exeption.dart';
import 'package:onlymessage/app/core/rest_client/custom_dio.dart';
import 'package:onlymessage/app/models/friend.dart';

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
      }
      return list;
    } on Exception catch (e) {
      throw RepositoryExeption(message: 'Erro ao buscar usuários.');
    }
  }
}
