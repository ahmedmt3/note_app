class Note {
  int? id;
  int? userId;
  String? title;
  String? content;
  String? color;
  String? createdAt;
  String? lastModified;

  Note({
    this.id,
    this.userId,
    this.title,
    this.content,
    this.color,
    this.createdAt,
    this.lastModified,
  });

  // From json
  Note.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    content = json['content'];
    color = json['color'];
    createdAt = json['created_at'];
    lastModified = json['last_modified'];
  }

  // To Json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'title': title,
      'content': content,
      'color': color,
      'created_at': createdAt,
      'last_modified': lastModified
    };
  }
}
