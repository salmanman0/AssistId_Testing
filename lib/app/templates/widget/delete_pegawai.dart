import 'package:flutter/material.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../color_app.dart';
import '../font_app.dart';

Future<void> showDeletePegawaiDialog({
  required BuildContext context,
  required HomeController controller,
  required String id,
}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: backgroundScreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text("Konfirmasi", style: poppins700(16, black)),
        content: Text("Yakin ingin menghapus pegawai ini?", style: poppins400(14, black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Batal", style: poppins500(13, Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onPressed: () {
              Navigator.of(context).pop();
              controller.deletePegawai(id);
            },
            child: Text("Hapus", style: poppins500(13, white)),
          ),
        ],
      );
    },
  );
}
