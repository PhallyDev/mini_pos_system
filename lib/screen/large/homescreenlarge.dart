import 'package:flutter/material.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class Homescreenlarge extends StatelessWidget {
  const Homescreenlarge({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(color: AppColors.background),
      child: Center(
        child: Text(
          "This app is not supported for  laptop or tablet screen. Please use a mobile device to access the app.",
          style: TextStyle(color: AppColors.textPrimary, fontSize: 30),
        ),
      )
    );
  }
}
