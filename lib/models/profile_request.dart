class ProfileRequestModel {
  ProfileRequestModel({
    required this.password,
    required this.image,
  });
  late final String password;
  late final String image;

  ProfileRequestModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['password'] = password;
    _data['image'] = image;
    return _data;
  }
}
