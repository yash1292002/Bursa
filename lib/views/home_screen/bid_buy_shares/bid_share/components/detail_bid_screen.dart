import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../consts/textstyle_const.dart';
import '../../../issue_digital_certificate/components/card_texts_widget.dart';
import 'dialog_data.dart';

class DetailBidScreen extends StatefulWidget {
  DetailBidScreen({Key? key, required this.onTap}) : super(key: key);

  VoidCallback onTap;

  @override
  State<DetailBidScreen> createState() => _DetailBidScreenState();
}

class _DetailBidScreenState extends State<DetailBidScreen> {
  String? bankValue;
  bool checkValue = false;

  List<String> bankName = [
    "Bank 1",
    "Bank 2",
    "Bank 3",
    "Bank 4",
    "Bank 5",
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Please confirm your offering details.',
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
                        titleText: 'Company Shares :',
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
                        titleText: 'Bid Price :',
                        descText: '\$11-12.5 per share',
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
                        titleText: 'Quantity of shares \noffer for sale :',
                        descText: '2,000',
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
                        titleText: 'Bid Period :',
                        descText: '24 hours',
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
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 15.0),
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
                textRow(
                    'Bursa Fees', 'Transaction Fees set at 1%', '21,000 USD'),
                textRow('Bursa Fees', 'Net to seller', '21,780 USD'),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: width,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Select Payment Method',
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.darkBlueColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Container(
                  width: width,
                  height: 40.0,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: width * .002,
                        color: lightBlueColorWithopacity30,
                      ),
                    ),
                  ),
                  child: DropdownButton(
                    hint: Text(
                      "Bank Transfer",
                      style: poppinsRegular.copyWith(
                        color: lightBlueColor,
                        fontSize: width * .036,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: poppinsRegular.copyWith(
                      color: blackColor,
                      fontSize: width * .036,
                      fontWeight: FontWeight.w500,
                    ),
                    isExpanded: true,
                    underline: DropdownButtonHideUnderline(
                      child: Container(),
                    ),
                    value: bankValue,
                    items: List.generate(bankName.length, (index) {
                      return DropdownMenuItem(
                          child: Text(
                            bankName[index],
                            style: poppinsRegular.copyWith(
                              color: blackColor,
                              fontSize: width * .036,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: bankName[index]);
                    }),
                    onChanged: (value) {
                      setState(() {
                        bankValue = value as String;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            width: width,
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Third Party Decleration',
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.darkBlueColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5.0),
                        onTap: () {
                          setState(() {
                            checkValue = !checkValue;
                          });
                        },
                        child: Ink(
                          height: 16.0,
                          width: 16.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                              color: AppColors.greyColor,
                              width: 1.0,
                            ),
                          ),
                          child: checkValue == true
                              ? const Center(
                                  child: Icon(Icons.check,
                                      color: AppColors.lightBlueColor,
                                      size: 12.0),
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Expanded(
                      child: Text(
                        'Check the box if the name on the credit/debit card is diffrent from your name.',
                        style: GoogleFonts.montserrat(
                          fontSize: 11.0,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CustomButton(
                  onTap: () {
                    Get.dialog(
                      const DialogData(),
                    );
                  },
                  btnText: 'Submit',
                ),
              ],
            ),
          ),
        ],
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
