import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:gitlist/api.dart';
import 'package:gitlist/user_screen.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GitHub List',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Users> users = [];

  @override
  void initState() {
    load(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
      ),
      body: LazyLoadScrollView(
        onEndOfPage: () => load(users[users.length - 1].id),
        scrollOffset: 100,
        child: RefreshIndicator(
          onRefresh: () => load(0),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _card(users[index]);
            },
            itemCount: users.length,
          ),
        ),
      ),
    );
  }

  load(int id) {
    BaseApi().getAllUsers(id).then((ans) {
      if (ans is String) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Error"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Ok"),
              )
            ],
          ),
        );
      } else {
        setState(() {
          users.addAll(ans as List<Users>);
        });
      }
    });
  }

  Widget _card(Users user) {
    return ListTile(
      title: Text(
        user.login,
        style: const TextStyle(fontSize: 18),
      ),
      subtitle: Text("${user.id}", style: const TextStyle(fontSize: 14)),
      leading: CircularProfileAvatar(
        user.avatarUrl,
        radius: 50,
      ),
      onTap: () async {
        BaseApi().getUser(user.login).then(
              (value) => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => UserScreen(title: user.login, user: value),
                ),
              ),
            );
      },
    );
  }
}
