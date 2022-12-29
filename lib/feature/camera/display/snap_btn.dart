import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class SnapBtn extends StatelessWidget {
  const SnapBtn({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton(
        heroTag: null,
        onPressed: c?.snapBtnOnPressed(),
        child: const Icon(Icons.camera, size: 56),
      ),
    );
  }
}
