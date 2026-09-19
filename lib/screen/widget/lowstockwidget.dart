import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/controller/product_controller.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class LowStockWidget extends StatelessWidget {
  LowStockWidget({super.key});

  final ProductController controller = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: AppColors.warning,
                ),
                SizedBox(width: 8),
                Text(
                  "Low Stock",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
Obx(() {
  final products = controller.lowStockProducts;

  if (products.isEmpty) {
    return const Text("No low-stock products");
  }

  return Column(
    children: products.map((product) {
      return _productItem(
        product.pName,
        product.pQty,
      );
    }).toList(),
    );
    }),
          ],
        ),
      ),
    );
  }

  Widget _productItem(String name, int quantity) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(name),
      subtitle: Text("$quantity items left"),
      trailing: const Icon(
        Icons.warning_amber_rounded,
        color: AppColors.warning,
      ),
    );
  }
}