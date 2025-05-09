import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../color_app.dart';
import '../font_app.dart';

Widget customTextField({
  required String label,
  required String placeholder,
  required TextEditingController controller,
  String? detail,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: poppins500(16, Colors.yellow[800])),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: placeholder,
            hintStyle: poppins400(14, abupekat),
            enabled: detail != 'detail',
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: abudebu),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          ),
        ),
      ],
    ),
  );
}
