import 'package:e_commerce_demo/core/constants/app_strings.dart';
import 'package:e_commerce_demo/presetation/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  final AuthController userController = Get.find<AuthController>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.signUp)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: TextEditingController(),
              decoration: const InputDecoration(labelText: AppStrings.userName),
            ),
            TextField(
              controller: TextEditingController(),
              obscureText: true,
              decoration: const InputDecoration(labelText: AppStrings.password),
            ),
            ElevatedButton(
              onPressed: signUp,
              child: const Text(AppStrings.signUp),
            ),
          ],
        ),
      ),
    );
  }

  void signUp() {
    String username = usernameController.text;
    String password = passwordController.text;

    // Check if the entered username already exists
    bool isUsernameTaken =
        userController.users.any((user) => user['username'] == username);

    if (isUsernameTaken) {
      // Show an error message if the username is already taken
      Get.snackbar(
        AppStrings.signUpFailed,
        AppStrings.userAlreadyTaken,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      // Add the new user to the AuthController's list
      userController.users.add({'username': username, 'password': password});

      // Show a success message
      Get.snackbar(
        AppStrings.signUpSuccess,
        AppStrings.signUpSuccess,
        snackPosition: SnackPosition.BOTTOM,
      );

      // Navigate back to the login screen
      Get.back();
    }
  }
}
