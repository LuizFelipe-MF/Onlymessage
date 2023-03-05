import 'dart:convert';

class UserAuth {
  final String username;
  final String imageUrl;

  UserAuth({
    required this.username,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'username': username,
      'imageUrl': imageUrl,
    };
  }

  factory UserAuth.fromMap(Map<String, dynamic> map) {
    return UserAuth(
      username: map['username'] as String,
      imageUrl: map['imageUrl'] as String,  
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuth.fromJson(String source) =>
      UserAuth.fromMap(json.decode(source) as Map<String, dynamic>);

  UserAuth copyWith({
    String? username,
    String? imageUrl,
  }) {
    return UserAuth(
      username: username ?? this.username,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
