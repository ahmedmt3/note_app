import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/config/app_routes.dart';
import 'package:note_app/util/services/api_services.dart';
import 'package:note_app/view/widgets/custom_snackbar.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  final ApiServices _apiServices = ApiServices();

  void signup() async {
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
          message: response['message'],
          isError: false,
        );
        Future.delayed(const Duration(seconds: 3));
        Get.offNamed(AppRoutes.login);
      } else {
        showSnackbar(title: "Error", message: response['message']);
      }
    }
    isLoading(false);
  }

  void login() async {
    isLoading(true);
    var response = await _apiServices.postRequest(
        endPoint: 'auth/login.php',
        data: {'username': username.text, 'password': password.text});

    if (response != null) {
      log(response.toString());
      if (response['status'] == 'success') {
        showSnackbar(
          title: "Logged In",
          message: response['message'],
          isError: false,
        );
        Get.offNamed(AppRoutes.home);
      } else {
        showSnackbar(title: "Error", message: response['message']);
      }
    }
  }

  void logout() async {}
}
