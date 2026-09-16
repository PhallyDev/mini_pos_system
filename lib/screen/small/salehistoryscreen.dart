import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/controller/sales_controller.dart';
import 'package:intl/intl.dart';

class SaleHistoryScreen extends StatelessWidget {
  SaleHistoryScreen({super.key});

  final SaleController controller = Get.find<SaleController>();

  @override
  Widget build(BuildContext context) {
    controller.getSales();

    return Scaffold(
      appBar: AppBar(title: const Text("Sale History"), centerTitle: true),

      body: Obx(() {
        if (controller.isLoadingSales.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.sales.isEmpty) {
          return const Center(
            child: Text("No sales yet", style: TextStyle(fontSize: 18)),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.getSales,

          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.sales.length,

            itemBuilder: (_, index) {
              final sale = controller.sales[index];
              final date = sale.createdAt.toLocal();
              return Card(
                margin: const EdgeInsets.only(bottom: 10),

                child: ListTile(
                  leading: const CircleAvatar(child: Icon(Icons.receipt)),

                  title: Text(
                    sale.productName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Text("${sale.qty} × \$${sale.price.toStringAsFixed(2)}"),
                      Text(DateFormat('dd/MM/yyyy HH:mm').format(date)),
                    ],
                  ),

                  trailing: Text(
                    "\$${sale.total.toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
  
  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} "
        "${date.hour.toString().padLeft(2, '0')}:"
        "${date.minute.toString().padLeft(2, '0')}";
  }
}
