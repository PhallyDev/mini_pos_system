import 'package:flutter/material.dart';
import 'package:mini_pos_system/screen/responsive.dart';
import 'package:mini_pos_system/screen/appcolors.dart';

class BottomnavbarWidget extends StatefulWidget {
  // ignore: strict_top_level_inference, prefer_typing_uninitialized_variables
  final currentI;
  final Function(int) onTap;
  const BottomnavbarWidget({super.key, required this.currentI, required this.onTap});
  @override
  State<StatefulWidget> createState() {
    return _BottomnavbarWidgetState();
  }
}

class _BottomnavbarWidgetState extends State<BottomnavbarWidget> {
  List<IconData> logo = [
    Icons.home,
    Icons.production_quantity_limits,
    Icons.sell,
  ];
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Responsive.h(10), // previously 80
      child: Stack(
        children: [
          Container(
            height: Responsive.h(10), // previously 80
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(25)),
            ),
          ),
          Column(
            children: [
              SizedBox(height: Responsive.h(2.5)), // previously 20
              Row(
                children: List.generate(
                  logo.length,
                  (index) => Padding(
                    padding: EdgeInsetsGeometry.only(left: 80),
                    child: InkWell(
                      child: Icon(
                        logo[index],
                        size: 35,
                        color: (index == widget.currentI ? AppColors.surface : AppColors.primaryLight),
                      ),
                      onTap: () => setState(() {
                        widget.onTap(index);
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
