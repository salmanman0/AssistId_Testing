import 'dart:async';
import 'package:get/get.dart';
import 'package:assist_test/app/routes/app_pages.dart';

class SplashController extends GetxController {
  void berpindah(){
    Timer(const Duration(milliseconds: 3000), () {
      Get.offAllNamed(Routes.HOME);
    });
  }
  @override
  void onInit() {
    super.onInit();
    berpindah();
  }
}
