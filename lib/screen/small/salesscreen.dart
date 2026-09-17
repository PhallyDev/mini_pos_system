import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:mini_pos_system/controller/product_controller.dart';
import 'package:mini_pos_system/controller/sales_controller.dart';
import 'package:mini_pos_system/screen/appcolors.dart';
import 'package:mini_pos_system/screen/widget/searchbar_widget.dart';

class Salesscreen extends StatelessWidget {
  Salesscreen({super.key});

  final ProductController productController = Get.find<ProductController>();
  final SaleController saleController = Get.put(SaleController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sales"),backgroundColor: AppColors.primary,
      actions: [
        ElevatedButton(
          style: ButtonStyle(backgroundColor:WidgetStatePropertyAll(AppColors.surface.withAlpha(100))),
          onPressed: ()=>Get.toNamed(AppRoute.saleHistory),
          child:Text("Sale History",
          style:TextStyle(color:AppColors.textPrimary,
        ),
        ))
      ],
      bottom:PreferredSize(preferredSize:Size.fromHeight(70), child:SearchbarWidget()),
      ),
      body: Obx(() {
        if (productController.products.isEmpty) {
          return const Center(child: Text("No products available."));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: productController.filteredProducts.length,
          itemBuilder: (_, index) {
            final product = productController.filteredProducts[index];

            return Card(
              elevation: 3,
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Product Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: product.imageUrl != null
                          ? Image.network(
                              product.imageUrl!,
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 70,
                              height: 70,
                              color: AppColors.border,
                              child: const Icon(Icons.inventory),
                            ),
                    ),

                    const SizedBox(width: 12),

                    /// Product Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.pName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text("\$${product.pPrice.toStringAsFixed(2)}"),

                          Text(
                            "Stock: ${product.pQty}",
                            style: TextStyle(
                              color: product.pQty <= 5
                                  ? AppColors.error
                                  : AppColors.success,
                            ),
                          ),

                          const SizedBox(height: 10),

                          /// Quantity Selector
                          Obx(() {
                            final qty = saleController.getQty(product.pid);

                            return Row(
                              children: [
                                IconButton(
                                  onPressed: qty > 1
                                      ? () =>
                                            saleController.decrease(product.pid)
                                      : null,
                                  icon: const Icon(Icons.remove_circle_outline),
                                ),

                                Text(
                                  qty.toString(),
                                  style: const TextStyle(fontSize: 18),
                                ),

                                IconButton(
                                  onPressed: qty < product.pQty
                                      ? () =>
                                            saleController.increase(product.pid)
                                      : null,
                                  icon: const Icon(Icons.add_circle_outline),
                                ),

                                const Spacer(),

                                ElevatedButton.icon(
                                  onPressed: product.pQty == 0? null : () {
                              final qty = saleController.getQty(product.pid);

                                  Get.defaultDialog(
                                    title: "Confirm Sale",
                                    middleText:
                                        "Sell $qty × ${product.pName}?\n\nTotal: \$${(product.pPrice * qty).toStringAsFixed(2)}",
                                    textCancel: "Cancel",
                                    textConfirm: "Sell",
                                    onConfirm: () {
                                      Get.back();
                                      saleController.sellProduct(product, qty);
                                    },
                                  );
                                },
                                  icon: const Icon(Icons.shopping_cart_checkout,),label: const Text("Sell"),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
