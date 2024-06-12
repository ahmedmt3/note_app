import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLoaders {
  static Future<void> showLoading({String? message}) async {
    await Get.dialog(
      PopScope(
        onPopInvoked: (v) => false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: AlertDialog(
            clipBehavior: Clip.hardEdge,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200)),
            backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
            contentPadding: EdgeInsets.zero,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onVerticalDragStart: (v) {
                    Get.back();
                  },
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static Future<void> hideLoading() async {
    if (Get.isDialogOpen!) Get.back();
  }
}
