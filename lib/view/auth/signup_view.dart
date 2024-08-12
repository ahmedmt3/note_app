import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/core/config/app_routes.dart';
import 'package:note_app/util/helpers/app_helper.dart';
import 'package:note_app/view/auth/widgets/auth_custom_button_widget.dart';
import 'package:note_app/view/auth/widgets/cutstom_text_field_widget.dart';

class SignupView extends GetView<AuthController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Signup",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                CutstomTextFieldWidget(
                  name: "Email: ",
                  controller: controller.email,
                  hintText: "Enter your email address",
                  validator: (val) =>
                      AppHelper.validateInput(val!, 5, 100, 'email'),
                ),
                const SizedBox(height: 20),
                CutstomTextFieldWidget(
                  name: "Username: ",
                  controller: controller.username,
                  hintText: "Enter your username",
                  validator: (val) =>
                      AppHelper.validateInput(val!, 5, 100, 'username'),
                ),
                const SizedBox(height: 20),
                CutstomTextFieldWidget(
                  name: "Password: ",
                  controller: controller.password,
                  hintText: "Enter your Password",
                  isPassword: true,
                  validator: (val) =>
                      AppHelper.validateInput(val!, 5, 100, 'password'),
                ),
                const SizedBox(height: 40),
                AuthCustomButtonWidget(
                  text: "Signup",
                  onPressed: () => controller.signup(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account?"),
                    TextButton(
                      onPressed: () => Get.offNamed(AppRoutes.login),
                      child: const Text("Login"),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
