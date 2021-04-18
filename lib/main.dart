import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walls_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(Get.width, Get.height),
      builder: () => GetMaterialApp(
        title: 'TenX Walls',
        theme: ThemeData.dark().copyWith(
          dialogBackgroundColor: Color(0xFF141414),
          backgroundColor: Color(0xFF141414),
          primaryColor: Color(0xFFCE1212),
          canvasColor: Color(0xFFCE1212),
          scaffoldBackgroundColor: Color(0xFF141414),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
