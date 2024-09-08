import 'dart:developer';

import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/views/market/equity/seconday_offer/components/pay_success_dialog.dart';
import 'package:bursa_flutter/widgets/loading_progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../controllers/offer_share_controller.dart';
import 'payment_failed_dialog.dart';

class PayNowDialog extends StatefulWidget {
  const PayNowDialog({Key? key, required this.offerShareBid}) : super(key: key);
  final OfferShareBid offerShareBid;

  @override
  State<PayNowDialog> createState() => _PayNowDialogState();
}

class _PayNowDialogState extends State<PayNowDialog> {
  // bool isConsent = true;
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    OfferShareController _controller =
        Provider.of<OfferShareController>(context, listen: false);
    _controller.resetConsent();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var offerShareController = Provider.of<OfferShareController>(context);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: height * 0.1),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11.0),
          color: AppColors.white1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'One last step before submiting '
              '\nyour request. ',
              style: GoogleFonts.poppins().copyWith(
                color: AppColors.lightBlueColor,
                fontSize: 15.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.022),
            Text(
              'Please ensure reading the bidding/purchase terms and '
              'conditions before submitting your request. You can access '
              'the full terms and conditions at ',
              style: GoogleFonts.poppins().copyWith(
                color: AppColors.greyColor,
                fontSize: 12.0,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w500,
              ),
            ),
            GestureDetector(
              onTap: () {
                termCondition();
              },
              child: Text(
                'www.wearebursa.com/termsandconditions',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.blueColor2,
                  fontSize: 12.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              width: width,
              margin: EdgeInsets.symmetric(vertical: height * 0.04),
              padding: const EdgeInsets.fromLTRB(26.0, 32.0, 24.0, 44.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: AppColors.greyColor1,
                  width: 0.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Consent',
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 12.0,
                          color: AppColors.lightBlueColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width * .03, right: 0),
                        child: FlutterSwitch(
                          width: width * .1,
                          height: width * .05,
                          toggleSize: width * .04,
                          value: offerShareController.isConsent,
                          toggleColor: greenColor,
                          borderRadius: width * .03,
                          activeColor: greenColorWithOpacity20,
                          inactiveColor: lightGreyColor,
                          padding: width * .006,
                          onToggle: (val) {
                            // setState(() {
                            //   isConsent = val;
                            // });
                            offerShareController.setConsent(val);
                            log(val.toString());
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.016),
                  GestureDetector(
                    onTap: () {
                      termCondition();
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You agree and abide by Bursa’’s',
                          style: GoogleFonts.poppins().copyWith(
                            color: AppColors.greyColor,
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Terms and Conditions',
                          style: GoogleFonts.poppins().copyWith(
                            color: AppColors.blueColor2,
                            fontSize: 12.0,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // CustomButton(
            //   //   onTap: () async {
            //   //     if (offerShareController.isConsent) {
            //   //       Map? result = await offerShareController.BidNewShare();
            //   //       bool completed = result!['success'];

            //   //       if (completed) {
            //   //         Get.back();
            //   //         Get.dialog(
            //   //           const PaymentSuccessDialog(),
            //   //         );
            //   //       } else {
            //   //         Get.dialog(
            //   //           PaymentFailedDialog(message: result['message']),
            //   //         );
            //   //       }
            //   //     }
            //   //   },
            //   //   btnText: 'PAY NOW',
            //   //   enabled: offerShareController.isConsent,
            //   // ),
            //   onTap: () async {
            //     if (offerShareController.isConsent) {
            //       Map result = await offerShareController
            //           .offerPayment(widget.offerShareBid);
            //       bool completed = result['success'];
            //       if (completed) {
            //         Map? result1 = await offerShareController.BidNewShare();
            //         if (result1!['returnCode'] == 200) {
            //           Get.back();
            //           Get.dialog(
            //             const PaymentSuccessDialog(),
            //           );
            //         }
            //       } else {
            //         Get.dialog(
            //           PaymentFailedDialog(message: result['message']),
            //         );
            //       }
            //     }
            //   },
            //   btnText: 'PAY NOW',
            //   enabled: offerShareController.isConsent,
            // ),
            GestureDetector(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                if (offerShareController.isConsent) {
                  Map result = await offerShareController
                      .offerPayment(widget.offerShareBid);
                  bool completed = result['success'];
                  if (completed) {
                    Map? result1 = await offerShareController.BidNewShare();
                    if (result1!['returnCode'] == 200) {
                      Get.back();
                      Get.dialog(
                        const PaymentSuccessDialog(),
                      );
                    }
                  } else {
                    Get.dialog(
                      PaymentFailedDialog(message: result['message']),
                    );
                  }
                }
                setState(() {
                  isLoading = false;
                });
              },
              child: Container(
                height: width * .11,
                margin: EdgeInsets.only(
                  top: width * .1,
                ),
                decoration: BoxDecoration(
                  color:
                      offerShareController.isConsent ? greenColor : grey1Color,
                  borderRadius: BorderRadius.all(Radius.circular(width * .02)),
                ),
                alignment: Alignment.center,
                child: isLoading
                    ? Consumer<OfferShareController>(
                        builder: (_, a, child) {
                          return Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Sending your request: ${a.fileUploadProgress}/100",
                                style: poppinsRegular.copyWith(
                                  color: whiteColor,
                                  fontSize: width * .027,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1,
                                ),
                              ),
                              Container(
                                width: 20,
                                height: 20,
                                margin: const EdgeInsets.all(5.0),
                                child: const CircularProgressIndicator(
                                  strokeWidth: 1,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          );
                        },
                        child: const LoadingProgressWidget(),
                      )
                    : Text(
                        "PAY NOW",
                        style: poppinsRegular.copyWith(
                          color: whiteColor,
                          fontSize: width * .04,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Back to Review',
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greenColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void termCondition() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * .02),
            topRight: Radius.circular(width * .02),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: height * .8,
            margin: EdgeInsets.only(
              top: height * .01,
              left: width * .06,
              right: width * .06,
            ),
            child: Column(
              children: [
                Container(
                  width: width * .3,
                  height: height * .002,
                  color: lightGreyColor,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .025,
                    bottom: height * .025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        "Terms & Conditions",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .058,
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/closeicon.png",
                          height: width * .04,
                          width: width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1. INTRODUCTION",
                            style: poppinsRegular.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: width * .04),
                          ),
                          Text(
                            terms1Condition[0]["text1"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "2. GENERAL SECURITIES LAW",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text2"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "3. USER OBLIGATIONS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text3"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "4. PRIVACY AND PROTECTION POLICY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text4"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "5. OWNERSHIP OF PLATFORM, SERVICES & CONTENT, INVESTOR QUESTIONNAIRE, SUBSCRIBTION AGREEMENTS AND ALLOCATION FORMS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text5"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "6. RESERVATION OF COMPANY RIGHTS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text6"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "7. SCOPE OF BURSA’S OBLIGATIONS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text7"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "8. TERM & TERMINATION",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text8"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "9. DISCLAIMERS, LIMITATIONS, WAIVERS OF LIABILITY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text9"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "10. INDEMNIFICATION",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text10"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "11. MICELLENOUS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text11"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "12. DEFINITIONS, LISCENSE GRANT",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text12"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          );
        });
  }
}
