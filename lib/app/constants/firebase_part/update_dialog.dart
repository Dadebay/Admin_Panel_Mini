import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants.dart';
import '../widgets.dart';

class UpdateDialog extends StatefulWidget {
  const UpdateDialog(
      {super.key, required this.kgSanValue, required this.date, required this.productName, required this.supplierName, required this.buyPriceName, required this.kgSanName, required this.imageURL});
  final bool kgSanValue;
  final String date;
  final String productName;
  final String supplierName;
  final String buyPriceName;
  final String kgSanName;
  final String imageURL;

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _buyPriceController = TextEditingController();
  final TextEditingController _kgSanController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _dateController.text = widget.date;
    _productNameController.text = widget.productName;
    _supplierNameController.text = widget.supplierName;
    _buyPriceController.text = widget.buyPriceName;
    _kgSanController.text = widget.kgSanName;
    uploadedImageUrl = widget.imageURL;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(color: secondaryColor, borderRadius: borderRadius15),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 15),
                child: Text(
                  "add_data".tr,
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: gilroySemiBold, color: Colors.white, fontSize: 22),
                ),
              ),
              textFieldMine(_productNameController, "work_name", false, true, () {}, false),
              selectDatePicker(),
              textFieldMine(_supplierNameController, "table5", false, true, () {}, false),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: textFieldMine(_buyPriceController, "buyMoney", true, true, () {}, false),
              ),
              textFieldMine(_kgSanController, widget.kgSanValue ? "buyKG" : "buySAN", false, true, () {}, true),
              dropDownButtonField(),
              selectImage(),
              bottomButtons()
            ],
          ),
        ),
      ),
    );
  }

  //drop down button field///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String _salutation = "products";
  final _salutations = [
    'products',
    'products1',
    'products2',
    'products3',
  ];
  Container dropDownButtonField() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      margin: EdgeInsets.symmetric(vertical: defaultPadding),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: borderRadius5,
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          borderRadius: borderRadius15,
          items: _salutations
              .map((String item) => DropdownMenuItem<String>(
                  child: Text(
                    item.tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  value: item))
              .toList(),
          onChanged: (String? value) {
            setState(() {
              _salutation = value!;
            });
          },
          value: _salutation,
        ),
      ),
    );
  }

  ///Date field///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  DateTime _date = DateTime.now();

  selectDatePicker() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding),
      child: TextFormField(
        controller: _dateController,
        onTap: () async {
          DateTime? _datePicker = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.utc(2100, DateTime.now().month, DateTime.now().day),
          );

          if (_datePicker != null && _datePicker != _date) {
            final date = DateTime.parse(_datePicker.toString());
            final String formattedDate = DateFormat('dd - MM - yyyy').format(date);
            _dateController.text = formattedDate;
            setState(() {});
          } else {
            showSnackBar("Ýalňyşlyk ýüze çykdy", "Sene saylamadyňyz", Colors.red);
          }
        },
        style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 18),
        decoration: InputDecoration(
            border: OutlineInputBorder(borderSide: BorderSide(color: primaryColor)),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: primaryColor, width: 2)),
            disabledBorder: OutlineInputBorder(borderSide: BorderSide(color: secondaryColor)),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
            hintText: 'work_come_date'.tr,
            hintStyle: TextStyle(color: Colors.grey, fontSize: 20)),
      ),
    );
  }

  // Image field///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Uint8List? file;
  String uploadedImageUrl = '';

  Widget selectImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, top: 15),
          child: Text(
            'selectImage'.tr,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontFamily: gilroyMedium, color: Colors.white, fontSize: 20),
          ),
        ),
        GestureDetector(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              file = result.files.first.bytes;
              String? fileName = result.files.first.name;
              UploadTask task = FirebaseStorage.instance.ref().child('files/$fileName').putData(file!, SettableMetadata(contentType: 'image/png'));
              task.snapshotEvents.listen((event) {
                event.ref.getDownloadURL().then((value) {
                  if (uploadedImageUrl == '') {
                    showSnackBar("agree2", "agree4", Colors.green);
                  }
                  uploadedImageUrl = value;
                  setState(() {});
                });
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
            child: file == null
                ? uploadedImageUrl != ''
                    ? CachedNetworkImage(
                        imageUrl: uploadedImageUrl,
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : Container(
                        width: 150,
                        height: 150,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(borderRadius: borderRadius15, border: Border.all(color: Colors.white, width: 2)),
                        child: Center(
                          child: Text(
                            "selectImage".tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontFamily: gilroyMedium, fontSize: 18),
                          ),
                        ),
                      )
                : ClipRRect(
                    borderRadius: borderRadius15,
                    child: Image.memory(
                      file!,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Padding bottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(15),
                backgroundColor: primaryColor,
              ),
              onPressed: () async {
                if (uploadedImageUrl == '') {
                  showSnackBar('wait', "wait", Colors.red);
                } else {
                  final post = await FirebaseFirestore.instance.collection('products').where('haryt_ady', isEqualTo: widget.productName).get().then((QuerySnapshot snapshot) {
                    return snapshot.docs[0].id;
                  });
                  var collection = FirebaseFirestore.instance.collection('products');
                  collection.doc(post).update({
                    'haryt_ady': _productNameController.text,
                    'gelen_senesi': _dateController.text,
                    'getiren': _supplierNameController.text,
                    'surat': uploadedImageUrl,
                    'bahasy': _buyPriceController.text,
                    'san_kg': widget.kgSanValue,
                    'kg': widget.kgSanValue ? _kgSanController.text : '',
                    'san': widget.kgSanValue ? '' : _kgSanController.text,
                    "gornusi": _salutation,
                    'soldCount': '0',
                    'soldPrice': '0'
                  });

                  Get.back();
                  showSnackBar("agree2", "agree3", Colors.green);
                }
              },
              icon: Icon(
                Icons.edit,
                size: 24,
              ),
              label: Text(
                "edit".tr,
                style: TextStyle(fontSize: 21),
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.all(15),
            ),
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              CupertinoIcons.xmark,
              size: 24,
            ),
            label: Text(
              "close".tr,
              style: TextStyle(fontSize: 21),
            ),
          ),
        ],
      ),
    );
  }
}
