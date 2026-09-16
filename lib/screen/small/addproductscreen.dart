import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/controller/product_controller.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class AddProductScreen extends GetView<ProductController> {
  AddProductScreen({super.key});

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final qtyController = TextEditingController();

 Future<void> _addProduct() async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  try {
    debugPrint('Adding product...');

    await controller.addProduct(
      name: nameController.text.trim(),
      price: double.parse(priceController.text.trim()),
      qty: int.parse(qtyController.text.trim()),
    );

    debugPrint('Product added successfully');

    Get.back();

    Get.snackbar(
      'Success',
      'Product added successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  } catch (e) {
    debugPrint('ADD PRODUCT ERROR: $e');

    Get.snackbar(
      'Error',
      e.toString(),
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product'),
        backgroundColor: AppColors.primary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Product Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              // Product Name
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Product Name',
                  hintText: 'e.g. Coca Cola',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory_2_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Price
              TextFormField(
                controller: priceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  labelText: 'Price',
                  hintText: 'e.g. 1.50',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter price';
                  }

                  final price = double.tryParse(value);

                  if (price == null || price <= 0) {
                    return 'Enter a valid price';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Quantity
              TextFormField(
                controller: qtyController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  hintText: 'e.g. 20',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter quantity';
                  }

                  final qty = int.tryParse(value);

                  if (qty == null || qty < 0) {
                    return 'Enter a valid quantity';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              // Add Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _addProduct,
                  child: const Text(
                    'Add Product',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}