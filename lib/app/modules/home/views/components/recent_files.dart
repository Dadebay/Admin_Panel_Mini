import 'package:admin_panel/app/modules/home/views/components/table_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';
import '../../../../constants/widgets.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  CollectionReference products = FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "lastTransations".tr,
            style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 22),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.4,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      miniText("table1"),
                      miniText("table2"),
                      miniText("table5"),
                      miniText("buyMoney"),
                      miniText("buyCount"),
                    ],
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('products').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (streamSnapshot.hasError) {
                        return noData();
                      } else if (streamSnapshot.data!.docs.isEmpty) {
                        return emptyData();
                      }
                      return Expanded(
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
                                    buyMoney: streamSnapshot.data!.docs[index]['bahasy'].toString(),
                                    kgSan: streamSnapshot.data!.docs[index]['san_kg'] == true ? streamSnapshot.data!.docs[index]['kg'].toString() : streamSnapshot.data!.docs[index]['san'].toString(),
                                    supplier: streamSnapshot.data!.docs[index]['getiren'].toString(),
                                  );
                                },
                              ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
