import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.mark_email_read_outlined,
                size: 100,
                color: AppColors.primary,
              ),
              const SizedBox(height: 24),

              const Text(
                "Verify Your Email",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "We've sent a verification email to your email",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),

              const SizedBox(height: 12),

              const Text(
                "Please open your inbox and click the verification link before logging in.",
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed('/login');
                  },
                  child: const Text("Back to Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}