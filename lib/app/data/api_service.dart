import 'package:get/get.dart';
import 'api_client.dart';

class ApiService extends GetxService {
  final ApiClient _apiClient = Get.put(ApiClient());

  // GET
  Future<List<dynamic>?> getPegawai() async {
    final response = await _apiClient.get('/pegawai');
    return response.body;
  }

  // POST
  Future<Map<String, dynamic>?> postPegawai({required String nama, required String jalan, required Map<String, dynamic> provinsi, required Map<String, dynamic> kabupaten, required Map<String, dynamic> kecamatan, required Map<String, dynamic> kelurahan, required String id}) async {
    final payload = {
      'id': id,
      'nama': nama,
      'jalan': jalan,
      'provinsi': provinsi,
      'kabupaten': kabupaten,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
    };

    final response = await _apiClient.post('/pegawai', payload);
    return response.body;
  }

  // UPDATE
  Future<Map<String, dynamic>?> updatePegawai({required String nama, required String jalan, required Map<String, dynamic> provinsi, required Map<String, dynamic> kabupaten, required Map<String, dynamic> kecamatan, required Map<String, dynamic> kelurahan, required String id}) async {
    final payload = {
      'nama': nama,
      'jalan': jalan,
      'provinsi': provinsi,
      'kabupaten': kabupaten,
      'kecamatan': kecamatan,
      'kelurahan': kelurahan,
    };

    final response = await _apiClient.put('/pegawai/$id', payload);
    return response.body;
  }

  // DELETE
  Future<Map<String, dynamic>?>deletePegawai(String id) async {
    final response = await _apiClient.delete('/pegawai/$id');
    return response.body;
  }
}