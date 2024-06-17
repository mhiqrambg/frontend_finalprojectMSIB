class LoginRequestModel {
  late String username;
  late String password;

  LoginRequestModel({
    required this.username,
    required this.password,
  });

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'username': username,
      'password': password,
    };
    return data;
  }
}
