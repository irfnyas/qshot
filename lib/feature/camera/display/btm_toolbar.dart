import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import 'edit_btn.dart';
import 'shuffle_btn.dart';
import 'snap_btn.dart';

class BtmToolbar extends StatelessWidget {
  const BtmToolbar({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedOpacity(
        opacity: c?.isSnapping.value == true ? 0 : 1,
        duration: const Duration(milliseconds: 100),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShuffleBtn(c: c),
                SnapBtn(c: c),
                EditBtn(c: c),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
