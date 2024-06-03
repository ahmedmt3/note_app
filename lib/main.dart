import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/view/add_notes.dart';
import 'package:note_app/view/home.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: (() => HomePage())),
        GetPage(name: '/addNote', page: (() => AddNote()),
        )
      ],
    );
  }
}