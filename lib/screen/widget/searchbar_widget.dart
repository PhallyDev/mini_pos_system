import 'package:flutter/material.dart';
import 'package:mini_pos_system/controller/product_controller.dart';
import 'package:mini_pos_system/screen/responsive.dart';
import 'package:get/get.dart';

class SearchbarWidget extends StatelessWidget {
  SearchbarWidget({super.key});
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.h(6), // previously 50
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 255, 255),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.2),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child:  TextField(
        onChanged: controller.updateSearch,
        decoration: InputDecoration(
          hintText: "Search",
          prefixIcon: Icon(Icons.search),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }
}
