import 'package:admin_panel/app/modules/home/views/components/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/constants.dart';
import '../../../constants/custom_text_field.dart';
import '../../../constants/widgets.dart';
import '../controllers/home_controller.dart';

class LoginPage extends StatelessWidget {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode focusNode = FocusNode();
  FocusNode focusNode1 = FocusNode();
  final login = GlobalKey<FormState>();
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Form(
              key: login,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Diş bejeriş enjamlary dükanynyň maglumatlar gorunyň işini awtomatlaşdyrmak',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 24),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          CustomTextField(labelName: 'userName'.tr, controller: userNameController, focusNode: focusNode, requestfocusNode: focusNode1, isNumber: false),
                          SizedBox(
                            height: 10,
                          ),
                          CustomTextField(labelName: 'userPassword'.tr, controller: passwordController, focusNode: focusNode1, requestfocusNode: focusNode, isNumber: false),
                          SizedBox(
                            height: 25,
                          ),
                          SizedBox(
                            width: Get.size.width,
                            child: ElevatedButton(
                                onPressed: () {
                                  if (login.currentState!.validate()) {
                                    if (userNameController.text == 'admin' && passwordController.text == 'admin') {
                                      Get.to(() => MainScreen(
                                            whichDesign: true,
                                          ));
                                    } else {
                                      userNameController.clear();
                                      passwordController.clear();
                                      showSnackBar('errorTitle', "loginError", Colors.red);
                                    }
                                  } else {
                                    showSnackBar('errorTitle ', 'errorEmpty', Colors.red);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(18),
                                ),
                                child: Text(
                                  "login".tr,
                                  style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 18),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Image.asset(
                    'assets/images/logo1.png',
                    fit: BoxFit.cover,
                  ))
                ],
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                Get.to(() => MainScreen(
                      whichDesign: false,
                    ));
              },
              child: Text(
                'operator'.tr,
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
