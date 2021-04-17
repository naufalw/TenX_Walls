import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:walls_flutter/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
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
          primaryColor: Color(0xFFCE1212),
          canvasColor: Color(0xFFEEEBDD),
          scaffoldBackgroundColor: Color(0xFF1B1717),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
