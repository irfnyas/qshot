import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ShareBtn extends StatelessWidget {
  const ShareBtn({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton(
        heroTag: null,
        onPressed: c?.shareModalBtnOnPressed(),
        child: Icon(
          Icons.share,
          size: 32,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
