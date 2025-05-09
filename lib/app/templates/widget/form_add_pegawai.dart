import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/wilayah_model.dart';
import '../../data/wilayah_controller.dart';

class AddPegawaiForm extends StatelessWidget {
  final WilayahController controller = Get.put(WilayahController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Tambah Pegawai", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          Obx(() {
            return DropdownButtonFormField<WilayahModel>(
              value: controller.selectedProvince.value,
              hint: Text("Pilih Provinsi"),
              items: controller.provinces.map((prov) {
                return DropdownMenuItem(
                  value: prov,
                  child: Text(prov.name),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedProvince.value = value;
                controller.selectedRegency.value = null;
                controller.selectedDistrict.value = null;
                controller.regencies.clear();
                controller.districts.clear();
                if (value != null) {
                  controller.fetchRegencies(value.id);
                }
              },
            );
          }),
          SizedBox(height: 16),
          Obx(() {
            return DropdownButtonFormField<WilayahModel>(
              value: controller.selectedRegency.value,
              hint: Text("Pilih Kabupaten/Kota"),
              items: controller.regencies.map((kab) {
                return DropdownMenuItem(
                  value: kab,
                  child: Text(kab.name),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedRegency.value = value;
                controller.selectedDistrict.value = null;
                controller.districts.clear();
                if (value != null) {
                  controller.fetchDistricts(value.id);
                }
              },
            );
          }),
          SizedBox(height: 16),
          Obx(() {
            return DropdownButtonFormField<WilayahModel>(
              value: controller.selectedDistrict.value,
              hint: Text("Pilih Kecamatan"),
              items: controller.districts.map((kec) {
                return DropdownMenuItem(
                  value: kec,
                  child: Text(kec.name),
                );
              }).toList(),
              onChanged: (value) {
                controller.selectedDistrict.value = value;
              },
            );
          }),
        ],
      ),
    );
  }
}
