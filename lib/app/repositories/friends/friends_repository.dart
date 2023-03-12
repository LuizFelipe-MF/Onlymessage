import 'package:onlymessage/app/models/friend.dart';
import 'package:onlymessage/app/models/friend_request.dart';

abstract class FriendsRepository {
  Future<List<Friend>> getFriends();
  Future<List<FriendRequest>> getFriendsRequest();
  Future<void> acceptFriendRequest(String id, bool hasAccept);
  Future<void> removeFriend(String id);
}
