import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../consts/textstyle_const.dart';
import '../../../../../widgets/custom_button.dart';
import '../request_allocation_review_detail/request_allocation_review_screen.dart';

class InformationData extends StatelessWidget {
  const InformationData({Key? key, required this.offerShareBid})
      : super(key: key);
  final OfferShareBid offerShareBid;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// company first box
          SizedBox(height: height * 0.02),
          Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// company texts
                Text(
                  'Company',
                  style: poppinsRegular.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlueColor,
                  ),
                ),
                SizedBox(height: height * 0.008),

                /// description texts
                Text(
                  'Dubizzle is an online classifieds platform that allows users to buy and '
                  'sell properties, cars, and other items online. ',
                  style: poppinsRegular.copyWith(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyColor2,
                  ),
                ),
                SizedBox(height: height * 0.008),

                summeryRow('Founded', '2005'),
                summeryRow('Status', 'Private, subsidiary of OLX Group'),
                summeryRow('CEO Rating', '83/100'),
                summeryRow('CEO', 'Haider Ali Khan'),
                summeryRow('Employess', '375'),
                summeryRow('Total Revenues', '\$40-50mn USD'),
                summeryRow('Website', 'www.dubiezzel.com'),
              ],
            ),
          ),

          /// company second box
          SizedBox(height: height * 0.02),
          Container(
            width: width,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: AppColors.whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// company texts
                Text(
                  'Company',
                  style: poppinsRegular.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlueColor,
                  ),
                ),
                SizedBox(height: height * 0.008),

                summeryRow('Primary Sector', 'Retail'),
                summeryRow('Sector Growth', '\$75bn by 2025'),

                /// Risk Factors
                SizedBox(height: height * 0.02),
                Text(
                  'Risk Factors',
                  style: poppinsRegular.copyWith(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.lightBlueColor,
                  ),
                ),

                /// description texts
                SizedBox(height: height * 0.008),
                Text(
                  'We extract risk factos from company filings and other reaserch methods.',
                  style: poppinsRegular.copyWith(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyColor2,
                  ),
                ),

                SizedBox(height: height * 0.008),
                Text(
                  'Impacts the movement of good and',
                  style: poppinsRegular.copyWith(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w400,
                    color: AppColors.greyColor2,
                  ),
                ),
              ],
            ),
          ),

          /// Request Allocation button
          SizedBox(height: height * 0.03),
          CustomButton(
            onTap: () {
              // Get.to(const RegisterCertificateScreen());
              Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  type: PageTransitionType.rightToLeft,
                  child: RequestAllocationReviewScreen(
                      offerShareBid: offerShareBid),
                ),
              );
            },
            btnColor: AppColors.whiteColor.withOpacity(0.1),
            borderColor: AppColors.whiteColor.withOpacity(0.1),
            btnText: 'Request Allocation',
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
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
