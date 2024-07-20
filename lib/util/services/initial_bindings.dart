import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}