import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/config/app_routes.dart';
import 'package:note_app/util/services/initial_bindings.dart';

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
      initialRoute: AppRoutes.home,
      getPages: AppRoutes.routes,
      initialBinding: InitialBinding(),
    );
  }
}
