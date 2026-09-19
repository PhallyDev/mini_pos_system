import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:mini_pos_system/controller/auth_controller.dart';
class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
    final controller=Get.put(AuthscreenController());
   
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30),

              CircleAvatar(
                radius: 45,
                backgroundColor: Colors.blue.shade50,
                child: Icon(
                  Icons.lock_reset,
                  size: 45,
                  color: Colors.blue,
                ),
              ),

              const SizedBox(height: 30),

              const Text(
                "Forgot Password?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                "Enter your email address and we'll send you a password reset link.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 40),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "example@email.com",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () =>controller.resetPassword(emailController.text.trim()), child: Text("Send Reset Link"),
                    
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
          
                ),
              ),

              const SizedBox(height: 18),

              TextButton(
                onPressed: () =>Get.toNamed(AppRoute.loginScreen),
                child:  Text("Back to Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}