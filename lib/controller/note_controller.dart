import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/util/helpers/app_helper.dart';
import 'package:note_app/util/services/api_services.dart';

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
  final GetStorage box = GetStorage();
  final AuthController _authController = Get.find<AuthController>();

  /*
  ======================================================
  ================[ Loading All Notes ]=================
  ======================================================
  */
  Future<void> loadNotes() async {
    isLoading(true);
    update();

    notes.clear();
    final int userId = _authController.user!.id!;
    var response =
        await _apiServices.getRequest(endPoint: 'notes?user=$userId');
    response.fold((left) {
      log("$left");
      AppHelper.showSnackbar(title: "title", message: left.toString());
    }, (right) {
      right.forEach(
        (element) => notes.add(Note.fromJson(element)),
      );
      saveNotes();
      log("Loaded Notes: ${notes.length}");
    });

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
      final int userId = _authController.user!.id!;
      final Map<String, dynamic> data = {
        "user_id": userId,
        'title': title.text.isEmpty ? 'New note' : title.text,
        'content': content.text.isEmpty ? " " : content.text
        //You can send color, by default = #FFFFFF
      };
      var response = await _apiServices.postRequest(
          endPoint: 'notes', data: jsonEncode(data));

      response.fold((left) {
        log("$left");
        AppHelper.showSnackbar(title: "Error:", message: "$left");
      }, (right) {
        log(right.toString());
        Get.back();
        clearFields();
        loadNotes();
      });
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

  bool changed() =>
      !(title.text == currNote!.title && content.text == currNote!.content);

  void updateNote() async {
    if (changed()) {
      Map<String, dynamic> data = {
        'title': title.text,
        'content': content.text
        // 'color': color.text
      };
      var response = await _apiServices.patchRequest(
          endPoint: 'notes/${currNote!.id}', data: jsonEncode(data));

      response.fold((left) {
        log("$left");
        AppHelper.showSnackbar(title: "Error:", message: "$left");
      }, (right) {
        log("$right");
        clearFields();
        Get.back();
        loadNotes();
      });
    }
  }

  /*
  =================================================
  ===================[ Delete ]====================
  =================================================
  */
  void deleteNote() async {
    var response =
        await _apiServices.deleteRequest(endPoint: 'notes/${currNote!.id}');

    response.fold((left) {
      log("$left");
      AppHelper.showSnackbar(title: "Error:", message: "$left");
    }, (right) async {
      log(right['message']);
      clearFields();
      fromDelete = true;
      Get.back();
      loadNotes();
      fromDelete = false;
    });
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

  /*
  =================================================
  =============[ Save Notes Localy ]===============
  =================================================
  */
  void saveNotes() async {
    await box.write('notes', notes.toList());
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
    final storedNotes = box.read<List>('notes');
    if (storedNotes != null) {
      notes.value = storedNotes.map((json) => Note.fromJson(json)).toList();
      update();
    } else {
      loadNotes();
    }
    super.onReady();
  }
}
