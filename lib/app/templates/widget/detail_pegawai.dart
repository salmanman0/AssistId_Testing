import 'package:assist_test/app/templates/component/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../modules/home/controllers/home_controller.dart';
import '../color_app.dart';
import '../font_app.dart';

Widget detailPegawaiDialog(HomeController controller, String idPegawai) {
  final pegawai = controller.pegawai.firstWhereOrNull((e) => e.id == idPegawai);

  if (pegawai == null) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Text("Data pegawai tidak ditemukan"),
    );
  }
  controller.nameController.text = pegawai.nama;
  controller.jalanController.text = pegawai.jalan;
  controller.provinsiController.text = pegawai.provinsi.name;
  controller.kotkabController.text = pegawai.kabupaten.name;
  controller.kecamatanController.text = pegawai.kecamatan.name;
  controller.kelurahanController.text = pegawai.kelurahan.name;

  return Builder(
  builder: (context) => Obx(() {
    if (controller.isLoading.value) {
      return SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator(color: primary)),
      );
    }
    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: 20.h + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          Text("Detail Pegawai", style: poppins700(16, black)),
          SizedBox(height: 16.h),
          customTextField(label: "Nama", placeholder: "Nama Pegawai", controller: controller.nameController, detail: 'detail'),
          customTextField(label: "Jalan", placeholder: "Alamat Pegawai", controller: controller.jalanController, detail: 'detail'),
          customTextField(label: "Provinsi", placeholder: "Provinsi Pegawai", controller: controller.provinsiController, detail: 'detail'),
          customTextField(label: "Kota/Kabupaten", placeholder: "Kota Pegawai", controller: controller.kotkabController, detail: 'detail'),
          customTextField(label: "Kecamatan", placeholder: "Kecamatan Pegawai", controller: controller.kecamatanController, detail: 'detail'),
          customTextField(label: "Kelurahan", placeholder: "Kelurahan Pegawai", controller: controller.kelurahanController, detail: 'detail'),
        ],
      ),
    );
  })
  );
}
