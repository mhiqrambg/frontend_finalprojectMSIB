class User {
  late int id;
  late String username;
  late String password;
  late String image;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.image,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['image'] = this.image;
    return data;
  }
}
