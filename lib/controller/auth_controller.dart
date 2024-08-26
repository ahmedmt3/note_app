import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/core/config/app_routes.dart';
import 'package:note_app/model/user.dart';
import 'package:note_app/util/helpers/app_helper.dart';
import 'package:note_app/util/services/api_services.dart';

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
      Map<String, dynamic> data = {
        'email': email.text,
        'username': username.text,
        'password': password.text
      };
      var response = await _apiServices.postRequest(
          endPoint: 'users', data: jsonEncode(data));

      response.fold((left) {
        log(left.toString());
        AppHelper.showSnackbar(title: "Error", message: left.toString());
      }, (right) async {
        log(right.toString());
        AppHelper.showSnackbar(
          title: "Signed Up",
          message: "${right['message']} you'll be redirected to login.",
          isError: false,
        );
        await Future.delayed(const Duration(seconds: 3));
        clearFields();
        Get.offNamed(AppRoutes.login);
      });

      isLoading(false);
    }
  }

  // //======================[ Login function ]====================
  void login() async {
    isLoading(true);

    Map<String, dynamic> data = {
      'action': 'login',
      'username': username.text,
      'password': password.text
    };
    var response = await _apiServices.postRequest(
        endPoint: 'users', data: jsonEncode(data));

    response.fold((left) {
      AppHelper.showSnackbar(title: "Error", message: left.toString());
    }, (right) async {
      log(right.toString());
      user = User.fromJson(right['user']);
      box.write('user', user!.toJson()); //SAVE USER LOCALY
      AppHelper.showSnackbar(
        title: "Logged In",
        message: "${right['message']}, directing to Home..",
        isError: false,
      );
      await Future.delayed(const Duration(seconds: 1));
      clearFields();
      Get.offNamed(AppRoutes.home);
    });

    isLoading(false);
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

  void goToLogin() {
    clearFields();
    Get.offNamed(AppRoutes.login);
  }
  void goToSignup() {
    clearFields();
    Get.offNamed(AppRoutes.signup);
  }

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
