import 'dart:io';

abstract class PerfilEditRepository {
  Future<void> updateUserInformations(String username, String password);
  Future<String> updateUserImage(File file);
}
