import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:mini_pos_system/controller/auth_controller.dart';
import 'package:mini_pos_system/screen/responsive.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class LoginScreen extends GetView<AuthscreenController> {
  LoginScreen({super.key}) {
    Get.put(AuthscreenController());
  }
  final _formKey = GlobalKey<FormState>();
  Widget space = SizedBox(height: Responsive.h(5));
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        SizedBox(height: Responsive.h(20)),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
          child: Container(
            height: Responsive.h(75),

            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(50),
              boxShadow:[
                  BoxShadow(
              color: const Color.fromARGB(255, 1, 0, 0).withValues(alpha: 0.2),
               spreadRadius: 2,
               blurRadius: 5,
                )
              ]
            ),
            child: Column(
              children: [
                space,
                Text(
                  "Welcome back!",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "                        please login to your account",
                    style: TextStyle(fontSize: 16, color: AppColors.textPrimary.withAlpha(153)),
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
                          controller: email,
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
                          controller: password,
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
                        InkWell(
                          onTap:()=>Get.toNamed(AppRoute.forgotpasswordscreen),
                          child: Text('forgot password?',style: TextStyle(color:AppColors.primaryDark),)),
                        space,
                        SizedBox(
                          width: Responsive.w(40),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                controller.login(email.text, password.text);
                              }
                            },
                            style:ButtonStyle( backgroundColor: WidgetStatePropertyAll(AppColors.primary)),
                            child: controller.isLoading.value
                                ? const CircularProgressIndicator(
                                    color: AppColors.textPrimary,
                                  )
                                : const Text("Login",style: TextStyle(color:AppColors.background),),
                          ),
                        
                        ),
                       
                        space,
                        SingleChildScrollView(
                          child: Row(
                            children: [
                              SizedBox(width: Responsive.w(20)),
                              Text("Don't have account?",style: TextStyle(color: AppColors.textPrimary),),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(AppRoute.signup);
                                },
                                child: Text("Register",style: TextStyle(color: AppColors.primaryDark),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
