import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class SaveBtn extends StatelessWidget {
  const SaveBtn({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton.small(
        heroTag: null,
        onPressed: c?.saveModalBtnOnPressed(),
        child: Icon(
          Icons.file_download_outlined,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
