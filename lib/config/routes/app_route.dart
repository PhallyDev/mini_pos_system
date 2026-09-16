import 'package:get/get.dart';
import 'package:mini_pos_system/screen/responsive.dart';
import 'package:mini_pos_system/screen/small/addproductscreen.dart';
import 'package:mini_pos_system/screen/small/auth/email_verify_scren.dart';
import 'package:mini_pos_system/screen/small/auth/loginscreen.dart';
import 'package:mini_pos_system/screen/small/auth/signupscreen.dart';
import 'package:mini_pos_system/screen/small/splashscren.dart';
import 'package:mini_pos_system/screen/small/mainpage.dart';
import 'package:mini_pos_system/screen/small/homescreen.dart';
import 'package:mini_pos_system/screen/small/name.dart';
import 'package:mini_pos_system/screen/small/salehistoryscreen.dart';

//use AppRoute.name.routeName   to navigate to the route
class AppRoute {
  static const changename = '/name';
  static const responsive = '/resonsive';
  static const dashboard = '/dashboard';
  static const signup = '/signup';
  static const loginScreen = '/login';
  static const homescreen = '/homescreen';
  static const mainpage = '/mainpage';
  static const productScreen = '/productScreen';
  static const productDetailScreen = '/ProductDetailscreen';
  static const saleScreen = '/saleScreen';
  static const addProduct = '/addProduct';
  static const saleHistory = '/saleHistory';
  static const verify = '/verifyscreen';
  static final route = [
    GetPage(name: verify, page: ()=>EmailVerificationScreen()),
    GetPage(name: saleHistory, page: () => SaleHistoryScreen()),
    GetPage(name: addProduct, page: () => AddProductScreen()),
    GetPage(name: changename, page: () => Name()),
    GetPage(name: responsive, page: () => Responsive()),
    GetPage(name: dashboard, page: () => Splashscreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signup, page: () => Signupscreen()),
    GetPage(name: homescreen, page: () => HomescreenWidget()),
    GetPage(name: mainpage, page: () => MainPage()),
  ];
}
