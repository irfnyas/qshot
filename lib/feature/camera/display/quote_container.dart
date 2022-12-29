import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller.dart';

class QuoteContainer extends StatelessWidget {
  const QuoteContainer({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: c?.screenState.value.isLoading() == true ? 0 : 1,
        child: Container(
          padding: const EdgeInsets.all(32),
          child: Text(
            c?.quoteText.value ?? '',
            textAlign: TextAlign.center,
            style: GoogleFonts.courgette(
              textStyle: Theme.of(context).textTheme.displaySmall,
              color: c?.quoteColor.value,
            ),
          ),
        ),
      ),
    );
  }
}
