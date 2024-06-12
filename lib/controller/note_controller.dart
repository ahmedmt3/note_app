import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/db.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/util/helpers/app_helper.dart';
import 'package:note_app/util/helpers/app_loaders_helper.dart';
import 'package:note_app/util/services/api_service.dart';

import '../view/widgets/custom_snackbar.dart';

class NoteController extends GetxController {
  final ApiServices _apiServices = ApiServices();
  SqlDb sqlDb = SqlDb();
  var notes = <Note>[].obs;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController color = TextEditingController();
  DateTime? createdAt;
  int? nId;
  // Timer? _timer;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  // ==================[ Loading All Notes ]===============

  Future<void> loadNotes({bool showLoading = false}) async {
    if (showLoading) {
      AppLoaders.showLoading();
      if (kDebugMode) {
        await Future.delayed(const Duration(seconds: 2));
      }
    }

    isLoading(true);
    notes.clear();
    var response = await _apiServices.getRequest(endPoint: 'notes/');

    if (response != null) {
      response = jsonDecode(response.body);
      response.forEach(
        (element) => notes.add(Note.fromMap(element)),
      );
    }
    log(response.toString());
    log(notes.length.toString());

    isLoading(false);
    if (showLoading) {
      AppLoaders.hideLoading();
    }
    update();
  }

  void addNote() async {
    // isLoading(true);
    if (formKey.currentState!.validate()) {
      var response =
          await _apiServices.postRequest(endPoint: 'notes/add.php', data: {
        'title': title.text.isEmpty ? "Empty note" : title.text,
        'content': content.text.isEmpty ? " " : content.text,
        //You can send the color, by default = #FFFFFF
      });

      if (response != null) {
        response = jsonDecode(response.body);
        log(response.toString());

        if (response['message'] == 'success') {
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

  //======= Update ==========
  void prepairUpdate(Note note) {
    title.text = note.title ?? "";
    content.text = note.content ?? "";
    color.text = note.color ?? "";
    nId = note.id;
    update();
  }

  void updateNote() async {
    var response =
        await _apiServices.postRequest(endPoint: 'notes/update.php', data: {
      'id': '$nId',
      'title': title.text,
      'content': content.text,
      'color': color.text,
      'last_modified': DateTime.now().toIso8601String()
    });

    if (response != null) {
      response = jsonDecode(response.body);
      log(response.toString());

      if (response['message'] == 'success') {
        clearFields();
        Get.back();
        loadNotes();
      } else {
        showSnackbar(title: "Err:", message: response['message']);
      }
    }
  }

  //========== Delete ==============
  void deleteNote() async {
    var response = await _apiServices
        .postRequest(endPoint: 'notes/delete.php', data: {'id': '$nId'});

    if (response != null) {
      response = jsonDecode(response.body);
      log(response.toString());

      if (response['message'] == 'success') {
        await Future.delayed(const Duration(milliseconds: 300));
        clearFields();
        Get.back();
        loadNotes();
      } else {
        showSnackbar(title: "Err:", message: response['message']);
      }
    }
  }

  //====== VALIDATION ==========
  String? validateTitle(String? title) {
    if (GetUtils.isNullOrBlank(title) == true) {
      return "Title is required";
    }
    return null;
  }

  String? validateColor(String? color) {
    if (AppHelper.isValidHexColor(color!)) {
      return "Incorrect color type";
    }
    return null;
  }
  //====== END VALIDATION ==========

  void clearFields() {
    title.clear();
    content.clear();
    color.clear();
    title.clear();
    update();
  }

  // void startTimer() {
  //   _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
  //     loadNotes();
  //   });
  // }

  @override
  void onInit() {
    // sqlDb.deleteDatabase();

    super.onInit();
  }

  @override
  void onReady() {
    loadNotes(showLoading: true);
    super.onReady();
  }
}
