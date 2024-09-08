import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/models/bid_model.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/textstyle_const.dart';
import '../../../../../controllers/offer_share_controller.dart';
import '../../../../../models/offer_share_model.dart';
import '../../../../home_screen/issue_digital_certificate/components/card_texts_widget.dart';
import '../components/pay_now_dialog.dart';

class ReviewDetails extends StatefulWidget {
  ReviewDetails({Key? key, required this.onTap, required this.offerShareBid})
      : super(key: key);
  VoidCallback onTap;
  final OfferShareBid offerShareBid;

  @override
  State<ReviewDetails> createState() => _ReviewDetailsState();
}

class _ReviewDetailsState extends State<ReviewDetails> {
  bool checkValue = false;
  final oCcy = NumberFormat("#,##0.00", "en_US");
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var offerShareController =
          Provider.of<OfferShareController>(context, listen: false);
      offerShareController.getPaymentTypes();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var offerShareController = Provider.of<OfferShareController>(context);
    String str = offerShareController.bidPriceTwoController.text.trim();
    String bidPriceTwoController = str.replaceAll(RegExp('[^0-9]'), '');
    String str1 = offerShareController.bidPriceOneController.text.trim();
    String bidPriceOneController = str1.replaceAll(RegExp('[^0-9]'), '');
    return SingleChildScrollView(
      child: Column(
        children: [
          /// please review allocation request details box
          Container(
            width: width,
            padding:
                EdgeInsets.symmetric(horizontal: 24.0, vertical: height * 0.02),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Please review your allocation request details.',
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 15.0,
                    color: AppColors.lightBlueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: height * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CardTextsWidget(
                        titleText: 'Company Shares :',
                        descText: widget.offerShareBid.companyName,
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
                        descText:
                            '\$${oCcy.format(double.parse(bidPriceOneController.toString()))}-${oCcy.format(double.parse(bidPriceTwoController.toString()))} per share',
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
                SizedBox(height: height * 0.01),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CardTextsWidget(
                        titleText: 'Quantity of shares \noffer for sale :',
                        descText:
                            offerShareController.quantityBidController.text,
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
                        descText: offerShareController
                            .selectedLimitDetails!.value
                            .toString(),
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

          /// transaction summery box
          SizedBox(height: height * 0.01),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: 24.0, vertical: height * 0.015),
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
                    '\$${oCcy.format(widget.offerShareBid.quantity * int.parse(bidPriceTwoController))} USD'),
                textRow('Bursa Fees', 'Transaction Fees set at 1%',
                    '\$${oCcy.format(double.parse((widget.offerShareBid.quantity * int.parse(bidPriceTwoController) * (1 / 100)).toStringAsFixed(2)))} USD'),
                textRow(
                    'Net Sale Price',
                    'This is the amount due for payment by bidder',
                    '\$${oCcy.format(double.parse((widget.offerShareBid.quantity * int.parse(bidPriceTwoController) + widget.offerShareBid.quantity * int.parse(bidPriceTwoController) * (1 / 100)).toStringAsFixed(2)))} USD'),
              ],
            ),
          ),

          /// select payment method box
          SizedBox(height: height * 0.01),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: 24.0, vertical: height * 0.012),
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
                    value: offerShareController.selectedPaymentType,
                    items: offerShareController.paymentTypes
                        ?.map(
                          (share) => DropdownMenuItem(
                            child: Text(
                              share.value,
                              style: poppinsRegular.copyWith(
                                color: blackColor,
                                fontSize: width * .036,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: share,
                          ),
                        )
                        .toList(),
                    onChanged: (value) => offerShareController
                        .selectedPaymentType = value as DropDownItem?,
                  ),
                ),
              ],
            ),
          ),

          /// third party declaration box
          SizedBox(height: height * 0.01),
          Container(
            width: width,
            padding: EdgeInsets.symmetric(
                horizontal: 24.0, vertical: height * 0.016),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Third Party Declaration',
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
                        'Check the box if the name on the credit/debit card is different from your name.',
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
                // CustomButton(
                //   enabled: checkValue,
                //   onTap: () {
                //     if (checkValue) {
                //       widget.offerShareBid.paymentMethod =
                //           offerShareController.selectedPaymentType;
                //       Get.dialog(
                //         PayNowDialog(
                //           offerShareBid: widget.offerShareBid,
                //         ),
                //       );
                //     } else {}
                //   },
                //   // btnColor:
                //   //     checkValue ? AppColors.greyColor1 : AppColors.greyColor1,
                //   btnText: 'Submit',
                // ),
                GestureDetector(
                  onTap: () {
                    if (checkValue) {
                      widget.offerShareBid.paymentMethod =
                          offerShareController.selectedPaymentType;
                      Get.dialog(
                        PayNowDialog(
                          offerShareBid: widget.offerShareBid,
                        ),
                      );
                    } else {}
                  },
                  child: Container(
                    height: width * .11,
                    width: width * .78,
                    margin: EdgeInsets.only(
                        top: height * .015, bottom: height * .03),
                    decoration: BoxDecoration(
                      color: checkValue ? greenColor : grey1Color,
                      borderRadius:
                          BorderRadius.all(Radius.circular(width * .02)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Submit",
                          style: poppinsRegular.copyWith(
                            color: whiteColor,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
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
                  child: Container(
                    margin: EdgeInsets.only(right: width * .02),
                    child: Text(
                      descText,
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 11.0,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w500,
                      ),
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
