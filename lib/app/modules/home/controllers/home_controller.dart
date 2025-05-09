import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/api_service.dart';
import '../../../data/models/pegawai_model.dart';
import '../../../data/models/wilayah_model.dart';
import '../../../templates/color_app.dart';

class HomeController extends GetxController {
  final jamMenit = ''.obs;
  final detik = ''.obs;
  final hariTanggal = ''.obs;
  final tanggalHariIni = ''.obs;
  RxBool isLoading = false.obs;

  final nameController = TextEditingController();
  final jalanController = TextEditingController();
  final provinsiController = TextEditingController();
  final kotkabController = TextEditingController();
  final kecamatanController = TextEditingController();
  final kelurahanController = TextEditingController();
  
  final apiService = Get.put(ApiService());
  final RxList<PegawaiModel> pegawai = <PegawaiModel>[].obs;
  RxInt totalPegawai = 0.obs;
  int lastIdPeg = 0;

  Future<void> getPegawai() async {
    try {
      isLoading.value = true;
      final response = await apiService.getPegawai();
      if (response != null) {
        pegawai.assignAll((response).map((e) => PegawaiModel.fromJson(e)).toList());
        totalPegawai.value = pegawai.length;
      } else {
        print("tidak ada pegawai");
      }
    } catch (e) {
      print("gagal pegawai: $e");
    } finally{
      isLoading.value = false;
    }
  }

  Future<void> postPegawai({
    required WilayahModel provinsi,
    required WilayahModel kabupaten,
    required WilayahModel kecamatan,
    required WilayahModel kelurahan,
    required String idPeg,
  }) async {
    try {
      isLoading.value = true;

      final nama = nameController.text;
      final jalan = jalanController.text;
      final idBaru = idPeg;

      final response = await apiService.postPegawai(
        id: idBaru,
        nama: nama,
        jalan: jalan,
        provinsi: {
          "id": provinsi.id,
          "name": provinsi.name,
        },
        kabupaten: {
          "id": kabupaten.id,
          "province_id": provinsi.id,
          "name": kabupaten.name,
        },
        kecamatan: {
          "id": kecamatan.id,
          "regency_id": kabupaten.id,
          "name": kecamatan.name,
        },
        kelurahan: {
          "id": kelurahan.id,
          "district_id": kecamatan.id,
          "name": kelurahan.name,
        }
      );

      if (response != null) {
        Get.showSnackbar(
          GetSnackBar(
            title: "Sukses",
            message: "Pegawai berhasil ditambahkan",
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green.shade500,
            borderRadius: 10,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.check_circle_outline, color: white),
            isDismissible: true,
          ),
        );
        getPegawai();
      }
    } catch (e) {
      print("Gagal kirim pegawai: $e");
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updatePegawai({
    required WilayahModel provinsi,
    required WilayahModel kabupaten,
    required WilayahModel kecamatan,
    required WilayahModel kelurahan,
    required String idPeg,
  }) async {
    try {
      isLoading.value = true;

      final nama = nameController.text;
      final jalan = jalanController.text;

      final response = await apiService.updatePegawai(
        id: idPeg,
        nama: nama,
        jalan: jalan,
        provinsi: {
          "id": provinsi.id,
          "name": provinsi.name,
        },
        kabupaten: {
          "id": kabupaten.id,
          "province_id": provinsi.id,
          "name": kabupaten.name,
        },
        kecamatan: {
          "id": kecamatan.id,
          "regency_id": kabupaten.id,
          "name": kecamatan.name,
        },
        kelurahan: {
          "id": kelurahan.id,
          "district_id": kecamatan.id,
          "name": kelurahan.name,
        },
      );

      if (response != null) {
        Get.showSnackbar(
          GetSnackBar(
            title: "Sukses",
            message: "Data pegawai berhasil diperbarui",
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green.shade500,
            borderRadius: 10,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.edit_note, color: white),
            isDismissible: true,
          ),
        );
        getPegawai();
      }
    } catch (e) {
      Get.showSnackbar(
        GetSnackBar(
          title: "Gagal",
          message: "Terjadi kesalahan teknis, silahkan ulangi",
          duration: const Duration(seconds: 3),
          backgroundColor: Colors.redAccent.shade100,
          borderRadius: 10,
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          snackPosition: SnackPosition.TOP,
          icon: Icon(Icons.warning_amber_rounded, color: white),
          isDismissible: true,
        ),
      );
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deletePegawai(String idPeg) async {
    final response = await apiService.deletePegawai(idPeg);
    if(response!=null){
      Get.showSnackbar(
          GetSnackBar(
            title: "Sukses",
            message: "Data pegawai berhasil dihapus",
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.green.shade500,
            borderRadius: 10,
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            snackPosition: SnackPosition.TOP,
            icon: Icon(Icons.edit_note, color: white),
            isDismissible: true,
          ),
        );
      getPegawai();
    }
    else {
      Get.showSnackbar(
        GetSnackBar(
          title: "Gagal",
          message: "Terjadi kesalahan teknis, silahkan ulangi",
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
  }

  @override
  void onInit() {
    getPegawai();
    super.onInit();
  }
}
