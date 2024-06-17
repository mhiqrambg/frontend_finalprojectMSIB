class ProfileResponseModel {
  ProfileResponseModel({
    required this.user,
    required this.token,
  });
  late final User user;
  late final String token;

  ProfileResponseModel.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    _data['token'] = token;
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
