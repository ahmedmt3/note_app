class NoteImage {
  int? id;
  int? noteId;
  String? imageName;
  double? imagePosX;
  double? imagePosY;

  NoteImage({
    this.id,
    this.noteId,
    this.imageName,
    this.imagePosX,
    this.imagePosY,
  });

  // From Json
  NoteImage.fromJson(Map<String, dynamic> map) {
    id = map['image_id'];
    noteId = map['note_id'];
    imageName = map['image_name'];
    imagePosX = (map['image_pos_x'] is int)
        ? (map['image_pos_x'] as int).toDouble()
        : map['image_pos_x'];
    imagePosY = (map['image_pos_y'] is int)
        ? (map['image_pos_y'] as int).toDouble()
        : map['image_pos_y'];
  }

  // To Json
  Map<String, dynamic> toJson() {
    return {
      'image_id': id,
      'note_id': noteId,
      'image_name': imageName,
      'image_pos_x': imagePosX,
      'image_pos_y': imagePosY
    };
  }
}
