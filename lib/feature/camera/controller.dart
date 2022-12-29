import 'dart:io';
import 'dart:math';

import 'package:camera/camera.dart' as cam;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:social_share/social_share.dart';

import '../../common/domain/constant.dart';
import '../../common/domain/modal.dart';
import '../../common/enum/screen_state_enum.dart';
import 'display/quote_edit_sheet.dart';
import 'display/quote_share_dialog.dart';
import 'domain/camera_screen_modal.dart';
import 'repository.dart';

class CameraController extends GetxController {
  final screenState = ScreenState.init.obs;

  final screenshotController = ScreenshotController();
  final screenshotFile = Uint8List(0).obs;
  final isSnapping = false.obs;
  final isFlashShown = false.obs;

  final quoteText = ''.obs;
  final quoteColor = Colors.grey.shade50.obs;
  final quoteNode = FocusNode();
  final quoteController = TextEditingController();

  final filterColor = Colors.grey.shade500.obs;
  final filterColorList = Colors.primaries.map((e) => e.shade500).toList();

  final isCamInitialized = false.obs;
  final camFile = File('').obs;
  final isCamFileShown = false.obs;
  late cam.CameraController camController;

  @override
  void onReady() {
    super.onReady();
    WidgetsFlutterBinding.ensureInitialized();
    initFun();
  }

  @override
  void onClose() {
    camController.dispose();
    super.onClose();
  }

  Future<void> initFun() async {
    await randomize();
    await initCams();
  }

  Future<void> initCams() async {
    await cam.availableCameras().then(
      (value) async {
        camController = cam.CameraController(
          value.first,
          cam.ResolutionPreset.max,
        );

        await camController.initialize();
        await Future.delayed(const Duration(seconds: 1));

        camController.setFlashMode(cam.FlashMode.off);
        isCamInitialized.value = true;
      },
    ).catchError(
      (e) {
        Modal.confirmDialog(
          title: dictError,
          content: '$e',
        );
      },
    );
  }

  Future<void> randomize() async {
    setFilterColor();
    await getRandomQuote();
  }

  Future<void> getRandomQuote() async {
    screenState.value = ScreenState.loading;

    await Future.delayed(const Duration(seconds: 1));
    final res = await CameraRepository.getRandomQuote();
    if (res != null) {
      quoteText.value = res.body['content'];
      quoteController.text = quoteText.value;
    }

    screenState.value = ScreenState.idle;
  }

  Future<void> showModal(CameraScreenModal modal) async {
    if (isCamInitialized.value) {
      camController.pausePreview();
      await Future.delayed(const Duration(milliseconds: 250));
    }

    switch (modal) {
      case CameraScreenModal.edit:
        await showEditSheet();
        break;
      case CameraScreenModal.share:
        await showShareDialog();
        break;
    }

    if (isCamInitialized.value) {
      await Future.delayed(const Duration(milliseconds: 250));
      camController.resumePreview();
    }
  }

  Future<void> showEditSheet() async {
    sortFilterColorList();
    await Get.bottomSheet(
      QuoteEditSheet(c: this),
      backgroundColor: Get.theme.canvasColor,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
    );
  }

  Future<void> showShareDialog() async {
    isSnapping.value = true;
    await Future.delayed(const Duration(milliseconds: 250));

    await camTakePic();
    isCamFileShown.value = true;

    await doFlashEffect();
    await Future.delayed(const Duration(milliseconds: 500));

    await doScreenshot();
    if (screenshotFile.value.isNotEmpty) {
      await Get.dialog(
        QuoteShareDialog(c: this),
        barrierDismissible: false,
      );
    }

    await Future.delayed(const Duration(milliseconds: 250));
    isCamFileShown.value = false;
    isSnapping.value = false;
  }

  Future<void> camTakePic() async {
    await camController
        .takePicture()
        .then((value) => camFile.value = File(value.path))
        .catchError((e) {
      Modal.confirmDialog(title: dictError, content: '$e');
    });
  }

  Future<void> doScreenshot() async {
    await screenshotController
        .capture(pixelRatio: Get.pixelRatio)
        .then((value) => screenshotFile.value = value ?? Uint8List(0))
        .catchError((e) {
      Modal.confirmDialog(title: dictError, content: '$e');
    });
  }

  Future<void> doFlashEffect() async {
    isFlashShown.value = true;
    await Future.delayed(const Duration(milliseconds: 100));
    isFlashShown.value = false;
  }

  Future<void> doShare() async {
    try {
      final dir = await getTemporaryDirectory();
      final file = await File('${dir.path}/image.png').create();
      await file.writeAsBytes(screenshotFile.value);

      await SocialShare.shareOptions(
        quoteText.value,
        imagePath: file.path,
      );
    } catch (e) {
      //
    }
  }

  Future<void> doSave() async {
    try {
      if (!await Permission.storage.status.isGranted) {
        await Permission.storage.request();
        if (!await Permission.storage.status.isGranted) {
          Modal.simpleSnackbar(
            message: dictErrNoStoragePermission,
            color: Colors.red.shade700,
          );
          return;
        }
      }

      final dir = Platform.isAndroid
          ? Directory('/storage/emulated/0/Download')
          : await getApplicationDocumentsDirectory();
      final date = DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now());
      final file = await File('${dir.path}/QShot/qshot_$date.png').create(
        recursive: true,
      );
      await file.writeAsBytes(screenshotFile.value);

      Modal.simpleSnackbar(message: dictSavedToStorage);
    } catch (e) {
      Modal.confirmDialog(title: dictError, content: '$e');
    }
  }

  void unfocusForm() {
    quoteNode.unfocus();
  }

  void setFilterColor({int? i}) {
    final index = i ?? Random().nextInt(filterColorList.length);
    filterColor.value = filterColorList[index];
  }

  void sortFilterColorList() {
    filterColorList
      ..removeWhere((item) => item == filterColor.value)
      ..insert(0, filterColor.value);
  }

  /*
    View Controller
  */
  void Function()? shuffleBtnOnPressed() {
    return screenState.value.isLoading() ? null : () => randomize();
  }

  void Function()? snapBtnOnPressed() {
    return screenState.value.isLoading() || isSnapping.value == true
        ? null
        : () => showModal(CameraScreenModal.share);
  }

  void Function()? editBtnOnPressed() {
    return screenState.value.isLoading()
        ? null
        : () => showModal(CameraScreenModal.edit);
  }

  void Function()? randomFormBtnOnPressed() {
    return screenState.value.isLoading() ? null : () => getRandomQuote();
  }

  void Function()? colorFormBtnOnPressed(int i) {
    return screenState.value.isLoading() ? null : () => setFilterColor(i: i);
  }

  void Function()? doneFormBtnOnPressed() {
    return screenState.value.isLoading() ? null : () => unfocusForm();
  }

  void Function()? backModalBtnOnPressed() {
    return screenState.value.isLoading() ? null : () => Get.back();
  }

  void Function()? shareModalBtnOnPressed() {
    return screenState.value.isLoading() ? null : () => doShare();
  }

  void Function()? saveModalBtnOnPressed() {
    return screenState.value.isLoading() ? null : () => doSave();
  }
}
