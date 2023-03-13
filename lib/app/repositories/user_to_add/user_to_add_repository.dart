import 'package:onlymessage/app/models/users_to_add.dart';

abstract class UserToAddRepository {
  Future<List<UsersToAdd>> getUsers(String search);
  Future<void> addUser(String id);
}
