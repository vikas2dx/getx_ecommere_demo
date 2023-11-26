// main.dart
import 'package:e_commerce_demo/presetation/controllers/auth/auth_controller.dart';
import 'package:e_commerce_demo/presetation/screens/auth/login_screen.dart';
import 'package:e_commerce_demo/presetation/screens/home/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices(); // Initialize services (such as GetStorage)

  runApp(const MyApp());
}

Future<void> initServices() async {
  await GetStorage.init(); // Initialize GetStorage
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: GetX<AuthController>(
        init: AuthController(),
        builder: (controller) {
          return controller.isLoggedIn.value
              ? const HomeScreen()
              : LoginScreen();
        },
      ),
      initialBinding: BindingsBuilder(() {
        Get.put(AuthController());
      }),
    );
  }
}
