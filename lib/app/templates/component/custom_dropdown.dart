import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../color_app.dart';
import '../font_app.dart';


Widget customDropdownWilayah<T>({
  required String label,
  required String hint,
  required List<T> items,
  required T? selectedItem,
  required void Function(T?) onChanged,
  required String Function(T) itemLabel,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: poppins500(16, Colors.yellow[800])),
        SizedBox(height: 4.h),
        DropdownButtonFormField<T>(
          value: selectedItem,
          isExpanded: true,
          dropdownColor: white,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: abudebu),
            ),
          ),
          hint: Text(hint, style: poppins400(14, abupekat)),
          items: items.map((e) {
            return DropdownMenuItem<T>(
              value: e,
              child: Text(itemLabel(e), style: poppins400(14, black)),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ],
    ),
  );
}
