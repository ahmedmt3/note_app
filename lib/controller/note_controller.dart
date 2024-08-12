import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/util/services/api_services.dart';

import '../util/helpers/custom_snackbar.dart';

class NoteController extends GetxController {
  final ApiServices _apiServices = ApiServices();
  RxList<Note> notes = <Note>[].obs;
  RxList<Note> favNotes = <Note>[].obs;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController color = TextEditingController();
  DateTime? createdAt;
  Note? currNote;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  bool fromDelete = false;

  /*
  ======================================================
  ================[ Loading All Notes ]=================
  ======================================================
  */
  Future<void> loadNotes() async {
    isLoading(true);
    update();
    notes.clear();

    Map<String, dynamic>? notesResponse =
        await _apiServices.getRequest(endPoint: 'notes/');

    if (notesResponse != null) {
      notesResponse['data'].forEach(
        (element) => notes.add(Note.fromJson(element)),
      );
    }
    log("Notes: ${notes.length}");
    isLoading(false);
    update();
  }

  /*
  =================================================
  =================[ Adding Note ]=================
  =================================================
  */
  void addNote() async {
    if (!content.text.isBlank!) {
      var response =
          await _apiServices.postRequest(endPoint: 'notes/add.php', data: {
        'title': title.text.isEmpty,
        'content': content.text.isEmpty ? " " : content.text,
        //You can send color, by default = #FFFFFF
      });

      if (response != null) {
        log(response['message'].toString());
        if (response['status'] == 'success') {
          Get.back();
          clearFields();
          loadNotes();
        } else {
          showSnackbar(title: "Error:", message: response['message']);
        }
      }
    }

    update();
  }

  /*
  ======================================================
  =====================[ Update ]=======================
  ======================================================
  */
  void prepairUpdate(Note note) {
    title.text = note.title!;
    content.text = note.content!;
    currNote = note;
    update();
  }

  bool changed() {
    return !(title.text == currNote!.title &&
        content.text == currNote!.content);
  }

  void updateNote() async {
    if (changed()) {
      dynamic response =
          await _apiServices.postRequest(endPoint: 'notes/update.php', data: {
        'id': '${currNote!.id}',
        'title': title.text,
        'content': content.text,
        'color': color.text,
      });

      if (response != null) {
        log(response['message'].toString());

        if (response['status'] == 'success') {
          clearFields();
          Get.back();
          loadNotes();
        } else {
          showSnackbar(title: "Error:", message: response['message']);
        }
      }
    }
  }

  /*
  =================================================
  ===================[ Delete ]====================
  =================================================
  */
  void deleteNote() async {
    Map<String, dynamic>? response =
        await _apiServices.postRequest(endPoint: 'notes/delete.php', data: {
      'id': '${currNote!.id}',
    });

    if (response != null) {
      log(response['message'].toString());

      if (response['status'] == 'success') {
        await Future.delayed(const Duration(milliseconds: 300));
        clearFields();
        fromDelete = true;
        Get.back();
        loadNotes();
        fromDelete = false;
      } else {
        showSnackbar(title: "Error:", message: response['message']);
      }
    }
  }

  /*
  =================================================
  =============[ Add To Favourite ]================
  =================================================
  */
  void addToFav(int id) {
    favNotes.add(currNote!);
  }

  void onBackClick(bool click) {
    if (!fromDelete) {
      if (currNote != null) {
        updateNote();
      } else {
        addNote();
      }
    }
  }

  void clearFields() {
    title.clear();
    content.clear();
    color.clear();
    title.clear();
    currNote = null;

    update();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    loadNotes();
    super.onReady();
  }
}
