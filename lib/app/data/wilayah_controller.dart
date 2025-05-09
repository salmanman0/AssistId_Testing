import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/wilayah_model.dart';

class WilayahController extends GetxController {
  var provinces = <WilayahModel>[].obs;
  var regencies = <WilayahModel>[].obs;
  var districts = <WilayahModel>[].obs;
  var villages = <WilayahModel>[].obs;

  var selectedProvince = Rxn<WilayahModel>();
  var selectedRegency = Rxn<WilayahModel>();
  var selectedDistrict = Rxn<WilayahModel>();
  var selectedVillage = Rxn<WilayahModel>();

  @override
  void onInit() {
    super.onInit();
    fetchProvinces();
  }

  Future<void> fetchProvinces() async {
    final response = await http.get(Uri.parse('https://www.emsifa.com/api-wilayah-indonesia/api/provinces.json'));
    if (response.statusCode == 200) {
      provinces.value = (json.decode(response.body) as List)
          .map((e) => WilayahModel.fromJson(e))
          .toList();
    }
  }

  Future<void> fetchRegencies(String provinceId) async {
    final response = await http.get(Uri.parse('https://www.emsifa.com/api-wilayah-indonesia/api/regencies/$provinceId.json'));
    if (response.statusCode == 200) {
      regencies.value = (json.decode(response.body) as List)
          .map((e) => WilayahModel.fromJson(e))
          .toList();
    }
  }

  Future<void> fetchDistricts(String regencyId) async {
    final response = await http.get(Uri.parse('https://www.emsifa.com/api-wilayah-indonesia/api/districts/$regencyId.json'));
    if (response.statusCode == 200) {
      districts.value = (json.decode(response.body) as List)
          .map((e) => WilayahModel.fromJson(e))
          .toList();
    }
  }
  
  Future<void> fetchVillages(String districtId) async {
    final response = await http.get(Uri.parse('https://www.emsifa.com/api-wilayah-indonesia/api/villages/$districtId.json'));
    if (response.statusCode == 200) {
      villages.value = (json.decode(response.body) as List)
          .map((e) => WilayahModel.fromJson(e))
          .toList();
    }
  }
}
