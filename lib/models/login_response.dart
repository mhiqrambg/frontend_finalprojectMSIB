class LoginResponseModel {
  late bool success;
  late String token;

  LoginResponseModel({
    required this.success,
    required this.token,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'success': success,
      'token': token,
    };
    return data;
  }
}
