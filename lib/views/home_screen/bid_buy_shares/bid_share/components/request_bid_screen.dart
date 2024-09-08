import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts/color_const.dart';
import '../../../issue_digital_certificate/components/card_texts_widget.dart';
import '../../../offer_shares/add_share_request/components/my_text_field.dart';

class RequestBidScreen extends StatefulWidget {
  RequestBidScreen({Key? key, required this.onTap}) : super(key: key);

  VoidCallback onTap;

  @override
  State<RequestBidScreen> createState() => _RequestBidScreenState();
}

class _RequestBidScreenState extends State<RequestBidScreen> {

  TextEditingController quantityController = TextEditingController();
  TextEditingController bidPriceOneController = TextEditingController();
  TextEditingController bidPriceTwoController = TextEditingController();
  TextEditingController limitBidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Please confirm your offering details.',
                style: GoogleFonts.poppins().copyWith(
                  fontSize: 15.0,
                  color: AppColors.lightBlueColor,
                  fontWeight: FontWeight.w600,
                ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Expanded(
                      child: CardTextsWidget(
                        titleText: 'Company :',
                        descText: 'Amazon Inc',
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
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  /// quantity share field
                  Text('Quantity',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlueColor,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('How many shares would you like to sell ?',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
                  MyTextField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    hintText: '2000',
                    suffixText: 'Shares',
                  ),
                  const SizedBox(height: 3.0),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text('Minimum quantity: 1000 shares',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),

                  /// bid One price field
                  const SizedBox(height: 16.0),
                  Text('Bid Price',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlueColor,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('How much are you willing to buy the share for? '
                      '(bid price should be above  or equal to the offer price',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
                  MyTextField(
                    controller: bidPriceOneController,
                    keyboardType: TextInputType.text,
                    hintText: '\$11.10',
                    suffixText: 'Per Shares',
                  ),

                  /// bid two price field
                  const SizedBox(height: 16.0),
                  Text('Bid Price',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlueColor,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('How much are you willing to sell the share for?',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
                  MyTextField(
                    controller: bidPriceTwoController,
                    keyboardType: TextInputType.text,
                    hintText: '\$12.5',
                    suffixText: 'Per Shares',
                  ),

                  /// Limit Bid field
                  const SizedBox(height: 16.0),
                  Text('Limit Bid',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlueColor,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('When does your offer end ?',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
                  MyTextField(
                    controller: limitBidController,
                    keyboardType: TextInputType.number,
                    hintText: '2',
                    suffixText: 'Weeks',
                  ),

                  const SizedBox(height: 24.0),
                  CustomButton(
                    onTap: widget.onTap,
                    btnText: 'Submit',
                  ),

                ],
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
