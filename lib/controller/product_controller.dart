import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProductController extends GetxController {
  final supabase = Supabase.instance.client;
  final products = <Product>[].obs;
  final RxString searchQuery = ''.obs;
  List<Product> get lowStockProducts {
    return products.where((product) => product.pQty <= 5).toList();
  }

  final isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  Future<void> editProduct({
    required String pid,
    required String name,
    required double price,
    required int qty,
  }) async {
    await supabase
        .from('products')
        .update({'pname': name, 'pprice': price, 'pqty': qty})
        .eq('pid', pid);

    await getProducts();
  }

  Future<void> getProducts() async {
    isLoading.value = true;
    try {
      final data = await supabase
          .from('products')
          .select()
          .order('create_at', ascending: false);
      products.value = data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      debugPrint(e as String?);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProduct({
    required String name,
    required double price,
    required int qty,
  }) async {
    final userId = supabase.auth.currentUser!.id;

    final existingProduct = await supabase
        .from('products')
        .select()
        .eq('user_id', userId)
        .eq('pname', name)
        .maybeSingle();

    if (existingProduct != null) {
      // Product already exists
      final currentQty = existingProduct['pqty'] as int;

      await supabase
          .from('products')
          .update({'pqty': currentQty + qty})
          .eq('pid', existingProduct['pid']);
    } else {
      // Product doesn't exist
      await supabase.from('products').insert({
        'user_id': userId,
        'pname': name,
        'pprice': price,
        'pqty': qty,
      });
    }

    await getProducts();
  }

  Future<void> updateProduct(Product product) async {
    await supabase
        .from('products')
        .update({
          'pName': product.pName,
          'pPrice': product.pPrice,
          'pQty': product.pQty,
        })
        .eq('pid', product.pid);

    await getProducts();
  }

  Future<void> deleteProduct(String pid) async {
    await supabase.from('products').delete().eq('pid', pid);

    await getProducts();
  }

  List<Product> get filteredProducts {
    if (searchQuery.value.isEmpty) {
      return products;
    }

    return products.where((product) {
      return product.pName.toLowerCase().contains(
        searchQuery.value.toLowerCase(),
      );
    }).toList();
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }
}
