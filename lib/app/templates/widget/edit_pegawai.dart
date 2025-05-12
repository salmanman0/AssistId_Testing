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

Future<void> editPegawaiDialog(BuildContext context, HomeController controller, String idPegawai) async {
  final wilayahController = Get.put(WilayahController());
  final pegawai = controller.pegawai.firstWhereOrNull((e) => e.id == idPegawai);

  if (pegawai == null) {
    Get.snackbar("Error", "Data pegawai tidak ditemukan", backgroundColor: Colors.red, colorText: white);
    return;
  }

  Get.dialog(
    Center(child: CircularProgressIndicator(color: primary)),
    barrierDismissible: false,
  );

  controller.nameController.text = pegawai.nama;
  controller.jalanController.text = pegawai.jalan;

  await wilayahController.fetchProvinces();
  wilayahController.selectedProvince.value =
      wilayahController.provinces.firstWhereOrNull((e) => e.id == pegawai.provinsi.id);

  if (wilayahController.selectedProvince.value != null) {
    await wilayahController.fetchRegencies(wilayahController.selectedProvince.value!.id);
    wilayahController.selectedRegency.value =
        wilayahController.regencies.firstWhereOrNull((e) => e.id == pegawai.kabupaten.id);
  }

  if (wilayahController.selectedRegency.value != null) {
    await wilayahController.fetchDistricts(wilayahController.selectedRegency.value!.id);
    wilayahController.selectedDistrict.value =
        wilayahController.districts.firstWhereOrNull((e) => e.id == pegawai.kecamatan.id);
  }

  if (wilayahController.selectedDistrict.value != null) {
    await wilayahController.fetchVillages(wilayahController.selectedDistrict.value!.id);
    wilayahController.selectedVillage.value =
        wilayahController.villages.firstWhereOrNull((e) => e.id == pegawai.kelurahan.id);
  }
  Get.back();
  await showModalBottomSheet(
    context: context,
    backgroundColor: white,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) => DraggableScrollableSheet(
      expand: false,
      minChildSize: 0.5,
      initialChildSize: 0.75,
      maxChildSize: 0.9,
      builder: (_, controllerScroll) => Obx(() {
        final bottomInset = MediaQuery.of(context).viewInsets.bottom;
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: primary));
        }
        return Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 20.h,
            bottom: 20.h + bottomInset,
          ),
          child: SingleChildScrollView(
            controller: controllerScroll,
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
                Text("Edit Pegawai", style: poppins700(16, black)),
                SizedBox(height: 16.h),
                customTextField(
                  label: "Nama",
                  placeholder: "Nama Pegawai",
                  controller: controller.nameController,
                ),
                customTextField(
                  label: "Jalan",
                  placeholder: "Alamat Pegawai",
                  controller: controller.jalanController,
                ),
                customDropdownWilayah<WilayahModel>(
                  label: "Provinsi",
                  hint: "Pilih Provinsi",
                  items: wilayahController.provinces,
                  selectedItem: wilayahController.selectedProvince.value,
                  onChanged: (value) {
                    wilayahController.selectedProvince.value = value;
                    wilayahController.selectedRegency.value = null;
                    wilayahController.selectedDistrict.value = null;
                    wilayahController.selectedVillage.value = null;
                    wilayahController.fetchRegencies(value!.id);
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
                    wilayahController.selectedVillage.value = null;
                    wilayahController.fetchDistricts(value!.id);
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
                    wilayahController.selectedVillage.value = null;
                    wilayahController.fetchVillages(value!.id);
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
                  },
                  itemLabel: (e) => e.name,
                ),
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.redAccent,
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
                            controller.updatePegawai(
                              idPeg: idPegawai,
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
                                backgroundColor: Colors.red,
                                borderRadius: 10,
                                margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                snackPosition: SnackPosition.TOP,
                                icon: Icon(Icons.warning_amber_rounded, color: white),
                                isDismissible: true,
                              ),
                            );
                          }
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
      }),
    ),
  );

  // Reset semua data setelah sheet ditutup
  controller.nameController.clear();
  controller.jalanController.clear();
  wilayahController.selectedProvince.value = null;
  wilayahController.selectedRegency.value = null;
  wilayahController.selectedDistrict.value = null;
  wilayahController.selectedVillage.value = null;
  wilayahController.provinces.clear();
  wilayahController.regencies.clear();
  wilayahController.districts.clear();
  wilayahController.villages.clear();
}
