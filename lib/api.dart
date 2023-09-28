import 'dart:convert';

import 'package:dio/dio.dart';

import 'model.dart';
abstract class BaseApiI{
  Future<dynamic> getAllUsers(int id);
  Future<dynamic> getUser(String name);
}
class BaseApi implements BaseApiI {
  Dio dio = Dio(BaseOptions(baseUrl: "https://api.github.com"));

  @override
  Future<dynamic> getAllUsers (int id) async {
    try {
      final res = await dio.get("/users?since=$id");
      if (res.statusCode != 200) {
        return "Error";
      } else {
        return List<Users>.from(res.data.map((x) => Users.fromJson(x as Map<String, dynamic>)));
      }
    }catch(e){
      return "error";
    }
  }
  @override
  Future<dynamic> getUser (String name) async {
    try {
      final res = await dio.get("/users/$name");
      if (res.statusCode != 200) {
        return "Error";
      } else {
        return User.fromJson(res.data);
      }
    }catch(e){
      return "error";
    }
  }
}