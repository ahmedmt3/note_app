import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  void login() async {}
  void logout() async {}
}
