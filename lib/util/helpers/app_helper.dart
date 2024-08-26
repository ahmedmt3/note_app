import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class AppHelper {
  /// Validating inputus from diffrent types
  static String? validateInput(String val, int min, int max, String type) {
    if (type == 'username') {
      if (!GetUtils.isUsername(val)) {
        return "Invalid username";
      }
    }
    if (type == 'email') {
      if (!GetUtils.isEmail(val)) {
        return "Invalid email type";
      }
    }
    if (val.isEmpty) {
      return "Can't be empty";
    }
    if (val.length < min) {
      return "Can't be less than $min";
    }
    if (val.length > max) {
      return "Can't be larger than $max";
    }
    return null;
  }

  /// ### 📆 Formate the dateTime object to human readable format.
  static String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inSeconds < 60) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      int weeks = (difference.inDays / 7).floor();
      return '$weeks weeks ago';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '$months months ago';
    } else {
      int years = (difference.inDays / 365).floor();
      return '$years years ago';
    }
  }

  // Cheks if hex-color code is valid
  static bool isValidHexColor(String color) {
    final hexColorPattern = RegExp(r'^[0-9A-Fa-f]{6}$');
    return !hexColorPattern.hasMatch(color);
  }

  static double screenHeight(BuildContext ctx) {
    return MediaQuery.of(ctx).size.height;
  }

  static double screenWidth(BuildContext ctx) {
    return MediaQuery.of(ctx).size.width;
  }

  static SnackbarController showSnackbar({
    required String title,
    required String message,
    bool isError = true,
  }) {
    return Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      isDismissible: true,
      backgroundColor: isError ? Colors.red[400] : Colors.green,
      colorText: Colors.white,
    );
  }

   /// Checks internet connection, Returns `true` if online, `false` if offline
  static Future<bool> checkInternet() async {
    try {
      var result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
