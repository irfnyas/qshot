import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

import 'controller.dart';
import 'display/btm_toolbar.dart';
import 'display/cam_container.dart';
import 'display/filter_container.dart';
import 'display/quote_container.dart';
import 'display/flash_container.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = Get.put(CameraController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Screenshot(
        controller: c.screenshotController,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CamContainer(c: c),
            FilterContainer(c: c),
            QuoteContainer(c: c),
            FlashContainer(c: c),
            BtmToolbar(c: c),
          ],
        ),
      ),
    );
  }
}
