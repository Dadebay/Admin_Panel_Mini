import 'package:admin_panel/app/constants/firebase_part/update_dialog.dart';
import 'package:admin_panel/app/constants/widgets.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modules/home/controllers/home_controller.dart';
import '../constants.dart';

class ShowDetailDialog extends StatefulWidget {
  const ShowDetailDialog(
      {super.key,
      required this.imageURL,
      required this.harytADY,
      required this.date,
      required this.supplier,
      required this.category,
      required this.buyPrice,
      required this.sanKG,
      required this.sanKGBOOL});

  final String buyPrice;
  final String category;
  final String date;
  final String harytADY;
  final String imageURL;
  final String sanKG;
  final bool sanKGBOOL;
  final String supplier;

  @override
  State<ShowDetailDialog> createState() => _ShowDetailDialogState();
}

class _ShowDetailDialogState extends State<ShowDetailDialog> {
  bool loader = false;
  final HomeController controller = Get.put(HomeController());

  Padding bottomButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 80, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
            onPressed: () {
              Get.back();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return UpdateDialog(
                    buyPriceName: widget.buyPrice,
                    imageURL: widget.imageURL,
                    date: widget.date,
                    kgSanName: widget.sanKG,
                    kgSanValue: widget.sanKGBOOL,
                    productName: widget.harytADY,
                    supplierName: widget.supplier,
                  );
                },
              );
            },
            icon: Icon(
              Icons.edit,
              size: 20,
            ),
            label: Text(
              "edit".tr,
              style: TextStyle(fontSize: 20, fontFamily: gilroyMedium),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              setState(() {
                loader = true;
              });

              final post = await FirebaseFirestore.instance.collection('products').where('haryt_ady', isEqualTo: widget.harytADY).get().then((QuerySnapshot snapshot) {
                return snapshot.docs[0].id;
              });
              var collection = FirebaseFirestore.instance.collection('products');
              collection.doc(post).delete();
              Get.back();

              showSnackBar("deleted1", "deleted2", Colors.red);
              setState(() {
                loader = false;
              });
            },
            icon: Icon(
              Icons.delete,
              size: 20,
            ),
            label: Text(
              "delete".tr,
              style: TextStyle(fontSize: 20, fontFamily: gilroyMedium),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
            ),
            onPressed: () async {
              final TextEditingController satlykSanyController = TextEditingController();
              final TextEditingController satlykBahasyController = TextEditingController();
              satlykDialog(satlykSanyController, satlykBahasyController);
            },
            icon: Icon(
              Icons.login,
              size: 24,
            ),
            label: Text(
              "sold".tr,
              style: TextStyle(fontSize: 20, fontFamily: gilroyMedium),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> satlykDialog(TextEditingController satlykSanyController, TextEditingController satlykBahasyController) {
    return Get.defaultDialog(
        title: 'soldCountEnter'.tr,
        titleStyle: TextStyle(color: Colors.white),
        backgroundColor: secondaryColor,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium),
              cursorColor: Colors.white,
              controller: satlykSanyController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: widget.sanKGBOOL ? 'soldKGEnter'.tr : "soldCountEnter".tr,
                hintStyle: TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 10),
                border: OutlineInputBorder(
                  borderRadius: borderRadius20,
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius20,
                  borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: borderRadius20,
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: borderRadius20,
                  borderSide: BorderSide(color: primaryColor, width: 2),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: borderRadius20,
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: TextFormField(
                style: const TextStyle(color: Colors.white, fontFamily: gilroyMedium),
                cursorColor: Colors.white,
                controller: satlykBahasyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'soldMoneyEnter'.tr,
                  hintStyle: TextStyle(color: Colors.white),
                  contentPadding: const EdgeInsets.only(left: 25, top: 20, bottom: 20, right: 10),
                  border: OutlineInputBorder(
                    borderRadius: borderRadius20,
                    borderSide: const BorderSide(color: Colors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: borderRadius20,
                    borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: borderRadius20,
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: borderRadius20,
                    borderSide: BorderSide(color: primaryColor, width: 2),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: borderRadius20,
                    borderSide: const BorderSide(color: Colors.red, width: 2),
                  ),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  final post = await FirebaseFirestore.instance.collection('products').where('haryt_ady', isEqualTo: widget.harytADY).get().then((QuerySnapshot snapshot) {
                    return snapshot.docs[0].id;
                  });
                  if (int.parse(widget.buyPrice.toString()) >= int.parse(satlykBahasyController.text)) {
                    showSnackBar('Error', 'soldMustBe', Colors.red);
                  } else if (int.parse(widget.sanKG.toString()) == int.parse(satlykSanyController.text)) {
                    var collection = FirebaseFirestore.instance.collection('products');
                    collection.doc(post).update({
                      'soldCount': int.parse(satlykSanyController.text),
                      'san': 0,
                      'kg': 0,
                    });
                    Get.back();
                    Get.back();
                    showSnackBar('sold', 'soldSubtitle', Colors.green);
                  } else {
                    var collection = FirebaseFirestore.instance.collection('products');
                    int value = 0;
                    int onkiBahasy = 0;
                    await FirebaseFirestore.instance.collection('products').where('haryt_ady', isEqualTo: widget.harytADY).get().then((QuerySnapshot snapshot) {
                      value = int.parse(snapshot.docs[0]['soldCount'].toString());
                      onkiBahasy = widget.sanKGBOOL ? int.parse(snapshot.docs[0]['kg'].toString()) : int.parse(snapshot.docs[0]['san'].toString());
                    });
                    value += int.parse(satlykSanyController.text);
                    collection.doc(post).update({
                      'soldCount': value,
                      'soldPrice': satlykBahasyController.text,
                      'san': widget.sanKGBOOL ? '' : onkiBahasy - int.parse(satlykSanyController.text),
                      'kg': widget.sanKGBOOL ? onkiBahasy - int.parse(satlykSanyController.text) : '',
                    });
                    Get.back();
                    Get.back();
                    showSnackBar('sold', 'soldSubtitle', Colors.green);
                  }
                },
                child: Text('agree'.tr))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(color: secondaryColor, borderRadius: borderRadius15),
        child: Stack(
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 15),
                  child: Text(
                    "table4".tr,
                    style: TextStyle(fontFamily: gilroySemiBold, color: Colors.white, fontSize: 24),
                  ),
                ),
                miniButton('table1'.tr, widget.harytADY),
                miniButton('work_come_date'.tr, widget.date),
                miniButton('buyMoney'.tr, widget.buyPrice + " TMT"),
                widget.sanKGBOOL ? miniButton('kg gorkez'.tr, widget.sanKG + ' kg') : miniButton('sellCounted'.tr, widget.sanKG + ' san'),
                miniButton('work_employer'.tr, widget.supplier),
                miniButton('category'.tr, widget.category.tr),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8, top: 15),
                      child: Text(
                        'photo'.tr,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontFamily: gilroyRegular, color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, top: 15),
                      child: ClipRRect(
                        borderRadius: borderRadius15,
                        child: CachedNetworkImage(
                          imageUrl: widget.imageURL,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                    ),
                  ],
                ),
                bottomButtons()
              ],
            ),
            loader
                ? Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                      ),
                      child: Center(
                        child: Wrap(
                          children: [CircularProgressIndicator(), Text("Harytlar pozulup dur garas")],
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
