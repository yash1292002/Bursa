import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../consts/textstyle_const.dart';

class DealTeaserData extends StatelessWidget {
  const DealTeaserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.025),
          Container(
            width: width,
            padding: const EdgeInsets.only(
                top: 15.0, left: 24.0, right: 16.0, bottom: 100),
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Investment Summery',
                  style: poppinsRegular.copyWith(
                    color: AppColors.lightBlueColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ExpandableText(
                  'Target control-oriented growth equity and buyout investments in '
                  'software and technology enabled ibusiness services companies. Target '
                  'control-oriented growth equity and buyout investments in software '
                  'and technology enabled ibusiness services companies.',
                  expandText: 'Read Full Strategy',
                  collapseText: 'Read Less Strategy',
                  maxLines: 3,
                  linkColor: Colors.blue,
                  style: poppinsRegular.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 11.0,
                    color: AppColors.greyColor2,
                  ),
                ),
                summeryRow('Structure',
                    'Close ended feeder fund incorporated in ADGM'),
                summeryRow('Strategy', 'Growth Equity'),
                summeryRow('Asset Class', 'Private Equity'),
                summeryRow(
                    'Investment Minimums & Timing',
                    'Quarterly investment window '
                        'Initial investment: \$100,000 Follow-on investment: \$10,000'),
                summeryRow(
                    'Fee Structure',
                    'Annual Management Fee(1): 1.25% of Fund assets '
                        'and unfunded commitments, net of cash, paid quarterly '
                        'subject to a 1.75% cap Management fee charged only on invested '
                        'capital for the Fund’s first year Pass-through of Fund expenses, '
                        'subject to a 0.7% cap as a percentage of Fund'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget summeryRow(mainText, descText) => Padding(
        padding: const EdgeInsets.only(top: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                mainText,
                style: poppinsRegular.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlueColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                ':',
                style: poppinsRegular.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.lightBlueColor,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                descText,
                style: poppinsRegular.copyWith(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyColor2,
                ),
              ),
            ),
          ],
        ),
      );
}
