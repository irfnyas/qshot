import 'dart:io';

import 'package:camera/camera.dart' as cam;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class CamContainer extends StatelessWidget {
  const CamContainer({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          AnimatedOpacity(
            opacity: c?.isCamInitialized.value == true ? 1 : 0,
            duration: const Duration(milliseconds: 250),
            child: c?.isCamInitialized.value == true
                ? cam.CameraPreview(c!.camController)
                : const SizedBox(),
          ),
          Visibility(
            visible: c?.isCamFileShown.value == true,
            child: Image.file(c?.camFile.value ?? File('')),
          )
        ],
      ),
    );
  }
}
