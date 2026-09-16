import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/screen/responsive.dart';
import 'package:mini_pos_system/screen/responsive.dart';
import 'package:mini_pos_system/controller/auth_controller.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class Signupscreen extends GetView<AuthscreenController> {
  Signupscreen({super.key}) {
    Get.put(AuthscreenController());
  }
  final _formKey = GlobalKey<FormState>();
  Widget space = SizedBox(height: Responsive.h(5));
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBoy());
  }

  Widget _buildBoy() => Column(
    children: [
      SizedBox(height: Responsive.h(20)),

      Container(
        height: Responsive.h(75),
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(125),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          children: [
            space,
            Text(
              "create account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.surface.withAlpha(179),
              ),
            ),
            space,
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        final emailRegex = RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        );
                        if (!emailRegex.hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    space,
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                    space,
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "confirm password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        if (confirmPasswordController.text !=
                            passwordController.text) {
                          return 'Passwords do not match';
                        }

                        return null;
                      },
                    ),
                    space,
                    SizedBox(
                      width: Responsive.w(40),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            controller.signup(
                              emailController.text,
                              passwordController.text,
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              'Please fix the errors in the form.',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: Text("Signup"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
