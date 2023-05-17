import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../../side_bar/tab_page_2.dart';
import '../../../side_bar/tab_page_3.dart';
import '../../../side_bar/tab_page_4.dart';
import '../../../side_bar/tab_page_5.dart';
import '../../../side_bar/tab_page_6.dart';
import '../../controllers/home_controller.dart';
import '../home_view.dart';
import 'side_menu.dart';

class MainScreen extends StatefulWidget {
  final bool whichDesign;

  const MainScreen({super.key, required this.whichDesign});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List pages = [
    Container(color: bgColor, child: HomeView()),
    TabBarPage2(),
    TabBarPage3(),
    TabBarPage4(),
    TabBarPage5(),
    TabBarPage6(),
  ];
  List pages2 = [
    TabBarPage2(),
    TabBarPage3(),
    TabBarPage4(),
    TabBarPage5(),
    TabBarPage6(),
  ];
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: SideMenu(whichPage: widget.whichDesign),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(
                  whichPage: widget.whichDesign,
                ),
              ),
            Obx(() {
              return Expanded(
                flex: 5,
                child: widget.whichDesign ? pages[controller.selectedIndex.value] : pages2[controller.selectedIndex.value],
              );
            }),
          ],
        ),
      ),
    );
  }
}
