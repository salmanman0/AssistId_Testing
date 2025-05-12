import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../data/wilayah_controller.dart';
import '../../modules/home/controllers/home_controller.dart';
import '../color_app.dart';
import 'delete_pegawai.dart';
import 'detail_pegawai.dart';
import 'edit_pegawai.dart';
import '../font_app.dart';

class ItemPegawai extends StatelessWidget {
  final BuildContext x;
  final String nama;
  final String alamat;
  final String id;
  final HomeController controller;
  final wilayahController = Get.put(WilayahController());
  ItemPegawai({
    super.key,
    required this.x,
    required this.nama,
    required this.alamat,
    required this.id,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      onTap: () {
        showModalBottomSheet(
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
            builder: (_, controllerScroll) => SingleChildScrollView(
              controller: controllerScroll,
              child: detailPegawaiDialog(controller,id),
            ),
          ),
        ).whenComplete((){
          controller.nameController.clear();
          controller.jalanController.clear();
          controller.provinsiController.clear();
          controller.kotkabController.clear();
          controller.kecamatanController.clear();
          controller.kelurahanController.clear();
        });
      },
      child: Container(
        width: double.infinity,
        height: 80.h,
        margin: EdgeInsets.only(bottom: 10.h),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 0,
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(nama, style: poppins600(14, black)),
                Text(alamat, style: poppins400(12, abupekat)),
              ],
            ),
            PopupMenuButton<String>(
              color: backgroundScreen,
              onSelected: (value) {
                if (value == 'edit') {
                  editPegawaiDialog(context, controller, id);
                } else if (value == 'hapus') {
                  showDeletePegawaiDialog(
                    context: context,
                    controller: controller,
                    id: id,
                  );
                }
              },
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit', style: poppins500(12, black)),
                ),
                PopupMenuItem(
                  value: 'hapus',
                  child: Text('Hapus', style: poppins500(12, black)),
                ),
              ],
              icon: const Icon(Icons.more_horiz),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ),
    );
  }
}
