import 'dart:developer';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/models/getAll_primary_model.dart';
import 'package:bursa_flutter/views/auth/registration/registration_success.dart';
import 'package:bursa_flutter/views/market/equity/seconday_offer/submit_request/thanks_submit_request.dart';
import 'package:bursa_flutter/widgets/loading_progress_widget.dart';
import 'package:bursa_flutter/widgets/register_share_row_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';

import '../../seconday_offer/components/pay_success_dialog.dart';

class ConnsentDialog extends StatefulWidget {
  const ConnsentDialog({Key? key, required this.primaryOfferDataInfo})
      : super(key: key);
  final PrimaryOfferDataInfo primaryOfferDataInfo;
  @override
  State<ConnsentDialog> createState() => _ConnsentDialogState();
}

class _ConnsentDialogState extends State<ConnsentDialog> {
  // bool agre = false;
  // bool agre1 = false;
  // bool status = false;
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    PrimaryOfferController _controller =
        Provider.of<PrimaryOfferController>(context, listen: true);

    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        margin: EdgeInsets.only(
          top: height * .1,
          left: width * .04,
          right: width * .04,
          bottom: height * .035,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 37.0),
        // padding: EdgeInsets.only(
        //     top: width * .01,
        //     bottom: width * .06,
        //     right: width * .06,
        //     left: width * .06),
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
              'Overview disclosures & disclaimers',
              style: poppinsRegular.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.lightBlueColor,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.only(top: width * .015),
              child: Text(
                "Please Read Carefully till the end to be able to activate the Consent Button",
                style: poppinsRegular.copyWith(
                  fontSize: width * .034,
                  color: greyColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: width * .02),
                    padding: EdgeInsets.only(
                        left: width * .02,
                        right: width * .02,
                        top: width * .02,
                        bottom: width * .02),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: AppColors.greyColor1,
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      "This overview doesnt consitute selling of securities or offer to purchase securitie. No offer to sell or solicitation of an offer to buy may be.",
                      style: TextStyle(
                        fontSize: width * .034,
                        color: greyColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(
                        left: width * .02,
                        right: width * .02,
                        bottom: height * .015,
                        top: height * .015),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      border: Border.all(
                        color: AppColors.greyColor1,
                        width: 0.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Consent",
                              style: TextStyle(
                                fontSize: 16,
                                color: lightBlueColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            FlutterSwitch(
                              width: 40,
                              height: 20.0,
                              valueFontSize: 0.0,
                              toggleSize: 20.0,
                              value: _controller.consent,
                              borderRadius: 30.0,
                              activeColor: greenColorWithOpacity20,
                              inactiveColor: lightGreyColor,
                              toggleColor: greenColor,
                              padding: 2.0,
                              showOnOff: true,
                              onToggle: (val) {
                                // setState(() {
                                //   _controller.consent == val;
                                // });
                                _controller.setConsent(val);
                              },
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: height * .005, bottom: height * .008),
                          child: Text(
                            "By click the submit button below",
                            style: TextStyle(
                              fontSize: width * .034,
                              color: greyColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Checkbox(
                            //     value: check,
                            //     activeColor: Colors.grey,
                            //     shape: RoundedRectangleBorder(
                            //         borderRadius:
                            //             BorderRadius.circular(
                            //                 5.0)),
                            //     onChanged: (value) {
                            //       if (!check) {
                            //         setState(() {
                            //           check = value!;
                            //           check1 = !value;
                            //         });
                            //       }
                            //     }),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(5.0),
                                onTap: () {
                                  _controller.setAgre();
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
                                  child: _controller.agre == true
                                      ? const Center(
                                          child: Icon(Icons.check,
                                              color: AppColors.lightBlueColor,
                                              size: 12.0),
                                        )
                                      : const SizedBox(),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: width * .015),
                                child: Text(
                                  "I acknowledge that I am providing the project sponsor an indication of my interest to invest in the deal based on my review of the information made available to me.",
                                  style: TextStyle(
                                    fontSize: width * .034,
                                    color: greyColor,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(5.0),
                                  onTap: () {
                                    _controller.setAgre1();
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
                                    child: _controller.agre1 == true
                                        ? const Center(
                                            child: Icon(Icons.check,
                                                color: AppColors.lightBlueColor,
                                                size: 12.0),
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: width * .015),
                                  child: Text(
                                    "I have read the forgoing information, disclosures and disclaimers, and understand its contents, including that I will be asked to review, pay,  execute, and deliver additional materials including a binding subscription or similar agreement, identity documents before acceptance of my allocation request. ",
                                    style: TextStyle(
                                      fontSize: width * .034,
                                      color: greyColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Container(
            // margin: EdgeInsets.only(top: height * .04),
            // height: height * .05, //height of button
            // width: width * .8, //width of button
            //   child: ElevatedButton(
            //     style: ElevatedButton.styleFrom(
            //       primary: (_controller.consent == false ||
            //               _controller.agre == false ||
            //               _controller.agre1 == false)
            //           ? grey1Color
            //           : AppColors.greenColor, //background color of button
            //       //elevation of button
            //     ),
            //     onPressed: () {
            // (_controller.agre == false ||
            //         _controller.agre1 == false ||
            //         _controller.consent == false)
            //     ? null
            //     : setState(() {
            //         isloading = true;
            //       });
            // int.parse(_controller.BidPrimaryOffer(
            //         '${widget.primaryOfferDataInfo.companyId}')
            //     .then((value) {
            //   if (value) {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) =>
            //                 ThanksSubmitRequestScreen()));
            //   }
            // }).toString());
            // log("primaryOfferDataInfo.companyId.toString()" +
            //     widget.primaryOfferDataInfo.companyId.toString());
            // log("Successfully Bid");
            // setState(() {
            //   isloading = false;
            // });
            // // Get.dialog(
            // //           const PaymentSuccessDialog(),
            // //         );
            //     },
            //     child: isloading
            //         ? Consumer<PrimaryOfferController>(
            //             builder: (_, a, child) {
            //               return Row(
            //                 mainAxisSize: MainAxisSize.min,
            //                 children: [
            //                   Text(
            //                     "Sending your request: ${a.fileUploadProgress}/100",
            //                     style: poppinsRegular.copyWith(
            //                       color: whiteColor,
            //                       fontSize: width * .027,
            //                       fontWeight: FontWeight.w500,
            //                       letterSpacing: 1,
            //                     ),
            //                   ),
            //                   Container(
            //                     width: 20,
            //                     height: 20,
            //                     margin: const EdgeInsets.all(5.0),
            //                     child: const CircularProgressIndicator(
            //                       strokeWidth: 1,
            //                       color: Colors.white,
            //                     ),
            //                   ),
            //                 ],
            //               );
            //             },
            //             child: const LoadingProgressWidget(),
            //           )
            //         : Text("PAY NOW"),
            //   ),
            // ),

            GestureDetector(
              onTap: (_controller.agre == false ||
                      _controller.agre1 == false ||
                      _controller.consent == false)
                  ? null
                  : () {
                      setState(() {
                        isloading = true;
                      });

                      _controller.BidPrimaryOffer(
                              widget.primaryOfferDataInfo.companyId)
                          .then((value) {
                        if (value == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ThanksSubmitRequestScreen()));
                        }
                        log("get value" + value.toString());
                        setState(() {
                          isloading = false;
                        });
                      });
                      log("primaryOfferDataInfo.companyId.toString()" +
                          widget.primaryOfferDataInfo.companyId.toString());
                      log("Successfully Bid");
                      // setState(() {
                      //   isloading = false;
                      // });
                      // Get.dialog(
                      //           const PaymentSuccessDialog(),
                      //         );
                    },
              child: Container(
                margin: EdgeInsets.only(top: height * .04),
                height: height * .05, //height of button
                width: width * .8, //width of button
                decoration: BoxDecoration(
                  color: (_controller.consent == false ||
                          _controller.agre == false ||
                          _controller.agre1 == false)
                      ? grey1Color
                      : AppColors.greenColor, //background color of button
                  borderRadius: BorderRadius.circular(5.0),
                ),

                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height * .01),
                      child: isloading
                          ? Consumer<PrimaryOfferController>(
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
                          : Text("PAY NOW",
                              textAlign: TextAlign.center,
                              style: poppinsRegular.copyWith(
                                color: whiteColor,
                                fontSize: width * .04,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                              )),
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin:
                    EdgeInsets.only(top: height * .01, bottom: height * .01),
                child: const Center(
                  child: Text(
                    "Back To Review",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.greenColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
