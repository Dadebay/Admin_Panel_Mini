import 'package:admin_panel/app/constants/firebase_part/show_detail_dialog.dart';
import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

class TableList extends StatelessWidget {
  final String name;
  final String date;
  final String supplier;
  final String imageURL;
  final String buyMoney;
  final String kgSan;
  final String category;
  final bool sanKGBOOL;

  const TableList(
      {super.key,
      required this.name,
      required this.date,
      required this.supplier,
      required this.imageURL,
      required this.buyMoney,
      required this.kgSan,
      required this.sanKGBOOL,
      required this.category});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return ShowDetailDialog(
              imageURL: imageURL,
              harytADY: name,
              buyPrice: buyMoney,
              category: category,
              date: date,
              sanKG: kgSan,
              sanKGBOOL: sanKGBOOL,
              supplier: supplier,
            );
          },
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
        margin: EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: Colors.white, width: 1),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Text(
                name,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white, fontFamily: gilroyMedium),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                date,
                style: TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 16),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                supplier,
                style: TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 16),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                buyMoney + ' TMT',
                style: TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 16),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                sanKGBOOL ? kgSan + ' kg' : kgSan + ' san',
                style: TextStyle(color: Colors.white, fontFamily: gilroyRegular, fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }
}
