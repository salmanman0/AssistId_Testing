import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';
import 'app/templates/color_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Size screenSize = const Size(412, 917);
    return ScreenUtilInit(
      designSize: screenSize,
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Assist-E",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          scaffoldBackgroundColor: backgroundScreen,
          canvasColor: primary,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: primary,
            selectionColor: secondary,
            selectionHandleColor: primary,
          ),
          inputDecorationTheme: InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primary)),
          )
        ),
        
      ),
    );
  }
}
