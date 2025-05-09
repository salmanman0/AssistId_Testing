import 'package:get/get.dart';

class ApiClient extends GetConnect {
  static const String _baseUrl = 'https://61601920faa03600179fb8d2.mockapi.io';
  
  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.addRequestModifier<void>((request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';
      return request;
    });
    super.onInit();
  }

}