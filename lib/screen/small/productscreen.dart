import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:mini_pos_system/controller/product_controller.dart';
import 'package:mini_pos_system/screen/appcolors.dart';
import 'package:mini_pos_system/screen/small/editproductscreen.dart';
import '../widget/searchbar_widget.dart';

class Productscreen extends StatelessWidget {
  final controller = Get.put(ProductController());

  Productscreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Management"),
        actions: [
          InkWell(
            child: Icon(Icons.add, size: 30),
            onTap: () => {
              Get.toNamed(AppRoute.addProduct), //dak screen
            },
          ),
        ],
        backgroundColor: AppColors.primary,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: SearchbarWidget(),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: controller.getProducts,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: controller.filteredProducts.length,
                    itemBuilder: (_, index) {
                      final product = controller.filteredProducts[index];
                      return Card(
                        
                        child: ListTile(
                          leading:ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: product.imageUrl != null && product.imageUrl!.isNotEmpty
                               ? Image.network(
                                      product.imageUrl!,
                                      width: 55,
                                      height: 55,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image_not_supported);
                                      },
                                 )
                                : Container(
                                    width: 55,
                                    height: 55,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image),
                                  ),
                        ),
                          title: Text(product.pName),
                          subtitle: Text(
                            "Stock: ${product.pQty}",
                            style: TextStyle(
                              color: product.pQty >= 5
                                  ? AppColors.textSecondary
                                  : AppColors.error,
                            ),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("\$${product.pPrice}"),

                              const SizedBox(width: 10),

                              // Edit
                              IconButton(
                                onPressed: () {
                                  Get.to(() => EditProductScreen(product: product));
                                },
                                icon: const Icon(Icons.edit),
                              ),

                              // Delete
                              IconButton(
                                onPressed: () {
                                  Get.dialog(
                                    AlertDialog(
                                      title: const Text('Delete Product'),
                                      content: const Text(
                                        'Are you sure to delete this product?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back(); // Cancel
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            Get.back(); // Close dialog

                                            await controller.deleteProduct(
                                              product,
                                            );
                                          },
                                          child: const Text(
                                            'Delete',
                                            style: TextStyle(
                                              color: AppColors.error,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: AppColors.error,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
              const SizedBox(height: 10),
              Text("${controller.products.length} product"),
            ],
          ),
        ),
      ),
    );
  }
}
