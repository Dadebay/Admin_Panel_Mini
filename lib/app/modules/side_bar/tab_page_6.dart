import 'package:admin_panel/app/constants/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../home/views/components/table_list.dart';

class TabBarPage6 extends StatefulWidget {
  @override
  State<TabBarPage6> createState() => _TabBarPage6State();
}

class _TabBarPage6State extends State<TabBarPage6> {
  int products = 0;
  int sumProduct = 0;

  var excel = Excel.createExcel();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(defaultPadding * 2),
      padding: EdgeInsets.all(defaultPadding * 1),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1,
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').where('soldCount', isGreaterThan: 0).snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            if (streamSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (streamSnapshot.hasError) {
              return noData();
            } else if (streamSnapshot.data!.docs.isEmpty) {
              return emptyData();
            }
            products = 0;
            sumProduct = 0;
            products = streamSnapshot.data!.docs.length;
            streamSnapshot.data!.docs.forEach((element) {
              int sany = int.parse(element['soldCount'].toString());
              sumProduct += int.parse(element['soldPrice'].toString()) * sany;
            });
            return Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "products4".tr,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: gilroySemiBold, fontSize: 22),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 20, left: 15),
                        child: Row(
                          children: [
                            miniText("table1"),
                            miniText("table2"),
                            miniText("table5"),
                            miniText("soldMoney"),
                            miniText("sellCounted"),
                          ],
                        ),
                      ),
                      Expanded(
                        child: streamSnapshot.data!.docs.length == 0
                            ? Center(
                                child: Text(
                                  "nodata".tr,
                                  style: TextStyle(color: Colors.white, fontSize: 22),
                                ),
                              )
                            : ListView.builder(
                                itemCount: streamSnapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return TableList(
                                    category: streamSnapshot.data!.docs[index]['gornusi'],
                                    sanKGBOOL: streamSnapshot.data!.docs[index]['san_kg'],
                                    imageURL: streamSnapshot.data!.docs[index]['surat'].toString(),
                                    date: streamSnapshot.data!.docs[index]['gelen_senesi'].toString(),
                                    name: streamSnapshot.data!.docs[index]['haryt_ady'].toString(),
                                    buyMoney: streamSnapshot.data!.docs[index]['soldPrice'].toString(),
                                    kgSan: streamSnapshot.data!.docs[index]['soldCount'].toString(),
                                    supplier: streamSnapshot.data!.docs[index]['getiren'].toString(),
                                  );
                                },
                              ),
                      )
                    ],
                  ),
                ),
                divider(),
                bottomPart(
                    buyMoneySum: sumProduct,
                    soldPage: true,
                    context: context,
                    onTap: () {
                      exportExcel(streamSnapshot);
                    },
                    sumProducts: products)
              ],
            );
          }),
    );
  }

  dynamic exportExcel(AsyncSnapshot<QuerySnapshot<Object?>> streamSnapshot) {
    Sheet sheetObject = excel["products4".tr];
    var cell1 = sheetObject.cell(CellIndex.indexByString("A1"));
    cell1.value = 'table1'.tr; //ady
    var cell2 = sheetObject.cell(CellIndex.indexByString("B1"));
    cell2.value = 'table2'.tr; //sene
    var cell3Buy = sheetObject.cell(CellIndex.indexByString("C1"));
    cell3Buy.value = 'table5'.tr; //getiren
    var cell3Count = sheetObject.cell(CellIndex.indexByString("D1"));
    cell3Count.value = 'soldMoney'.tr; //baha
    var cell3Sell = sheetObject.cell(CellIndex.indexByString("E1"));
    cell3Sell.value = 'sellCounted'.tr; //gowrumi
    var cell4 = sheetObject.cell(CellIndex.indexByString("F1"));
    cell4.value = 'category'.tr;
    for (int i = 0; i < streamSnapshot.data!.docs.length; i++) {
      var cell1 = sheetObject.cell(CellIndex.indexByString('A${i + 2}'));
      var cell2 = sheetObject.cell(CellIndex.indexByString('B${i + 2}'));
      var cell3Buy = sheetObject.cell(CellIndex.indexByString('C${i + 2}'));
      var cell3Count = sheetObject.cell(CellIndex.indexByString('D${i + 2}'));
      var cell3Sell = sheetObject.cell(CellIndex.indexByString('E${i + 2}'));
      var cell4 = sheetObject.cell(CellIndex.indexByString('F${i + 2}'));
      cell1.value = streamSnapshot.data!.docs[i]['haryt_ady'];
      cell2.value = streamSnapshot.data!.docs[i]['gelen_senesi'];
      cell3Buy.value = "${streamSnapshot.data!.docs[i]['getiren']}";
      cell3Count.value = streamSnapshot.data!.docs[i]['soldPrice'] + " TMT";
      cell3Sell.value = streamSnapshot.data!.docs[i]['san_kg'] == true ? streamSnapshot.data!.docs[i]['soldCount'].toString() + ' kg' : streamSnapshot.data!.docs[i]['soldCount'].toString() + ' san';
      cell4.value = "Satylanlar";
    }
    var fileBytes = excel.save(fileName: "Satylanlar.xlsx");
  }
}
