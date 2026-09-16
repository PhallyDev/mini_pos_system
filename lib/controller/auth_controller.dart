
import 'package:flutter/widgets.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/screen/small/auth/email_verify_scren.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthscreenController extends GetxController {
  var isLoading = false.obs;

  final username = ''.obs;
  final password = ''.obs;

  final SharedPreferences prefs = Get.find<SharedPreferences>();
  final _supabase = Supabase.instance.client;

  // =========================
  // AUTH ERROR HANDLER
  // =========================
  String getAuthErrorMessage(AuthException e) {
    final statusCode = e.statusCode;

    debugPrint('Auth Status Code: $statusCode');
    debugPrint('Auth Error Code: ${e.code}');
    debugPrint('Auth Message: ${e.message}');

    switch (statusCode) {
      case '400':
        if (e.message.toLowerCase().contains('invalid login')) {
          return 'Incorrect email or password.';
        }

        if (e.message.toLowerCase().contains('email not confirmed')) {
          return 'Please verify your email before logging in.';
        }

        if (e.message.toLowerCase().contains('already registered')) {
          return 'This email is already registered.';
        }

        return 'Invalid request. Please check your information.';

      case '401':
        return 'Authentication failed. Please check your email and password.';

      case '403':
        return 'You do not have permission to perform this action.';

      case '404':
        return 'The requested authentication service was not found.';

      case '409':
        return 'This account already exists.';

      case '422':
        return 'The information you entered is not valid.';

      case '429':
        return 'Too many attempts. Please wait a moment and try again.';

      case '500':
        return 'Supabase server error. Please try again later.';

      case '502':
        return 'The server is temporarily unavailable. Please try again later.';

      case '503':
        return 'Authentication service is temporarily unavailable.';

      default:
        return e.message.isNotEmpty
            ? e.message
            : 'Authentication failed. Please try again.';
    }
  }

  // =========================
  // LOGIN
  // =========================
  Future<void> login(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        await prefs.setString('username', response.user!.id);

        Get.snackbar(
          'Success',
          'Login successful.',
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAndToNamed(AppRoute.mainpage);
      }
    } on AuthException catch (e) {
      final message = getAuthErrorMessage(e);

      Get.snackbar(
        'Login Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint('Unexpected login error: $e');

      Get.snackbar(
        'Connection Error',
        'Something went wrong. Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // SIGNUP
  // =========================
  Future<void> signup(String email, String password) async {
    try {
      isLoading.value = true;

      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (response.user != null) {
        Get.off(() => EmailVerificationScreen());
      } else {
        Get.snackbar(
          'Signup Failed',
          'Account could not be created.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } on AuthException catch (e) {
      final message = getAuthErrorMessage(e);

      Get.snackbar(
        'Signup Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint('Unexpected signup error: $e');

      Get.snackbar(
        'Connection Error',
        'Something went wrong. Please check your internet connection and try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================
  // LOGOUT
  // =========================
  Future<void> logout() async {
    isLoading.value = true;

    try {
      await _supabase.auth.signOut();
      await prefs.remove('username');

      Get.offAllNamed(AppRoute.loginScreen);

      Get.snackbar(
        'Logout',
        'You have been logged out successfully.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } on AuthException catch (e) {
      final message = getAuthErrorMessage(e);

      Get.snackbar(
        'Logout Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      debugPrint('Unexpected logout error: $e');

      Get.snackbar(
        'Error',
        'Failed to log out. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }
}

