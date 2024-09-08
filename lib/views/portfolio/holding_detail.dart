import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../consts/app_images.dart';
import '../../../../consts/color_const.dart';
import '../../../../consts/textstyle_const.dart';
import '../../../../widgets/small_chip_widget.dart';
import '../home_screen/issue_digital_certificate/components/card_texts_widget.dart';

class HoldingDetailScreen extends StatefulWidget {
  const HoldingDetailScreen({Key? key}) : super(key: key);

  @override
  State<HoldingDetailScreen> createState() => _HoldingDetailScreenState();
}

class _HoldingDetailScreenState extends State<HoldingDetailScreen> {
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
            "My Holdings",
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
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 16.0),
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
                        const SizedBox(width: 4.0),
                        SmallChip(
                          onTap: () {},
                          chipText: 'Paid',
                          chipColor: AppColors.blueColor,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.06),

                    /// amount placement and total investment
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width: 16.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Placement Amount',
                            descText: '\$12.5',
                          ),
                        ),
                        SizedBox(width: 40.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Total Investment',
                            descText: '\$10,000 ',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),

                    /// Bursa Fees and Total Amount
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width: 16.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Bursa Fees',
                            descText: '\$200.00',
                          ),
                        ),
                        SizedBox(width: 40.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Total Amount',
                            descText: '\$10,200 ',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24.0),

                    /// Payment Method
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        SizedBox(width: 16.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Payment Method',
                            descText: 'Bank Transfer',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32.0),
                    CustomButton(
                      onTap: () {
                        // Get.offAll(const HomeScreen());
                        Navigator.push(
                          context,
                          PageTransition(
                            duration: const Duration(milliseconds: 300),
                            reverseDuration: const Duration(milliseconds: 300),
                            type: PageTransitionType.rightToLeft,
                            child: const HomeScreen(),
                          ),
                        );
                      },
                      btnText: 'Back to Home',
                      margin: const EdgeInsets.all(0.0),
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
}
