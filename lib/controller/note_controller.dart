import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/db.dart';
import 'package:note_app/model/note.dart';

class NoteController extends GetxController {
  SqlDb sqlDb = SqlDb();
  var notes = <Note>[].obs;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController color = TextEditingController();
  int? nId;

  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  void loadNotes() async {
    isLoading(true);
    notes([]);
    List<Map> response = await sqlDb.readData("SELECT * FROM 'notes' ");
    print(response);
    response.forEach(
      (element) => notes.add(Note.fromMap(element)),
    );

    isLoading(false);
    update();
  }

  void addNote() async {
    // isLoading(true);
    if (formKey.currentState!.validate()) {
      int response = await sqlDb.insertData(
          "INSERT INTO 'notes' ('title', 'content', 'color') VALUES ('${title.text}', '${content.text}', '${color.text}')");
      if (response > 0) {
        Get.back();
        clearFields();
        loadNotes();
      }
    }
    update();
  }

  void prepairUpdate(Note note) {
    title.text = note.title ?? "";
    content.text = note.content ?? "";
    color.text = note.color ?? "";
    nId = note.id;
    update();
  }

  void updateNote() async {
    int response = await sqlDb.updateData('''
        UPDATE 'notes'
        SET title = '${title.text}',
        content = '${content.text}',
        color = '${color.text}'
        WHERE id = $nId
        ''');
    print(response);
    if (response > 0) {
      Get.back();
      loadNotes();
    }
  }

  String? validateTitle(String? title) {
    if (GetUtils.isNullOrBlank(title) == true) {
      return "Title is required";
    }
    return null;
  }

  String? validateContent(String? content) {
    if (GetUtils.isNullOrBlank(content) == true) {
      return "Please type something..";
    }
    return null;
  }

  String? validateColor(String? color) {
    if (isValidHexColor(color!)) {
      return "Incorrect color type";
    }
    return null;
  }

  bool isValidHexColor(String color) {
    final hexColorPattern = RegExp(r'^[0-9A-Fa-f]{6}$');
    return !hexColorPattern.hasMatch(color);
  }

  void deleteNote(Note note) async {
    int res =
        await sqlDb.deleteData("DELETE FROM 'notes' WHERE id = ${note.id}");
    if (res == 1) {
      loadNotes();
    }
  }

  void clearFields() {
    title.clear();
    content.clear();
    color.clear();
  }

  @override
  void onInit() {
    loadNotes();

    super.onInit();
  }
}
