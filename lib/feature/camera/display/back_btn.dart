import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton.small(
        heroTag: null,
        onPressed: c?.backModalBtnOnPressed(),
        child: Icon(
          Icons.arrow_back,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
