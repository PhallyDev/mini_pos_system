import 'package:flutter/material.dart'; 
import 'package:get/get.dart';
import 'package:mini_pos_system/controller/splash_controller.dart'; 
import 'package:mini_pos_system/screen/appcolors.dart';
 
class Splashscreen extends StatelessWidget { 
  Splashscreen({super.key}) { 
    Get.put(SplashController()); 
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: AppColors.primary,
              ),
              child: const Icon(
                Icons.point_of_sale,
                color: AppColors.surface,
                size: 55,
              ),
            ),

            const SizedBox(height: 25),

            // App name
            const Text(
              "Mini POS",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "Simple. Fast. Reliable.",
              style: TextStyle(
                fontSize: 15,
                color: AppColors.textSecondary,
              ),
            ),

            const SizedBox(height: 35),

            const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
 