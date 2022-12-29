import 'package:get/get.dart';

import '../../common/data/api.dart';

class CameraRepository {
  static Future<Response?> getRandomQuote() async {
    const url = 'https://api.quotable.io/random';
    const query = {'maxLength': '60'};
    return Api.doConnect(Api.client.get(url, query: query));
  }
}
