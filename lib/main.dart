import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walls_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(DevicePreview(
    builder: (context) => MyApp(),
    enabled: !kReleaseMode,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Get.width, Get.height),
      builder: () => GetMaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        title: 'TenX Walls',
        theme: ThemeData.dark().copyWith(
          dialogBackgroundColor: Color(0xFF1B1717),
          backgroundColor: Color(0xFF1B1717),
          primaryColor: Color(0xFFCE1212),
          canvasColor: Color(0xFFEEEBDD),
          scaffoldBackgroundColor: Color(0xFF1B1717),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
