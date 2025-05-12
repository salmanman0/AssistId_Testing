import 'package:assist_test/app/templates/color_app.dart';
import 'package:assist_test/app/templates/font_app.dart';
import 'package:assist_test/app/templates/widget/item_pegawai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../templates/widget/add_pegawai.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: backgroundScreen,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200.h,
                  padding: EdgeInsets.only(left: 32.w, right: 32.w, top: 40.h),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), bottomRight: Radius.circular(16.r))
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Hello Admin!", style: poppins500(20, white)),
                        Text("Jangan lupa bersyukur untuk hari ini!", style: poppins400(14, white)),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200.h,
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
                  color: backgroundScreen,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Text("Pegawai - Assist.id", style: poppins600(18, black)),
                      SizedBox(height: 4.h),
                      Expanded(
                        child: Obx(() {
                          if (controller.isLoading.value) {
                            return Center(child: CircularProgressIndicator(color: primary));
                          }
                          if (controller.pegawai.isEmpty) {
                            return Center(
                              child: Text("Pegawai belum didaftarkan",style: poppins500(16, abupekat)),
                            );
                          }
                          return ListView.builder(
                              itemCount: controller.pegawai.length,
                              itemBuilder: (context, index) {
                                var panjang = controller.pegawai.length;
                                final peg = controller.pegawai[(panjang-1) - index];
                                controller.lastIdPeg = int.parse(controller.pegawai[panjang-1].id);
                                return ItemPegawai(x: context, nama: peg.nama, alamat: peg.jalan, id: peg.id, controller: controller);
                              }
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.35,
              width: MediaQuery.of(context).size.width,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                width: MediaQuery.of(context).size.width,
                height: 100.h,
                decoration: BoxDecoration(
                  color: white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12.r)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8.h),
                        Text("Total Pegawai", style: poppins500(14, black)),
                        Obx(() {
                            if(controller.isLoading.value){
                              return SizedBox(width: 20.w, height: 20.h, child: CircularProgressIndicator(color: primary));
                            }
                            else{
                              return Text('${controller.totalPegawai.value}', style: poppins600(28, black));
                            }
                          }
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (_) => DraggableScrollableSheet(
                            expand: false,
                            minChildSize: 0.5,
                            initialChildSize: 0.75,
                            maxChildSize: 0.9,
                            builder: (_, controllerScroll) => SingleChildScrollView(
                              controller: controllerScroll,
                              child: addPegawaiDialog(controller, controller.lastIdPeg),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(8.r)
                        ),
                        child: Icon(Icons.person_add, color: white, size: 20.r)
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
