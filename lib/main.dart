import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/screen/responsive.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:mini_pos_system/screen/appcolors.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:shared_preferences/shared_preferences.dart';
Future<void> main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    final prefs = await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(prefs);
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      // ignore: deprecated_member_use
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.light(
          primary: AppColors.primary,
          surface: AppColors.surface,
          error: AppColors.error,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
        ),
      ),
      home: Responsive(),
      getPages: AppRoute.route,
      debugShowCheckedModeBanner: false,
    );
  }
}



