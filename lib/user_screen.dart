import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gitlist/model.dart';

class UserScreen extends StatelessWidget{
  const UserScreen({super.key,required this.title, required this.user});

  final User user;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text(title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircularProfileAvatar(
                user.avatarUrl,
                radius: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text("Name: ${user.name}"),
                      Text("Email: ${user.email ?? "email is empty"}"),
                      Text("Company: ${user.company}"),
                      Text("Followers: ${user.followers}"),
                      Text("Following: ${user.following}"),
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

}