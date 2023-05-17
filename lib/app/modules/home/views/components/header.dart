import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/responsive.dart';
import '../../../../constants/widgets.dart';
import '../../controllers/home_controller.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: Get.find<HomeController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          Text(
            "panel".tr,
            style: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontWeight: FontWeight.bold, fontSize: 24),
          ),
        if (!Responsive.isMobile(context)) Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        Expanded(
            child: ListTile(
          onTap: () {
            changeLanguage();
          },
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Get.locale!.toLanguageTag() == 'tr' ? 'Türkmen dili' : 'Rus dili',
                style: TextStyle(fontSize: 22, color: Colors.white, fontFamily: gilroyMedium),
              ),
              Container(
                width: 35,
                height: 35,
                margin: const EdgeInsets.only(left: 25),
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                child: ClipRRect(
                  borderRadius: borderRadius30,
                  child: Image.asset(
                    Get.locale!.toLanguageTag() == 'tr' ? tmIcon : ruIcon,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: Get.locale!.toLanguageTag() == 'tr' ? 'Türkmen dili' : 'Rus dili',
        fillColor: secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(defaultPadding * 0.75),
            margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
