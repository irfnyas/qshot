import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.title,
    this.content,
    this.action,
    this.color,
  }) : super(key: key);

  final String? title;
  final String? content;
  final String? action;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null ? Text(title ?? '') : null,
      content: title != null ? Text(content ?? '') : null,
      actions: action != null
          ? [
              TextButton(
                onPressed: () => Get.back(),
                style: TextButton.styleFrom(foregroundColor: Colors.black87),
                child: const Text('BACK'),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: color ?? Theme.of(context).primaryColor,
                ),
                onPressed: () => Get.back(result: true),
                child: Text(action ?? ''),
              )
            ]
          : null,
    );
  }
}
