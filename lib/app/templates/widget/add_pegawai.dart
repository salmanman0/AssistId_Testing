import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/models/wilayah_model.dart';
import '../../data/wilayah_controller.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../color_app.dart';
import '../component/custom_dropdown.dart';
import '../component/custom_text_field.dart';
import '../font_app.dart';

Widget addPegawaiDialog(HomeController controller, int idPegawai) {
  final wilayahController = Get.put(WilayahController());
  return Obx(() {
    if (controller.isLoading.value) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 20.h,
        bottom: 20.h + MediaQuery.of(Get.context!).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
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
            Text("Tambah Pegawai", style: poppins700(16, black)),
            SizedBox(height: 16.h),
            customTextField(label: "Nama", placeholder: "Nama Pegawai", controller: controller.nameController),
            customTextField(label: "Jalan",placeholder: "Alamat Pegawai",controller: controller.jalanController),
            customDropdownWilayah<WilayahModel>(
              label: "Provinsi",
              hint: "Pilih Provinsi",
              items: wilayahController.provinces,
              selectedItem: wilayahController.selectedProvince.value,
              onChanged: (value) {
                wilayahController.selectedProvince.value = value;
                wilayahController.selectedRegency.value = null;
                wilayahController.selectedDistrict.value = null;
                wilayahController.fetchRegencies(value!.id);
                controller.provinsiController.text = value.name;
              },
              itemLabel: (e) => e.name,
            ),
            customDropdownWilayah<WilayahModel>(
              label: "Kota/Kabupaten",
              hint: "Pilih Kota/Kabupaten",
              items: wilayahController.regencies,
              selectedItem: wilayahController.selectedRegency.value,
              onChanged: (value) {
                wilayahController.selectedRegency.value = value;
                wilayahController.selectedDistrict.value = null;
                wilayahController.fetchDistricts(value!.id);
                // controller.kotkabController.text = value.name;
              },
              itemLabel: (e) => e.name,
            ),
            customDropdownWilayah<WilayahModel>(
              label: "Kecamatan",
              hint: "Pilih Kecamatan",
              items: wilayahController.districts,
              selectedItem: wilayahController.selectedDistrict.value,
              onChanged: (value) {
                wilayahController.selectedDistrict.value = value;
                // controller.kecamatanController.text = value!.name;
              },
              itemLabel: (e) => e.name,
            ),
            customDropdownWilayah<WilayahModel>(
              label: "Kelurahan",
              hint: "Pilih Kelurahan",
              items: wilayahController.villages,
              selectedItem: wilayahController.selectedVillage.value,
              onChanged: (value) {
                wilayahController.selectedVillage.value = value;
                // controller.kecamatanController.text = value!.name;
              },
              itemLabel: (e) => e.name,
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () => Get.back(),
                    child: Text("Batal", style: poppins500(13, white)),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    onPressed: () {
                      final prov = wilayahController.selectedProvince.value;
                      final reg = wilayahController.selectedRegency.value;
                      final dist = wilayahController.selectedDistrict.value;
                      final vil = wilayahController.selectedVillage.value;

                      if (prov != null && reg != null && dist != null && vil != null) {
                        controller.postPegawai(
                          idPeg: (idPegawai+1).toString(),
                          provinsi: prov,
                          kabupaten: reg,
                          kecamatan: dist,
                          kelurahan: vil,
                        );
                      } else {
                        Get.showSnackbar(
                          GetSnackBar(
                            title: "Gagal",
                            message: "Lengkapi semua wilayah terlebih dahulu",
                            duration: const Duration(seconds: 3),
                            backgroundColor: Colors.redAccent.shade100,
                            borderRadius: 10,
                            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                            snackPosition: SnackPosition.TOP,
                            icon: Icon(Icons.warning_amber_rounded, color: white),
                            isDismissible: true,
                          ),
                        );

                      }
                      Get.back();
                    },
                    child: Text("Simpan", style: poppins500(13, white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  });
}
