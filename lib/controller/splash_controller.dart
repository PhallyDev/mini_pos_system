import 'package:get/get.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

// dashboard_controller.dart
class SplashController extends GetxController {
  RxInt selectedIndex = 0.obs;

  void changeIndex(int index) => selectedIndex.value = index;

  @override
  void onInit() {
    super.onInit();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    final prefs = Get.find<SharedPreferences>();
    await Future.delayed(const Duration(seconds: 1)); // optional splash delay
    if (prefs.getString('username') != null) {
      Get.offAllNamed(AppRoute.mainpage);
    } else {
      Get.offAllNamed(AppRoute.loginScreen);
    }
  }
}