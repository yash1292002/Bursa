import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../consts/app_images.dart';
import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import '../../widgets/small_chip_widget.dart';
import '../home_screen/issue_digital_certificate/components/card_texts_widget.dart';
import 'holding_detail.dart';

class MyHoldingScreen extends StatefulWidget {
  const MyHoldingScreen({Key? key}) : super(key: key);

  @override
  State<MyHoldingScreen> createState() => _MyHoldingScreenState();
}

class _MyHoldingScreenState extends State<MyHoldingScreen> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            blueColor,
            greenColor,
          ],
        ),
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              //Get.offAll(const PersisNavBar());
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Image.asset('assets/icons/back_button.png'),
            ),
          ),
          title: Text(
            'My Holdings',
            style: poppinsRegular.copyWith(
              fontSize: 17.0,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
        ),

        /// body
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            /// amazon box
            SizedBox(height: height * 0.03),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    type: PageTransitionType.rightToLeft,
                    child: const HoldingDetailScreen(),
                  ),
                );
              },
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 24.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.white1,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(AppImages.amazonIcon,
                        height: 45.0, width: 45.0, fit: BoxFit.fill),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Amazon Inc',
                                  style: GoogleFonts.poppins().copyWith(
                                    color: AppColors.lightBlueColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SmallChip(
                                onTap: () {},
                                chipText: 'Pending',
                                chipColor: AppColors.yellowColor1,
                              ),
                            ],
                          ),

                          /// company and offer price
                          const SizedBox(height: 16.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Company :',
                                  descText: 'Amazon',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Offer Price :',
                                  descText: '\$10.92',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          /// Share Class and Shares offered
                          const SizedBox(height: 16.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Share Class :',
                                  descText: 'Series C',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Shares Offered :',
                                  descText: '50,000',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          /// Your Bid Action
                          const SizedBox(height: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Status',
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12.0,
                                  color: AppColors.lightBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  SmallChip(
                                    onTap: () {},
                                    chipText: 'Completed',
                                    chipColor: AppColors.greenColor,
                                    chipTextSize: 10,
                                  ),
                                  const SizedBox(width: 8.0),
                                  SmallChip(
                                    onTap: () {},
                                    chipText: 'Paid',
                                    chipColor: AppColors.blueColor,
                                    chipTextSize: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// apple box
            SizedBox(height: height * 0.02),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    type: PageTransitionType.rightToLeft,
                    child: const HoldingDetailScreen(),
                  ),
                );
              },
              child: Container(
                width: width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 18.0, vertical: 24.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.white1,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(AppImages.appleIcon,
                        height: 45.0, width: 45.0, fit: BoxFit.fill),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Apple Inc',
                                  style: GoogleFonts.poppins().copyWith(
                                    color: AppColors.lightBlueColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SmallChip(
                                onTap: () {},
                                chipText: 'Approved',
                                chipColor: AppColors.greenColor,
                              ),
                            ],
                          ),

                          /// company and offer price
                          const SizedBox(height: 16.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Company :',
                                  descText: 'Amazon',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Offer Price :',
                                  descText: '\$10.92',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          /// Share Class and Shares offered
                          const SizedBox(height: 16.0),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Share Class :',
                                  descText: 'Series C',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                              Expanded(
                                child: CardTextsWidget(
                                  titleText: 'Shares Offered :',
                                  descText: '50,000',
                                  titleTextSize: 12.0,
                                  titleTextColor: AppColors.lightBlueColor,
                                  titleFontWeight: FontWeight.w600,
                                  descTextSize: 11.0,
                                  descTextColor: AppColors.greyColor,
                                  descFontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          /// Your Bid Action
                          const SizedBox(height: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Payment Status',
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12.0,
                                  color: AppColors.lightBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              Row(
                                children: [
                                  SmallChip(
                                    onTap: () {},
                                    chipText: 'Completed',
                                    chipColor: AppColors.greenColor,
                                    chipTextSize: 10,
                                  ),
                                  const SizedBox(width: 8.0),
                                  SmallChip(
                                    onTap: () {},
                                    chipText: 'Paid',
                                    chipColor: AppColors.blueColor,
                                    chipTextSize: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
