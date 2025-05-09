import 'wilayah_model.dart';

class PegawaiModel {
  final String id;
  final String nama;
  final String jalan;
  final WilayahModel provinsi;
  final WilayahModel kabupaten;
  final WilayahModel kecamatan;
  final WilayahModel kelurahan;

  PegawaiModel({
    required this.id,
    required this.nama,
    required this.jalan,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
  });

  factory PegawaiModel.fromJson(Map<String, dynamic> json) {
    // Berguna untuk mengubah nilai dari lokasi yang tidak benar
    WilayahModel parseWilayah(dynamic data) {
      if (data is Map<String, dynamic> && data.isNotEmpty) {
        return WilayahModel.fromJson(data);
      } else {
        return WilayahModel(id: '0', name: 'Tidak diketahui');
      }
    }

    return PegawaiModel(
      id: json['id']?.toString() ?? '0',
      nama: json['nama'] ?? 'Nama tidak tersedia',
      jalan: json['jalan'] ?? '-',
      provinsi: parseWilayah(json['provinsi']),
      kabupaten: parseWilayah(json['kabupaten']),
      kecamatan: parseWilayah(json['kecamatan']),
      kelurahan: parseWilayah(json['kelurahan']),
    );
  }
}
