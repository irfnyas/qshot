import 'package:get/get.dart';

import '../domain/modal.dart';

class Api {
  Api._();

  static final client = GetConnect(allowAutoSignedCert: true);

  static Future<Response?> doConnect(Future<Response?> request) async {
    Response? res;
    try {
      final req = await request;

      switch (req?.statusCode) {
        case 200:
          res = req;
          break;
        default:
          Modal.confirmDialog(
            title: 'Error',
            content: req?.bodyString,
          );
      }
    } catch (e) {
      Modal.confirmDialog(title: 'Error', content: '$e');
    }
    return res;
  }
}
