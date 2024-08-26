import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:note_app/core/config/app_routes.dart';

List<GetMiddleware> appMiddlewares = [AuthMiddleware()];

final GetStorage _box = GetStorage();

class AuthMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (_box.read<Map<String, dynamic>>('user') != null) {
      return const RouteSettings(name: AppRoutes.home);
    }
    return null;
  }
}
