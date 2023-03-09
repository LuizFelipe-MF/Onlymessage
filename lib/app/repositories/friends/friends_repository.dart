import 'package:onlymessage/app/models/friend.dart';

abstract class FriendsRepository {
  Future<List<Friend>> getFriends();
}
