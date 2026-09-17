import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_pos_system/config/routes/app_route.dart';
import 'package:mini_pos_system/controller/home_controller.dart';
import 'package:mini_pos_system/screen/widget/lowstockwidget.dart';
import 'package:mini_pos_system/screen/widget/nameshop_widget.dart';
import 'package:mini_pos_system/screen/widget/recentsale_widget.dart';
import 'package:mini_pos_system/screen/widget/todaysale_widget.dart';

class HomescreenWidget extends StatelessWidget {
  var controller = Get.put(HomeController());
  
  HomescreenWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text("Home Screen"),
        bottom:PreferredSize(preferredSize:Size.fromHeight(70), child: InkWell(
            child: NameshopWidget(),
            onTap: () => Get.toNamed(AppRoute.changename),
          ),
      ),
      ),
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh:controller.getTodaySales,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: [
          
          TodaysaleWidget(),
          InkWell(child: RecentsaleWidget(),onTap: ()=>Get.toNamed(AppRoute.saleHistory),),
          InkWell(child: LowStockWidget(),onTap: ()=>Get.toNamed(AppRoute.productScreen),)
        ],
      ),
    );
  }
}
