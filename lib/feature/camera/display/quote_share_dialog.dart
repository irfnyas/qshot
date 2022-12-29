import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qshot/feature/camera/display/save_btn.dart';
import 'package:qshot/feature/camera/display/share_btn.dart';
import '../controller.dart';
import 'back_btn.dart';

class QuoteShareDialog extends StatelessWidget {
  const QuoteShareDialog({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      content: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        alignment: Alignment.topCenter,
        curve: Curves.ease,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.memory(c?.screenshotFile.value ?? Uint8List(0)),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceAround,
      contentPadding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      actions: [
        BackBtn(c: c),
        ShareBtn(c: c),
        SaveBtn(c: c),
      ],
    );
  }
}
