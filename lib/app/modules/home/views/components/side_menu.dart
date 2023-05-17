import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../controllers/home_controller.dart';

class SideMenu extends StatelessWidget {
  final bool whichPage;

  SideMenu({super.key, required this.whichPage});
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Center(
              child: Text(
                "Diş bejeriş enjamlary dükanynyň maglumatlar gorunyň işini awtomatlaşdyrmak",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontFamily: gilroySemiBold, color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          whichPage
              ? DrawerListTile(
                  title: "homePage".tr,
                  svgSrc: "assets/icons/menu_dashbord.svg",
                  press: () {
                    controller.selectedIndex.value = 0;
                  },
                )
              : SizedBox.shrink(),
          DrawerListTile(
            title: "products".tr,
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              controller.selectedIndex.value = whichPage ? 1 : 0;
            },
          ),
          DrawerListTile(
            title: "products1".tr,
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              controller.selectedIndex.value = whichPage ? 2 : 1;
            },
          ),
          DrawerListTile(
            title: "products2".tr,
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              controller.selectedIndex.value = whichPage ? 3 : 2;
            },
          ),
          DrawerListTile(
            title: "products3".tr,
            svgSrc: "assets/icons/menu_dashbord.svg",
            press: () {
              controller.selectedIndex.value = whichPage ? 4 : 3;
            },
          ),
          DrawerListTile(
            title: "products4".tr,
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              controller.selectedIndex.value = whichPage ? 5 : 4;
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white,
        height: 16,
        width: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white, fontFamily: gilroyMedium),
      ),
    );
  }
}
