import 'package:onlymessage/app/models/auth_model.dart';

abstract class AuthRepository {
  Future<AuthModel> login(String username, String password);

  Future<void> register(String username, String password);
}
