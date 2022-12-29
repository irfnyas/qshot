import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';

class FilterContainer extends StatelessWidget {
  const FilterContainer({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              c?.filterColor.value.withOpacity(0.33) ?? Colors.transparent,
              c?.filterColor.value.withOpacity(0.66) ?? Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}
