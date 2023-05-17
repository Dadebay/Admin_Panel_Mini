import 'package:admin_panel/app/modules/home/views/components/storage_info_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../controllers/home_controller.dart';
import 'chart.dart';

class StarageDetails extends StatelessWidget {
  StarageDetails({
    Key? key,
  }) : super(key: key);
  final HomeController controller = Get.put(HomeController());
  int products = 0;
  int products1 = 0;
  int products2 = 0;
  int products3 = 0;
  int sumProduct = 0;
  int sumProduct1 = 0;
  int sumProduct2 = 0;
  int sumProduct3 = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (streamSnapshot.hasError) {
            return Center(
                child: Text(
              "noData1".tr,
              style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
            ));
          } else if (streamSnapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "noData".tr,
                style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 22),
              ),
            );
          }
          products = 0;
          products1 = 0;
          products2 = 0;
          products3 = 0;
          sumProduct = 0;
          sumProduct1 = 0;
          sumProduct2 = 0;
          sumProduct3 = 0;
          streamSnapshot.data!.docs.forEach((element) {
            if (element['gornusi'].toString() == 'products') {
              int sany = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());
              products += sany;
              sumProduct += int.parse(element['bahasy'].toString()) * sany;
            } else if (element['gornusi'].toString() == 'products1') {
              int sany1 = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());

              products1 += sany1;
              sumProduct1 += int.parse(element['bahasy'].toString()) * sany1;
            } else if (element['gornusi'].toString() == 'products2') {
              int sany2 = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());

              products2 += sany2;
              sumProduct2 += int.parse(element['bahasy'].toString()) * sany2;
            } else if (element['gornusi'].toString() == 'products3') {
              int sany3 = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());

              products3 += sany3;

              sumProduct3 += int.parse(element['bahasy'].toString()) * sany3;
            }
          });
          return Container(
              padding: EdgeInsets.all(defaultPadding),
              decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "storageDetail".tr,
                    style: TextStyle(fontSize: 18, fontFamily: gilroyMedium, color: Colors.white),
                  ),
                  SizedBox(height: defaultPadding),
                  Chart(
                    products: products,
                    products1: products1,
                    products2: products2,
                    products3: products3,
                    sum: sumProduct + sumProduct1 + sumProduct2 + sumProduct3,
                  ),
                  StorageInfoCard(
                    svgSrc: "assets/icons/Documents.svg",
                    title: "products".tr,
                    color: primaryColor,
                    amountOfFiles: "$sumProduct TMT",
                    numOfFiles: products,
                  ),
                  StorageInfoCard(
                    color: Color(0xFFFFA113),
                    svgSrc: "assets/icons/google_drive.svg",
                    title: "products1".tr,
                    amountOfFiles: "$sumProduct1 TMT",
                    numOfFiles: products1,
                  ),
                  StorageInfoCard(
                    color: Colors.cyan,
                    svgSrc: "assets/icons/drop_box.svg",
                    title: "products2".tr,
                    amountOfFiles: "$sumProduct2 TMT",
                    numOfFiles: products2,
                  ),
                  StorageInfoCard(
                    color: Colors.red,
                    svgSrc: "assets/icons/unknown.svg",
                    title: "products3".tr,
                    amountOfFiles: "$sumProduct3 TMT",
                    numOfFiles: products3,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "sumCount".tr,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text(
                          '${products + products1 + products2 + products3}',
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 4,
                          child: Text(
                            "sumMoney".tr,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${sumProduct + sumProduct1 + sumProduct2 + sumProduct3}',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white, fontSize: 20, fontFamily: gilroySemiBold),
                              ),
                              Text(
                                " TMT",
                                style: TextStyle(color: Colors.white, fontSize: 16, fontFamily: gilroySemiBold),
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ));
        });
  }
}
