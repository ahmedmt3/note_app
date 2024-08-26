class User {
  int? id;
  String? username;
  String? email;

  User({this.id, this.username, this.email});

  // From Json
  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
  }

  // To Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
    };
  }
}
