import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/core/config/app_routes.dart';
import 'package:note_app/model/user.dart';
import 'package:note_app/util/services/api_services.dart';
import 'package:note_app/util/helpers/custom_snackbar.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final ApiServices _apiServices = ApiServices();
  GetStorage box = GetStorage();
  User? user;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //=======================[ Signup function ]====================
  void signup() async {
    final bool valid = formKey.currentState!.validate();

    if (valid) {
      isLoading(true);
      var response = await _apiServices.postRequest(
          endPoint: 'auth/signup.php',
          data: {
            'email': email.text,
            'username': username.text,
            'password': password.text
          });

      if (response != null) {
        log(response.toString());

        if (response['status'] == 'success') {
          showSnackbar(
            title: "Signed Up",
            message: "${response['message']} you'll be redirected to login.",
            isError: false,
          );
          await Future.delayed(const Duration(seconds: 3));
          Get.offNamed(AppRoutes.login);
        } else {
          showSnackbar(title: "Error", message: response['message']);
        }
      }
      isLoading(false);
    }
  }

  //======================[ Login function ]====================
  void login() async {
    isLoading(true);
    var response = await _apiServices.postRequest(
        endPoint: 'auth/login.php',
        data: {'username': username.text, 'password': password.text});

    if (response != null) {
      log(response.toString());

      if (response['status'] == 'success') {
        user = User.fromJson(response['user']);
        box.write('user', user!.toJson()); //SAVE USER LOCALY
        showSnackbar(
          title: "Logged In",
          message: response['message'],
          isError: false,
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offNamed(AppRoutes.home);
      } else {
        showSnackbar(title: "Error", message: response['message']);
      }
    }
  }

  //======================[ Logout function ]====================
  void logout() async {
    box.remove('user');
    Get.offNamed(AppRoutes.login);
  }

  // Get User data on intialize
  void getUserData() {
    Map<String, dynamic>? userData = box.read<Map<String, dynamic>>('user');
    if (userData != null) {
      user = User.fromJson(userData);
    }
  }

  void clearFields() {
    email.clear();
    username.clear();
    password.clear();
    update();
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
