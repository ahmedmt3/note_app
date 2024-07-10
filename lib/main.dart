import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/view/auth/login_view.dart';
import 'package:note_app/view/main/note_view.dart';
import 'package:note_app/view/main/home_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: (() => HomePage()),
        ),
        GetPage(
          name: '/notePage',
          page: () => NoteView(),
        ),
        GetPage(
          name: '/login',
          page: () => const LoginView(),
        )
      ],
    );
  }
}
