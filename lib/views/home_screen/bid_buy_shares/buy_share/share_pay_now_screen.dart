import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

import '../../../../consts/app_images.dart';
import '../../../../consts/color_const.dart';
import '../../../../consts/textstyle_const.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/small_chip_widget.dart';
import '../../issue_digital_certificate/components/card_texts_widget.dart';
import 'pay_now_screen.dart';

class SharePayNowScreen extends StatefulWidget {
  const SharePayNowScreen({Key? key}) : super(key: key);

  @override
  State<SharePayNowScreen> createState() => _SharePayNowScreenState();
}

class _SharePayNowScreenState extends State<SharePayNowScreen> {
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
            "Bid & Buy Share",
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
                padding: const EdgeInsets.fromLTRB(40.0, 24.0, 40.0, 16.0),
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
                    Text('AMAZON INC',
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
                          onTap: (){},
                          chipText: 'Pending',
                          chipColor: AppColors.yellowColor1,
                        ),
                        const SizedBox(width: 4.0),
                        SmallChip(onTap: (){}),
                      ],
                    ),
                    SizedBox(height: height * 0.03),

                    /// amount placement and total investment
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
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
                    const SizedBox(height: 16.0),

                    /// Bursa Fees and Total Amount
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
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
                    const SizedBox(height: 16.0),

                    /// Payment Method
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Payment Method',
                            descText: 'Online',
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
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textRow('Total Sale Price', 'This is the amount due for \npayment by bidder', '22,000 USD'),
                    textRow('Bursa Fees', 'Transaction Fees set at 1%', '21,000 USD'),
                    textRow('Bursa Fees', 'Net to seller', '21,780 USD'),
                    const SizedBox(height: 8.0),
                    CustomButton(
                      onTap: (){
                        pushNewScreen(
                          context,
                          screen: const PayNowScreen(),
                          withNavBar: true,
                        );
                      },
                      btnText: 'Pay Now',
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


  Widget textRow(titleText, descText, descPrice) =>  Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(titleText,
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
              child: Text(descText,
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 11.0,
                  color: AppColors.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),),
            Text(descPrice,
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
