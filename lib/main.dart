import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/view/note_view.dart';
import 'package:note_app/view/home_view.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: (() => HomePage())),
        GetPage(
          name: '/addNote',
          page: (() => AddNote()),
        )
      ],
    );
  }
}
