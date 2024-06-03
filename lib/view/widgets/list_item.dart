import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/note_controller.dart';

import '../../model/note.dart';

ListTile myListTile(Note note, NoteController noteController) {
  return ListTile(
    tileColor: Color(int.parse("0xff" + "${note.color}")),
    title: Text("${note.title}"),
    subtitle: Text("${note.content}"),
    leading: Text("${note.color}"),
    trailing: SizedBox(
      width: 50,
      height: 50,
      child: Row(
        children: [
          GestureDetector(
              onLongPress: () => noteController.deleteNote(note),
              child: const Icon(Icons.delete)),
          GestureDetector(
              onTap: () {
                noteController.prepairUpdate(note);
                Get.toNamed('/addNote', arguments: {'state': 'Update'});
              },
              child: const Icon(Icons.edit)),
        ],
      ),
    ),
  );
}
