import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeController extends GetxController {
  final prefs = Get.find<SharedPreferences>();
  final supabase = Supabase.instance.client;

  final name = "".obs;
  final todaySales = 0.0.obs;
  final transactions = 0.obs;

  @override
  void onInit() {
    super.onInit();

    getName();
    getTodaySales();
    
  }

  void getName() {
    name.value = prefs.getString("name") ?? "";
  }

  void saveName(String newName) {
    prefs.setString("name", newName);

    name.value = newName;

    Get.back();

    Get.snackbar(
      "Success",
      "Name is changed",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  Future<void> getTodaySales() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) return;

      final now = DateTime.now();

      final startOfDay = DateTime(
        now.year,
        now.month,
        now.day,
      );

      final endOfDay = startOfDay.add(
        const Duration(days: 1),
      );

      final data = await supabase
          .from('sales')
          .select('total, create_at')
          .eq('user_id', user.id)
          .gte(
            'create_at',
            startOfDay.toIso8601String(),
          )
          .lt(
            'create_at',
            endOfDay.toIso8601String(),
          );

      double total = 0;

      for (final sale in data) {
        total += (sale['total'] as num).toDouble();
      }

      todaySales.value = total;
      transactions.value = data.length;
    } catch (e) {
      debugPrint("Today's sales error: $e");
    }
  }
}