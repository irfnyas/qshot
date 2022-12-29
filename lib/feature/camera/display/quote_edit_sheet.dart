import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller.dart';
import '../../../common/domain/constant.dart';

class QuoteEditSheet extends StatelessWidget {
  const QuoteEditSheet({Key? key, this.c}) : super(key: key);
  final CameraController? c;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  maxLines: 4,
                  controller: c?.quoteController,
                  focusNode: c?.quoteNode,
                  onChanged: (value) => c?.quoteText.value = value,
                  keyboardType: TextInputType.multiline,
                  maxLength: 60,
                  decoration: InputDecoration(
                    isDense: true,
                    enabled: !(c?.screenState.value.isLoading() ?? true),
                    label: const Text(dictQuote),
                    hintText: dictQuoteFieldEmpty,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    suffixIcon: Column(
                      children: [
                        IconButton(
                          onPressed: c?.randomFormBtnOnPressed(),
                          padding: const EdgeInsets.all(0),
                          splashRadius: 16,
                          icon: const Icon(Icons.shuffle),
                        ),
                        IconButton(
                          onPressed: c?.doneFormBtnOnPressed(),
                          padding: const EdgeInsets.all(0),
                          splashRadius: 16,
                          icon: const Icon(Icons.done),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 56,
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemBuilder: (_, i) => FloatingActionButton(
                    heroTag: null,
                    onPressed: c?.colorFormBtnOnPressed(i),
                    backgroundColor: c?.filterColorList[i],
                    child: Obx(
                      () => AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: c?.filterColor.value == c?.filterColorList[i]
                            ? 1
                            : 0,
                        child: const Icon(Icons.done),
                      ),
                    ),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemCount: c?.filterColorList.length ?? 0,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
