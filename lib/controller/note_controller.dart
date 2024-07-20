import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  Rx<Offset> imgPosition = const Offset(100, 100).obs;

  /*
  ======================================================
  ================[ Loading All Notes ]=================
  ======================================================
  */
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
    Map<String, dynamic>? notesResponse =
        await _apiServices.getRequest(endPoint: 'notes/');
    var imageResponse = await _apiServices.getRequest(endPoint: 'images/');

    if (notesResponse != null) {
      notesResponse['data'].forEach(
        (element) => notes.add(Note.fromJson(element)),
      );
    }
    if (imageResponse != null) {
      imageResponse['data']
          .forEach((image) => images.add(NoteImage.fromJson(image)));
    }
    log("Notes: ${notesResponse!['data'].toString()}");
    log("Images: ${imageResponse['data'].toString()}");

    isLoading(false);
    if (showLoading) {
      AppLoaders.hideLoading();
    }
    update();
  }

  /*
  =================================================
  =================[ Adding Note ]=================
  =================================================
  */
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
        log(response.toString());

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
    currImage = images.where((image) => image.noteId == note.id).firstOrNull;
    if (currImage != null) {
      imgPosition.value = Offset(currImage!.imagePosX!, currImage!.imagePosY!);
    }
    update();
  }

  bool changed() {
    if (_image != null) {
      return true;
    }
    if (currImage != null) {
      return !(title.text == currNote!.title &&
          content.text == currNote!.content &&
          imgPosition.value.dx == currImage!.imagePosX &&
          imgPosition.value.dy == currImage!.imagePosY);
    } else {
      return !(title.text == currNote!.title &&
          content.text == currNote!.content);
    }
  }

  void updateNote() async {
    if (changed()) {
      dynamic response;
      if (_image != null) {
        response = await _apiServices.postRequestWithFile(
            endPoint: 'notes/update.php',
            fileField: 'image',
            file: _image,
            data: {
              'id': '${currNote!.id}',
              'title': title.text,
              'content': content.text,
              'color': color.text,
              'image_pos_x': '${imgPosition.value.dx}',
              'image_pos_y': '${imgPosition.value.dy}',
              if (currImage != null) 'old_image': currImage!.imageName
            });
      } else {
        response =
            await _apiServices.postRequest(endPoint: 'notes/update.php', data: {
          'id': '${currNote!.id}',
          'title': title.text,
          'content': content.text,
          'color': color.text,
          'image_pos_x': '${imgPosition.value.dx}',
          'image_pos_y': '${imgPosition.value.dy}'
        });
      }

      if (response != null) {
        log(response.toString());

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
      if (currImage != null) 'image_name': currImage!.imageName
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
    currImage = null;
    currNote = null;
    _image = null;
    update();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    loadNotes(showLoading: true);
    super.onReady();
  }
}
