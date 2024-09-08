import 'package:bursa_flutter/views/home_screen/bid_buy_shares/bid_share/request_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../consts/app_images.dart';
import '../../../../consts/color_const.dart';
import '../../../../widgets/small_chip_widget.dart';
import '../../issue_digital_certificate/components/card_texts_widget.dart';
import 'completed_bid_share.dart';

class BidShareScreen extends StatefulWidget {
  const BidShareScreen({Key? key}) : super(key: key);

  @override
  State<BidShareScreen> createState() => _BidShareScreenState();
}

class _BidShareScreenState extends State<BidShareScreen> {
  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),

            /// amazon card
            GestureDetector(
              onTap: () {
                // Get.to(const RequestReviewScreen());
                Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    type: PageTransitionType.rightToLeft,
                    child: const RequestReviewScreen(),
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
                                'Your Bid Action',
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12.0,
                                  color: AppColors.lightBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              SmallChip(
                                onTap: () {},
                                chipText: 'Pending',
                                chipColor: AppColors.yellowColor1,
                                chipTextSize: 10,
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
            const SizedBox(height: 16.0),

            /// apple card
            GestureDetector(
              onTap: () {
                // Get.to(const CompletedBidShare());
                Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    type: PageTransitionType.rightToLeft,
                    child: const CompletedBidShare(),
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
                                'Your Bid Action',
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12.0,
                                  color: AppColors.lightBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              SmallChip(
                                onTap: () {},
                                chipText: 'Completed',
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
            const SizedBox(height: 16.0),

            /// apple card
            GestureDetector(
              onTap: () {
                // Get.to(const CompletedBidShare());
                Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 300),
                    reverseDuration: const Duration(milliseconds: 300),
                    type: PageTransitionType.rightToLeft,
                    child: const CompletedBidShare(),
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
                                'Your Bid Action',
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 12.0,
                                  color: AppColors.lightBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4.0),
                              SmallChip(
                                onTap: () {},
                                chipText: 'Completed',
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
            const SizedBox(height: 36.0),
          ],
        ),
      ),
    );
  }
}
