import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final storage = GetStorage();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RxBool miniAdmin = false.obs;
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;

  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }

  var tm = const Locale(
    'tr',
  );
  var ru = const Locale(
    'ru',
  );
  var en = const Locale(
    'en',
  );

  dynamic switchLang(String value) {
    if (value == 'en') {
      Get.updateLocale(en);
      storage.write('langCode', 'en');
    } else if (value == 'ru') {
      Get.updateLocale(ru);
      storage.write('langCode', 'ru');
    } else {
      Get.updateLocale(tm);
      storage.write('langCode', 'tr');
    }
    update();
  }
}
