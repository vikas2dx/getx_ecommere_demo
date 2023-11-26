import 'package:e_commerce_demo/presetation/screens/auth/login_screen.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;
import 'package:get_storage/get_storage.dart';

import '../../screens/home/product_screen.dart';

class AuthController extends GetxController {
  RxList<Map<String, String>> users = <Map<String, String>>[].obs;
  RxBool isLoggedIn = false.obs;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    loadUsers();
    loadLoginState();
  }

  Future<void> loadLoginState() async {
    isLoggedIn.value = storage.read('isLoggedIn') ?? false;
  }

  Future<void> saveLoginState() async {
    await storage.write('isLoggedIn', isLoggedIn.value);
  }

  Future<void> loadUsers() async {
    String data = await rootBundle.loadString('assets/json/users.json');

    List<dynamic> decodedData = convert.jsonDecode(data);
    users.value = decodedData
        .whereType<Map<String, dynamic>>() // Filter out non-maps
        .map((dynamic map) => Map<String, String>.from(
            map)) // Convert each map to the desired type
        .toList();
  }

  void login(String username, String password) {
    // Set isLoggedIn to true upon successful login
    isLoggedIn.value = true;
    saveLoginState();

    // Check if the entered username and password match any user
    bool isUserExists = users.any(
        (user) => user['username'] == username && user['password'] == password);

    if (isUserExists) {
      // Navigate to the home screen if login is successful
      Get.to(const HomeScreen());
    } else {
      Get.snackbar(
        'Login Failed',
        'Invalid username or password',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void logout() {
    // Set isLoggedIn to false upon successful logout
    isLoggedIn.value = false;
    saveLoginState();

    // Navigate to LoginPage after successful logout
    Get.offAll(() => LoginScreen());
  }
}
