import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../display/confirm_dialog.dart';

class Modal {
  Modal._();

  static Future<bool?> confirmDialog({
    String? title,
    String? content,
    String? action,
    Color? color,
  }) async {
    return await Get.dialog(
      ConfirmDialog(
        title: title,
        content: content,
        action: action,
        color: color,
      ),
    );
  }

  static void simpleSnackbar({String? message, Color? color}) {
    Get.rawSnackbar(
      message: message,
      backgroundColor: color ?? Get.theme.primaryColor,
      animationDuration: const Duration(milliseconds: 500),
      snackPosition: SnackPosition.TOP,
    );
  }
}
