import 'dart:convert';

RegisterResponseModel registerResponseModel(String str) =>
    RegisterResponseModel.fromJson(json.decode(str));

class RegisterResponseModel {
  RegisterResponseModel({
    required this.message,
    required this.user,
  });
  late final String message;
  late final User user;

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.username,
    required this.password,
    required this.image,
  });
  late final int id;
  late final String username;
  late final String password;
  late final String image;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['username'] = username;
    _data['password'] = password;
    _data['image'] = image;
    return _data;
  }
}
