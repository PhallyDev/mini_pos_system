import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/controller/home_controller.dart';
import 'package:mini_pos_system/screen/large/homescreenlarge.dart';
import 'package:mini_pos_system/screen/medium/homescreenmedium.dart';
import 'package:mini_pos_system/screen/small/splashscren.dart';

class Responsive extends GetResponsiveView<HomeController> {
  Widget? small, medium, large;
  Responsive({super.key, this.small, this.medium, this.large});

  // Responsive helpers
  static double w(double percentage) => Get.width * (percentage / 100);
  static double h(double percentage) => Get.height * (percentage / 100);
  @override
  Widget? phone() {
    return Splashscreen();
  }

  @override
  Widget? tablet() {
    return Homescreenmedium();
  }

  @override
  Widget? desktop() {
    return Homescreenlarge();
  }
}
