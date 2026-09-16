import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/controller/product_controller.dart';
import 'package:mini_pos_system/model/product_model.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class EditProductScreen extends StatelessWidget {
  Product product;
  EditProductScreen({super.key, required this.product});

  final ProductController controller = Get.put(ProductController());

  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Fill the form with existing product data
    nameController.text = product.pName;
    priceController.text = product.pPrice.toString();
    qtyController.text = product.pQty.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Edit Product')),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price'),
            ),

            const SizedBox(height: 15),

            TextFormField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),

            const SizedBox(height: 25),

            ElevatedButton(
              onPressed: () async {
                await controller.editProduct(
                  pid: product.pid,
                  name: nameController.text,
                  price: double.parse(priceController.text),
                  qty: int.parse(qtyController.text),
                );

                Get.back();
              },
              child: const Text('Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
