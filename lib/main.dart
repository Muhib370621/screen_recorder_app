import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:screen_record_app/services/local_storage/local_storage.dart';
import 'package:screen_record_app/views/screens/auth/login_screen.dart';

void main() {
  LocalStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_ , child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Screen Recorder App',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: const LoginScreen(),
        );
      },
      child: const LoginScreen(),
    );

  }
}


