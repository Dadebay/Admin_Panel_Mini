import 'package:admin_panel/app/modules/home/views/components/main_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/constants/constants.dart';
import 'app/utils/translations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB9YYrO0CfuXIQF5ridoYsAzfpr9nzj2gw",
          authDomain: "admin-panel-e4013.firebaseapp.com",
          databaseURL: "https://admin-panel-e4013-default-rtdb.firebaseio.com",
          projectId: "admin-panel-e4013",
          storageBucket: "admin-panel-e4013.appspot.com",
          messagingSenderId: "590644022203",
          appId: "1:590644022203:web:ae9a921a57109b9e6d129e",
          measurementId: "G-07BQ2J4DQE"));
  // await Firebase.initializeApp(
  //   options: kIsWeb || Platform.isAndroid
  //       ? FirebaseOptions(
  //           apiKey: "AIzaSyB9YYrO0CfuXIQF5ridoYsAzfpr9nzj2gw",
  //           authDomain: "admin-panel-e4013.firebaseapp.com",
  //           databaseURL: "https://admin-panel-e4013-default-rtdb.firebaseio.com",
  //           projectId: "admin-panel-e4013",
  //           storageBucket: "admin-panel-e4013.appspot.com",
  //           messagingSenderId: "590644022203",
  //           appId: "1:590644022203:web:ae9a921a57109b9e6d129e",
  //           measurementId: "G-07BQ2J4DQE")
  //       : null,
  // );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          canvasColor: secondaryColor,
          brightness: Brightness.light,
          fontFamily: gilroyRegular,
          colorSchemeSeed: secondaryColor,
          scaffoldBackgroundColor: bgColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        fallbackLocale: const Locale('tr'),
        locale: storage.read('langCode') != null
            ? Locale(storage.read('langCode'))
            : const Locale(
                'tr',
              ),
        translations: MyTranslations(),
        defaultTransition: Transition.fade,
        // home: LoginPage());
        home: MainScreen(
          whichDesign: true,
        ));
  }
}
