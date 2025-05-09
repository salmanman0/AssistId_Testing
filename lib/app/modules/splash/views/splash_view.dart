import 'package:assist_test/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../templates/animate.dart';
import '../../../templates/color_app.dart';
import '../../../templates/font_app.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundScreen,
        child: Column(
          children: [
            const Expanded(child: SizedBox.shrink()),
            SizedBox(height: 100.h),
            TopIn(duration: const Duration(milliseconds: 1500), child: Image.asset('assets/logo.png', scale: 1.5,)),
            const Expanded(child: SizedBox.shrink()),
            InkWell(
              onDoubleTap: controller.berpindah,
              child: Container(
                width: 200.w,
                height: 100.h,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(100.r), topRight: Radius.circular(100.r)),
                ),
                child: Center(child: BottomIn(duration: const Duration(milliseconds: 1500), child: Text('Assist.id', style: poppins500(14, white)))),
              ),
            ),
          ],
        ),
      )
    );
  }
}
