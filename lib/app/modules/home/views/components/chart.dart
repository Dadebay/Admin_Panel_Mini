import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/constants.dart';

class Chart extends StatefulWidget {
  final int products;
  final int products1;
  final int products2;
  final int products3;
  final int sum;
  const Chart({
    Key? key,
    required this.products,
    required this.products1,
    required this.products2,
    required this.products3,
    required this.sum,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

double sumMoney = 1000.0;

class _ChartState extends State<Chart> {
  @override
  void initState() {
    super.initState();
    sumMoney -= (double.parse(widget.products.toString()) + double.parse(widget.products1.toString()) + double.parse(widget.products2.toString()) + double.parse(widget.products3.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 110,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: primaryColor,
                  value: double.parse(widget.products.toString()),
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: Color(0xFFFFCF26),
                  value: double.parse(widget.products1.toString()),
                  showTitle: false,
                  radius: 22,
                ),
                PieChartSectionData(
                  color: Color(0xFF26E5FF),
                  value: double.parse(widget.products2.toString()),
                  showTitle: false,
                  radius: 19,
                ),
                PieChartSectionData(
                  color: Color(0xFFEE2727),
                  value: double.parse(widget.products3.toString()),
                  showTitle: false,
                  radius: 16,
                ),
                PieChartSectionData(
                  color: primaryColor.withOpacity(0.1),
                  value: sumMoney,
                  showTitle: false,
                  radius: 13,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: defaultPadding),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${widget.sum}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 1,
                          ),
                    ),
                    Text(
                      " TMT",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, height: 2, fontFamily: gilroyMedium),
                    )
                  ],
                ),
                Text(
                  "storageDetail1".tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontFamily: gilroyRegular),
                )
              ],
            ),
          ),
        ],
      ),
    );
    ;
  }
}
