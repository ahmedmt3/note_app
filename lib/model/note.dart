class Note {
  int? id;
  String? title;
  String? content;
  String? color;
  String? createdAt;
  String? lastModified;

  Note({
    this.id,
    this.title,
    this.content,
    this.color,
    this.createdAt,
    this.lastModified,
  });

  Note.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
    color = map['color'];
    createdAt = map['created_at'];
    lastModified = map['last_modified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'color': color,
      'created_at': createdAt,
      'last_modified': lastModified
    };
  }
}
