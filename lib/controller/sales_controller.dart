
import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mini_pos_system/model/sale_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mini_pos_system/model/product_model.dart';
import 'product_controller.dart';

class SaleController extends GetxController {
  final supabase = Supabase.instance.client;
  final ProductController productController = Get.find<ProductController>();
  final user = Supabase.instance.client.auth.currentUser;
  final RxMap<String, int> selectedQty = <String, int>{}.obs;
  final RxBool isLoading = false.obs;

  int getQty(String productId) => selectedQty[productId] ?? 1;
  final RxList<Sale> sales = <Sale>[].obs;
  final recentsale = <Sale>[].obs;
  final isLoadingSales = false.obs;
  @override
  void onInit() async {
    super.onInit();
    await getSales();
    await fetchRecentSale();
  }

  Future<void> fetchRecentSale() async {
    if (user == null) return;

    try {
      final data = await supabase
          .from('sales')
          .select()
          .eq('user_id', user!.id)
          .order('create_at', ascending: false)
          .limit(3);

      recentsale.value = (data as List).map((e) => Sale.fromJson(e)).toList();
    } on PostgrestException catch (e) {
      String message;

      switch (e.code) {
        case 'PGRST301': // Unauthorized
          message = "Please log in again.";
          break;
        case 'PGRST116': // No rows found (when using .single())
          message = "No recent sales found.";
          break;
        case '23505': // Duplicate
          message = "Duplicate data.";
          break;
        case '23503': // Foreign key
          message = "Related data is missing.";
          break;
        case '42501': // RLS/Permission denied
          message = "You don't have permission.";
          break;
        default:
          message = e.message;
      }

      Get.snackbar("Database Error", message);
    } on SocketException {
      Get.snackbar("No Internet", "Check your connection.");
    } on TimeoutException {
      Get.snackbar("Timeout", "Server took too long to respond.");
    } catch (e) {
      Get.snackbar("Error", "Something went wrong.");
      print(e);
    }
  }

  Future<void> getSales() async {
    try {
      isLoadingSales.value = true;

      final user = supabase.auth.currentUser;

      if (user == null) return;

      final response = await supabase
          .from('sales')
          .select()
          .eq('user_id', user.id)
          .order('create_at', ascending: false);

      sales.value = response.map<Sale>((json) => Sale.fromJson(json)).toList();
    } catch (e) {
      Get.snackbar("Error", "$e");
      // debugPrint("$e");
    } finally {
      isLoadingSales.value = false;
    }
  }

  void increase(String productId) {
    selectedQty[productId] = getQty(productId) + 1;
  }

  void decrease(String productId) {
    if (getQty(productId) > 1) {
      selectedQty[productId] = getQty(productId) - 1;
    }
  }

  Future<void> sellProduct(Product product, int qty) async {
    try {
      isLoading.value = true;

      if (qty > product.pQty) {
        Get.snackbar("Error", "Not enough stock.");
        return;
      }

      final user = supabase.auth.currentUser;
      if (user == null) return;

      // 1. Insert sale

      await supabase.from('sales').insert({
        'user_id': user.id,
        'product_id': product.pid,
        'product_name': product.pName,
        'qty': qty,
        'price': product.pPrice,
        'total': product.pPrice * qty,
      });

      // 2. Update stock
      await supabase
          .from('products')
          .update({'pqty': product.pQty - qty})
          .eq('pid', product.pid);

      // 3. Refresh products
      await productController.getProducts();
      await getSales();
      await fetchRecentSale();
      // 4. Reset quantity selector
      selectedQty[product.pid] = 1;

      Get.snackbar(
        "Success",
        "Sold $qty × ${product.pName}",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
