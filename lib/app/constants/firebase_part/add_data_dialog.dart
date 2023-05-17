import 'dart:typed_data';

import 'package:admin_panel/app/constants/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants.dart';

class AddDataDialog extends StatefulWidget {
  @override
  State<AddDataDialog> createState() => _AddDataDialogState();
}

class _AddDataDialogState extends State<AddDataDialog> {
  final _signUp = GlobalKey<FormState>();
  bool kgSanValue = false;
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _supplierNameController = TextEditingController();
  final TextEditingController _buyPriceController = TextEditingController();
  final TextEditingController _kgSanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _kgSanController.clear();
        _buyPriceController.clear();
        _supplierNameController.clear();
        _productNameController.clear();
        _dateController.clear();
        uploadedImageUrl = '';
        getKGorSANdialog(context).then((value) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(builder: (context, setState) {
                return Center(
                  child: Material(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(color: secondaryColor, borderRadius: borderRadius15),
                      child: textFieldsAddingData(setState, context),
                    ),
                  ),
                );
              });
            },
          );
        });
      },
      child: Text(
        "add".tr,
        style: TextStyle(fontWeight: FontWeight.bold, fontFamily: gilroySemiBold, color: Colors.white, fontSize: 22),
      ),
    );
  }

  Form textFieldsAddingData(StateSetter setState, BuildContext context) {
    return Form(
      key: _signUp,
      child: SingleChildScrollView(
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
            textFieldMine(_kgSanController, kgSanValue ? "buyKG" : "buySAN", false, true, () {}, true),
            dropDownButtonField(setState),
            selectImage(setState),
            bottomAgreeButtons(context)
          ],
        ),
      ),
    );
  }

// KG san getiryan dialog//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<dynamic> getKGorSANdialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: Material(
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(color: secondaryColor, borderRadius: borderRadius15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "productType".tr,
                    style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: ElevatedButton(
                        onPressed: () {
                          kgSanValue = true;
                          Get.back();
                        },
                        child: Text(
                          "KG",
                          style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 20),
                        )),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        kgSanValue = false;
                        Get.back();
                      },
                      child: Text(
                        "San",
                        style: TextStyle(color: Colors.white, fontFamily: gilroySemiBold, fontSize: 20),
                      )),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

//bottom buttons///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  Padding bottomAgreeButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(15),
              backgroundColor: Colors.green,
            ),
            onPressed: () async {
              if (_signUp.currentState!.validate()) {
                if (uploadedImageUrl == '') {
                  showSnackBar("Error", 'waitImage', Colors.red);
                } else {
                  await FirebaseFirestore.instance.collection('products').add({
                    'haryt_ady': _productNameController.text,
                    'gelen_senesi': _dateController.text,
                    'getiren': _supplierNameController.text,
                    'surat': uploadedImageUrl,
                    'bahasy': _buyPriceController.text,
                    'san_kg': kgSanValue,
                    'kg': kgSanValue ? _kgSanController.text : '',
                    'san': kgSanValue ? '' : _kgSanController.text,
                    "gornusi": _salutation,
                    'soldCount': '0',
                    'soldPrice': '0'
                  }).then((value) {
                    Get.back();
                    showSnackBar("agree2", "agree3", Colors.green);
                  });
                }
              } else {
                showSnackBar("errorTitle", 'errorSubTitle', Colors.red);
              }
            },
            icon: Icon(
              Icons.add,
              size: 24,
            ),
            label: Text(
              "add".tr,
              style: TextStyle(fontSize: 21),
            ),
          ),
          SizedBox(
            width: 25,
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: EdgeInsets.all(15),
            ),
            onPressed: () {
              Navigator.of(context).pop();
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

  //drop down button field///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  String _salutation = "products";
  final _salutations = [
    'products',
    'products1',
    'products2',
    'products3',
  ];
  Container dropDownButtonField(StateSetter setState) {
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
              this._salutation = value!;
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
  Widget selectImage(StateSetter setState) {
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
              setState((() {}));
              file = result.files.first.bytes;
              String? fileName = result.files.first.name;
              UploadTask task = FirebaseStorage.instance.ref().child('files/$fileName').putData(file!, SettableMetadata(contentType: 'image/png'));
              task.snapshotEvents.listen((event) {
                setState((() {
                  event.ref.getDownloadURL().then((value) {
                    uploadedImageUrl = value;
                  });
                }));
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
            child: file == null
                ? Container(
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
}
