import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../consts/app_images.dart';
import '../../../../consts/color_const.dart';
import '../../../../consts/textstyle_const.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/small_chip_widget.dart';
import '../../issue_digital_certificate/components/card_texts_widget.dart';

class CompletedBidShare extends StatefulWidget {
  const CompletedBidShare({Key? key}) : super(key: key);

  @override
  State<CompletedBidShare> createState() => _CompletedBidShareState();
}

class _CompletedBidShareState extends State<CompletedBidShare> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.blueColor,
            AppColors.greenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

        /// Appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leadingWidth: 60.0,
          leading: IconButton(
            onPressed: () {
              //Get.offAll(const PersisNavBar());
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset('assets/icons/back_button.png'),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Bid Share",
            style: poppinsRegular.copyWith(
              color: AppColors.white1,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              Container(
                width: width,
                padding: const EdgeInsets.fromLTRB(40.0, 24.0, 40.0, 32.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// logo image
                    Center(
                      child: Image.asset(
                        AppImages.amazonIcon,
                        height: 70.0,
                        width: 70.0,
                        fit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    /// company name
                    Text(
                      'AMAZON INC',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 16.0,
                        color: AppColors.lightBlueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    /// chip row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallChip(
                          onTap: () {},
                          chipText: 'Completed',
                        ),
                        const SizedBox(width: 4.0),
                        SmallChip(onTap: () {}),
                      ],
                    ),
                    SizedBox(height: height * 0.06),

                    /// name and offer price
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
                        SizedBox(width: 40.0),
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
                    const SizedBox(height: 16.0),

                    /// class and offered share
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
                        SizedBox(width: 40.0),
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
                    const SizedBox(height: 16.0),

                    /// Quantity and bid price share
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Quantity Shares',
                            descText: '2000',
                            titleTextSize: 12.0,
                            titleTextColor: AppColors.lightBlueColor,
                            titleFontWeight: FontWeight.w600,
                            descTextSize: 11.0,
                            descTextColor: AppColors.greyColor,
                            descFontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 40.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Bid Price',
                            descText: '\$11.10   per share',
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
                    const SizedBox(height: 16.0),

                    /// bid max price and limit bid
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Bid Maximum rice',
                            descText: '\$11.10 per share',
                            titleTextSize: 12.0,
                            titleTextColor: AppColors.lightBlueColor,
                            titleFontWeight: FontWeight.w600,
                            descTextSize: 11.0,
                            descTextColor: AppColors.greyColor,
                            descFontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 40.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Limit Bid',
                            descText: '\$11.10',
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
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: width,
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Transaction Summery',
                      style: GoogleFonts.poppins().copyWith(
                        color: AppColors.darkBlueColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    textRow(
                        'Total Sale Price',
                        'This is the amount due for \npayment by bidder',
                        '22,000 USD'),
                    textRow('Bursa Fees', 'Transaction Fees set at 1%',
                        '21,000 USD'),
                    textRow('Bursa Fees', 'Net to seller', '21,780 USD'),
                    const SizedBox(height: 8.0),
                    CustomButton(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     ///builder: (context) => HomeScreen(),
                        //     builder: (context) => HomeScreen(),
                        //   ),
                        // );
                        Navigator.pushAndRemoveUntil(
                            context,
                            PageTransition(
                              duration: const Duration(milliseconds: 300),
                              reverseDuration:
                                  const Duration(milliseconds: 300),
                              type: PageTransitionType.rightToLeft,
                              child: const HomeScreen(),
                            ),
                            (route) => false);
                      },
                      btnText: 'Back to Home',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textRow(titleText, descText, descPrice) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: GoogleFonts.poppins().copyWith(
                fontSize: 12.0,
                color: AppColors.lightBlueColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    descText,
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 11.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  descPrice,
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 12.0,
                    color: AppColors.lightBlueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
