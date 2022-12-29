import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class ShuffleBtn extends StatelessWidget {
  const ShuffleBtn({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => FloatingActionButton.small(
        onPressed: c?.shuffleBtnOnPressed(),
        child: AnimatedCrossFade(
          firstChild: const Icon(Icons.shuffle),
          secondChild: SizedBox.square(
            dimension: 24,
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: CircularProgressIndicator(
                color: Colors.grey.shade50,
                strokeWidth: 2,
              ),
            ),
          ),
          crossFadeState: c?.screenState.value.isLoading() == true
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 250),
        ),
      ),
    );
  }
}
