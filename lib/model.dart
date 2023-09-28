import 'dart:convert';


class Users {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;

  Users({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        login: json["login"],
        id: json["id"],
        nodeId: json["node_id"],
        avatarUrl: json["avatar_url"],
      );
}

User userFromJson(String str) => User.fromJson(json.decode(str));

class User {
  final String avatarUrl;
  final String url;
  final String name;
  final String company;
  final String? email;
  final int followers;
  final int following;

  User({
    required this.avatarUrl,
    required this.url,
    required this.name,
    required this.company,
    this.email,
    required this.followers,
    required this.following,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
        url: json["url"],
        name: json["name"],
        company: json["company"],
        email: json["email"],
        followers: json["followers"],
        following: json["following"],
      );
}
