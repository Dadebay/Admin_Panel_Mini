import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../modules/home/controllers/home_controller.dart';
import 'constants.dart';

Container divider() {
  return Container(
    color: secondaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: Divider(
      color: primaryColor,
      thickness: 2,
    ),
  );
}

SnackbarController showSnackBar(String title, String subtitle, Color color) {
  return Get.snackbar(
    title,
    subtitle,
    snackStyle: SnackStyle.FLOATING,
    titleText: title == ''
        ? const SizedBox.shrink()
        : Text(
            title.tr,
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
    messageText: Text(
      subtitle.tr,
      style: const TextStyle(fontSize: 16, color: Colors.white),
    ),
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: color,
    borderRadius: 20.0,
    animationDuration: const Duration(milliseconds: 800),
    margin: const EdgeInsets.all(8),
  );
}

void changeLanguage() {
  final HomeController userProfilController = Get.put(HomeController());

  Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(color: secondaryColor),
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox.shrink(),
                  Text(
                    'select_language'.tr,
                    style: const TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(CupertinoIcons.xmark_circle, size: 22, color: Colors.black),
                  )
                ],
              ),
            ),
            divider(),
            ListTile(
              onTap: () {
                userProfilController.switchLang('tr');
                Get.back();
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  tmIcon,
                ),
                backgroundColor: Colors.black,
                radius: 20,
              ),
              title: const Text(
                'Türkmen',
                style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: gilroyMedium, fontWeight: FontWeight.bold),
              ),
            ),
            divider(),
            ListTile(
              onTap: () {
                userProfilController.switchLang('ru');
                Get.back();
              },
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  ruIcon,
                ),
                radius: 20,
                backgroundColor: Colors.black,
              ),
              title: const Text(
                'Русский',
                style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: gilroyMedium, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
      isDismissible: false);
}

Padding miniButton(String name, String title) {
  return Padding(
    padding: const EdgeInsets.only(top: 12, left: 8),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: gilroyRegular, color: Colors.white, fontSize: 20),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: gilroyMedium, color: Colors.white, fontSize: 21),
          ),
        ),
      ],
    ),
  );
}

Expanded miniText(String name) {
  return Expanded(
    flex: 1,
    child: Text(
      name.tr,
      style: TextStyle(color: Colors.white70, fontFamily: gilroyMedium, fontSize: 18),
    ),
  );
}

TextFormField textFieldMine(TextEditingController _controller1, String name, bool showTMT, bool disable, Function() onTap, bool onlyNumber) {
  return TextFormField(
    controller: _controller1,
    enabled: disable,
    onTap: onTap,
    validator: (value) {
      if (value!.isEmpty) {
        return 'Bos bolmaly dal'.tr;
      }
      return null;
    },
    style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 18),
    inputFormatters: showTMT
        ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), FilteringTextInputFormatter.digitsOnly]
        : onlyNumber
            ? <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[0-9]')), FilteringTextInputFormatter.digitsOnly]
            : [],
    decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 2)),
        disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
        hintText: name.tr,
        errorStyle: TextStyle(color: Colors.red, fontFamily: gilroyMedium),
        suffixIcon: showTMT
            ? Padding(
                padding: const EdgeInsets.only(
                  right: 20,
                  top: 10,
                ),
                child: Text(
                  "TMT",
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
            : SizedBox.shrink(),
        hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
  );
}

Widget bottomPart({required BuildContext context, required bool soldPage, required int sumProducts, required int buyMoneySum, required Function() onTap}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "sumCount".tr,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontFamily: gilroyRegular),
          ),
          Text(
            "$sumProducts",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontFamily: gilroyMedium),
          ),
        ],
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            soldPage ? "sum2".tr : "sum1".tr,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white, fontFamily: gilroyRegular),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "$buyMoneySum",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, height: 1, fontSize: 20),
              ),
              Text(
                " TMT",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontFamily: gilroyMedium),
              )
            ],
          )
        ],
      ),
      ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: primaryColor, shape: RoundedRectangleBorder(borderRadius: borderRadius5)),
          child: Text(
            'Export Excel',
            style: TextStyle(color: Colors.white, fontFamily: gilroyMedium),
          )),
    ],
  );
}

noData() {
  return Expanded(
    child: Center(
        child: Text(
      "noData1".tr,
      style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
    )),
  );
}

emptyData() {
  return Expanded(
    child: Center(
      child: Text(
        "noData".tr,
        style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
      ),
    ),
  );
}
