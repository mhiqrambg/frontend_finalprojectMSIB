class RegisterRequestModel {
  late String username;
  late String password;
  late String image;

  RegisterRequestModel({
    required this.username,
    required this.password,
    required this.image,
  });

  RegisterRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['image'] = this.image;
    return data;
  }
}
