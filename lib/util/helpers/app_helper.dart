import 'package:flutter/material.dart';

class AppHelper {
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
}
