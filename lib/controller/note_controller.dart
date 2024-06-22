import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/db.dart';
import 'package:note_app/model/image.dart';
import 'package:note_app/model/note.dart';
import 'package:note_app/util/helpers/app_loaders_helper.dart';
import 'package:note_app/util/services/api_services.dart';
import 'package:note_app/util/services/files_services.dart';

import '../view/widgets/custom_snackbar.dart';

class NoteController extends GetxController {
  final ApiServices _apiServices = ApiServices();
  var notes = <Note>[].obs;
  var images = <NoteImage>[].obs;
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  TextEditingController color = TextEditingController();
  DateTime? createdAt;
  Note? currNote;
  NoteImage? currImage;
  var isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  final FilesServices _filesServices = FilesServices();
  File? _image;
  bool fromDelete = false;
  Rx<Offset> imgPosition = const Offset(0, 0).obs;

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
    images.clear();
    var notesResponse = await _apiServices.getRequest(endPoint: 'notes/');
    var imageResponse = await _apiServices.getRequest(endPoint: 'images/');

    if (notesResponse != null) {
      notesResponse = jsonDecode(notesResponse.body);
      notesResponse.forEach(
        (element) => notes.add(Note.fromJson(element)),
      );
    }
    if (imageResponse != null) {
      imageResponse = jsonDecode(imageResponse.body);
      imageResponse.forEach((image) => images.add(NoteImage.fromJson(image)));
    }
    log("Notes: ${notesResponse.toString()}");
    log("Images: ${imageResponse.toString()}");

    isLoading(false);
    if (showLoading) {
      AppLoaders.hideLoading();
    }
    update();
  }

  //=================[ Adding Note ]=================

  void addNote() async {
    if (!content.text.isBlank!) {
      var response = await _apiServices.postRequestWithFile(
          endPoint: 'notes/add.php',
          fileField: 'image',
          file: _image,
          data: {
            'title': title.text.isEmpty ? "New Note" : title.text,
            'content': content.text.isEmpty ? " " : content.text,
            'image_pos_x': '${imgPosition.value.dx}',
            'image_pos_y': '${imgPosition.value.dy}',
            //You can send color, by default = #FFFFFF
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

  //===============[ Update ]=====================

  void prepairUpdate(Note note) {
    title.text = note.title!;
    content.text = note.content!;
    currNote = note;
    currImage = images.where((image) => image.noteId == note.id).firstOrNull;
    if (currImage != null) {
      imgPosition.value = Offset(currImage!.imagePosX!, currImage!.imagePosY!);
    }
    update();
  }

  bool changed() {
    return !(title.text == currNote!.title &&
        content.text == currNote!.content &&
        imgPosition.value.dx == currImage!.imagePosX &&
        imgPosition.value.dy == currImage!.imagePosY);
  }

  void updateNote() async {
    if (changed()) {
      log("Image Position X: ${imgPosition.value.dx}");
      log("Image Position Y: ${imgPosition.value.dy}");

      var response = await _apiServices.postRequestWithFile(
          endPoint: 'notes/update.php',
          fileField: 'image',
          file: _image,
          data: {
            'id': '${currNote!.id}',
            'title': title.text,
            'content': content.text,
            'color': color.text,
            'image_pos_x': '${imgPosition.value.dx}',
            'image_pos_y': '${imgPosition.value.dy}'
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
  }

  //=================[ Delete ]================

  void deleteNote() async {
    var response = await _apiServices.postRequest(
        endPoint: 'notes/delete.php',
        data: {'id': '${currNote!.id}', 'image_name': currImage!.imageName});

    if (response != null) {
      response = jsonDecode(response.body);
      log(response.toString());

      if (response['message'] == 'success') {
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

  //=================[ Image functions ]================
  void pickImage({bool fromCamera = false}) async {
    var result = await _filesServices.pickImage(fromCamera: fromCamera);
    if (result != null) {
      _image = File(result.path);
    }
  }

  void updateImgPosition(Offset newPosition) {
    imgPosition.value = newPosition;
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
    _image = null;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    loadNotes(showLoading: true);
    super.onReady();
  }
}
