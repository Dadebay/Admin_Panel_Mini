import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/firebase_part/add_data_dialog.dart';
import '../../../../constants/responsive.dart';
import 'file_info_card.dart';

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  CollectionReference products = FirebaseFirestore.instance.collection('products');
  int products1 = 0;
  int products2 = 0;
  int products3 = 0;
  int products4 = 0;
  int sumProduct = 0;
  int sumProduct1 = 0;
  int sumProduct2 = 0;
  int sumProduct3 = 0;

  List _numbers = [];

  List _totalMoney = [];

  cleanDatas(AsyncSnapshot streamSnapshot) {
    products1 = 0;
    products2 = 0;
    products3 = 0;
    products4 = 0;
    sumProduct = 0;
    sumProduct1 = 0;
    sumProduct2 = 0;
    sumProduct3 = 0;
    streamSnapshot.data!.docs.forEach((element) {
      if (element['gornusi'].toString() == 'products') {
        int sany = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());
        products1 += sany;
        sumProduct += int.parse(element['bahasy'].toString()) * sany;
      } else if (element['gornusi'].toString() == 'products1') {
        int sany1 = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());
        products2 += sany1;
        sumProduct1 += int.parse(element['bahasy'].toString()) * sany1;
      } else if (element['gornusi'].toString() == 'products2') {
        int sany2 = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());
        products3 += sany2;
        sumProduct2 += int.parse(element['bahasy'].toString()) * sany2;
      } else if (element['gornusi'].toString() == 'products3') {
        int sany3 = element['san_kg'].toString() == "true" ? int.parse(element['kg'].toString()) : int.parse(element['san'].toString());
        products4 += sany3;
        sumProduct3 += int.parse(element['bahasy'].toString()) * sany3;
      }
    });
    _totalMoney = [];
    _numbers = [];
    _numbers.addAll([products1, products2, products3, products4]);
    _totalMoney.addAll([sumProduct, sumProduct1, sumProduct2, sumProduct3]);
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'info'.tr,
              style: TextStyle(color: Colors.white, fontFamily: gilroyBold, fontWeight: FontWeight.bold, fontSize: 24),
            ),
            AddDataDialog(),
          ],
        ),
        SizedBox(height: defaultPadding),
        StreamBuilder(
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
              cleanDatas(streamSnapshot);

              return Responsive(
                mobile: FileInfoCardGridView(
                  numbers: _numbers,
                  totalMoney: _totalMoney,
                  crossAxisCount: _size.width < 650 ? 2 : 4,
                  childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
                ),
                tablet: FileInfoCardGridView(
                  numbers: _numbers,
                  totalMoney: _totalMoney,
                ),
                desktop: FileInfoCardGridView(
                  numbers: _numbers,
                  totalMoney: _totalMoney,
                  childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
                ),
              );
            }),
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    required this.numbers,
    required this.totalMoney,
  }) : super(key: key);

  final double childAspectRatio;
  final int crossAxisCount;
  final List numbers;
  final List totalMoney;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(
        name: titles[index],
        color: colors[index],
        numOfFiles: numbers[index].toString(),
        percentage: numbers[index],
        svgSrc: iconsCards[index],
        totalStorage: totalMoney[index].toString(),
      ),
    );
  }
}
