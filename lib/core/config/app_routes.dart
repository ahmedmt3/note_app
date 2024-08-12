import 'package:get/get.dart';
import 'package:note_app/util/services/app_middlewares.dart';
import 'package:note_app/view/auth/login_view.dart';
import 'package:note_app/view/auth/signup_view.dart';
import 'package:note_app/view/main/home_view.dart';
import 'package:note_app/view/main/note_view.dart';

class AppRoutes {
  static const String home = '/';
  static const String note = '/note';
  static const String login = '/login';
  static const String signup = '/signup';

  static List<GetPage> routes = [
    GetPage(
      name: home,
      page: (() => HomePage()),
    ),
    GetPage(
      name: note,
      page: () => NoteView(),
    ),
    GetPage(
      name: login,
      page: () => const LoginView(),
      middlewares: appMiddlewares,
    ),
    GetPage(
      name: signup,
      page: () => const SignupView(),
    )
  ];
}
