import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.success,
    required this.token,
  });
  late final bool success;
  late final String token;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['token'] = token;
    return _data;
  }
}
