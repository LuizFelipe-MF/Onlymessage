import 'dart:convert';

class FriendRequest {
  final String id;
  final String username;
  final String uri;
  final String created;
  
  FriendRequest({
    required this.id,
    required this.username,
    required this.uri,
    required this.created,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'username': username,
      'uri': uri,
      'created': created,
    };
  }

  factory FriendRequest.fromMap(Map<String, dynamic> map) {
    return FriendRequest(
      id: map['id'] as String,
      username: map['username'] as String,
      uri: map['uri'] as String,
      created: map['created'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendRequest.fromJson(String source) => FriendRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
