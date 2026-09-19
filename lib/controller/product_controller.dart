import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/model/product_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';

class ProductController extends GetxController {
  final isLoading = false.obs;
  final supabase = Supabase.instance.client;
  final products = <Product>[].obs;
  final RxString searchQuery = ''.obs;
  final ImagePicker picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  //check low stock
  List<Product> get lowStockProducts {
    return products.where((product) => product.pQty <= 5).toList();
  }

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  //////////////////////////CRUD product
  ///edit or update
  Future<void> editProduct({
    required String pid,
    required String name,
    required double price,
    required int qty,
    final String? imageUrl,
  }) async {
    await supabase
        .from('products')
        .update({
          'pname': name,
          'pprice': price,
          'pqty': qty,
          'imageurl': imageUrl,
        })
        .eq('pid', pid);

    await getProducts();
  }

  //delete
  Future<void> deleteProduct(Product product) async {
  try {
    // Delete image from Storage first
    if (product.imageUrl != null && product.imageUrl!.isNotEmpty) {
      final uri = Uri.parse(product.imageUrl!);
      final filePath = uri.pathSegments
          .skipWhile((segment) => segment != 'Product')
          .skip(1)
          .join('/');

      if (filePath.isNotEmpty) {
        await supabase.storage.from('Product').remove([filePath]);
      }
    }

    // Delete product from database
    await supabase
        .from('products')
        .delete()
        .eq('pid', product.pid);

    // Refresh products
    await getProducts();

    Get.snackbar(
      'Success',
      'Product deleted successfully',
    );
  } catch (e) {
    debugPrint('DELETE PRODUCT ERROR: $e');

    Get.snackbar(
      'Error',
      'Failed to delete product',
    );
  }
}

  //read
  Future<void> getProducts() async {
    final userId = supabase.auth.currentUser!.id;
    isLoading.value = true;
    try {
      final data = await supabase
          .from('products')
          .select()
          .eq('user_id', userId)
          .order('create_at', ascending: false);
      products.value = data.map((e) => Product.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Get products error $e');
    } finally {
      isLoading.value = false;
    }
  }

  //add
  Future<void> addProduct({
    required String name,
    required double price,
    required int qty,
    File? imageFile,
  }) async {
    final userId = supabase.auth.currentUser!.id;
    debugPrint('IMAGE FILE: $imageFile');

    final existingProduct = await supabase
        .from('products')
        .select()
        .eq('user_id', userId)
        .eq('pname', name)
        .maybeSingle();

    if (existingProduct != null) {
      //check  Product already exists
      final currentQty = existingProduct['pqty'] as int;

      await supabase
          .from('products')
          .update({'pqty': currentQty + qty})
          .eq('pid', existingProduct['pid']);
    } else {
      // Product doesn't exist
      String? imageUrl;

      if (imageFile != null) {
        imageUrl = await uploadImage(imageFile);
      }
      if (imageUrl == null) {
        Get.snackbar("unsucessed", 'Image upload failed');
      }

      await supabase.from('products').insert({
        'user_id': userId,
        'pname': name,
        'pprice': price,
        'pqty': qty,
        'imageurl': imageUrl,
      });
    }

    await getProducts();
  }

  // Search Product
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

  // update search textbox's value
  void updateSearch(String value) {
    searchQuery.value = value;
  }

  ////pick image
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);

      debugPrint('IMAGE PICKED: ${image.path}');
    } else {
      debugPrint('NO IMAGE SELECTED');
    }
  }

  ////uploadimage
  Future<String?> uploadImage(File imageFile) async {
    try {
      final userId = supabase.auth.currentUser!.id; // check user id

      final extension = path.extension(imageFile.path); // read path of image

      final fileName =
           '$userId/${DateTime.now().millisecondsSinceEpoch}$extension';

      debugPrint('UPLOADING: $fileName');

      await supabase.storage.from('Product').upload(fileName, imageFile);
      debugPrint('UPLOAD SUCCESS');
      selectedImage.value = null;

      final imageUrl = supabase.storage.from('Product').getPublicUrl(fileName);

      debugPrint('IMAGE URL: $imageUrl');

      return imageUrl;
    } catch (e) {
      debugPrint('UPLOAD IMAGE ERROR: $e');
      return null;
    }
  }
}
