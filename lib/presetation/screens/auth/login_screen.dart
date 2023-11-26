import 'package:e_commerce_demo/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_commerce_demo/presetation/screens/auth/signup_screen.dart';

import '../../controllers/auth/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final AuthController userController = Get.put(AuthController());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.login)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: AppStrings.userName),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: AppStrings.password),
            ),
            ElevatedButton(
              onPressed: () {
                userController.login(
                    usernameController.text, passwordController.text);
              },
              child: const Text(AppStrings.signUp),
            ),
            TextButton(
              onPressed: () {
                Get.to(SignUpScreen());
              },
              child: const Text(AppStrings.createAccount),
            ),
          ],
        ),
      ),
    );
  }
}
