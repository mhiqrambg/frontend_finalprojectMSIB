import 'user_model.dart';

class RegisterResponseModel {
  late String message;
  late User user;

  RegisterResponseModel({
    required this.message,
    required this.user,
  });

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['user'] = this.user.toJson();
    return data;
  }
}
