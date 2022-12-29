import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class EditBtn extends StatelessWidget {
  const EditBtn({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton.small(
        heroTag: null,
        onPressed: c?.editBtnOnPressed(),
        child: const Icon(Icons.edit),
      ),
    );
  }
}
