import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qshot/feature/camera/controller.dart';

class FlashContainer extends StatelessWidget {
  const FlashContainer({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(milliseconds: 100),
        opacity: c?.isFlashShown.value == true ? 1 : 0,
        child: Container(color: Colors.grey.shade50),
      ),
    );
  }
}
