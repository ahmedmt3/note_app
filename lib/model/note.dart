class Note {
  int? id;
  String? title;
  String? content;
  String? color;

  Note({
    this.id,
    this.title,
    this.content,
    this.color,
  });

  Note.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    title = map['title'];
    content = map['content'];
    color = map['color'];
  }
}
