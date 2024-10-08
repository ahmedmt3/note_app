import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/view/auth/widgets/auth_custom_button_widget.dart';
import 'package:note_app/view/auth/widgets/cutstom_text_field_widget.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CutstomTextFieldWidget(
                name: "Username: ",
                controller: controller.username,
                hintText: "Enter your username",
              ),
              const SizedBox(height: 20),
              CutstomTextFieldWidget(
                name: "Password: ",
                controller: controller.password,
                hintText: "Enter your Password",
                isPassword: true,
              ),
              const SizedBox(height: 40),
              AuthCustomButtonWidget(
                text: "Login",
                onPressed: controller.login,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont have an account?"),
                  TextButton(
                    onPressed: controller.goToSignup,
                    child: const Text("Signup"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
