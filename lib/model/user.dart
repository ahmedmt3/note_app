class User {
  int? id;
  String? username;
  String? email;
  String? password;

  User({
    this.id,
    this.username,
    this.email,
    this.password,
  });

  // From Json
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
  }

  // To Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password
    };
  }
}
