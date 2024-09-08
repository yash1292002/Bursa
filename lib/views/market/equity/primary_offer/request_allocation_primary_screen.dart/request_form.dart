import 'dart:developer';

import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/controllers/primary_offer_controller.dart';
import 'package:bursa_flutter/models/getAll_primary_model.dart';
import 'package:bursa_flutter/models/payment_type_model.dart';
import 'package:bursa_flutter/utils/custom_dropdown.dart';
import 'package:bursa_flutter/views/home_screen/offer_shares/add_share_request/components/my_text_field.dart';
import 'package:bursa_flutter/views/market/equity/primary_offer/components/consent_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../consts/textstyle_const.dart';
import '../../../../../widgets/register_share_row_text.dart';
import 'dart:io' as io;

class PrimaryRequestForm extends StatefulWidget {
  PrimaryRequestForm({
    Key? key,
    required this.primaryOfferDataInfo,
    required this.onTap,
  }) : super(key: key);
  VoidCallback onTap;
  final PrimaryOfferDataInfo primaryOfferDataInfo;
  @override
  State<PrimaryRequestForm> createState() => _PrimaryRequestFormState();
}

class _PrimaryRequestFormState extends State<PrimaryRequestForm> {
  String StateValue = 'Bank Transfer';
  bool isLoading = true;
  String investmentController1 = "";

  @override
  void initState() {
    PrimaryOfferController _primaryOfferController =
        Provider.of<PrimaryOfferController>(context, listen: false);

    setState(() {
      log("double investmentController" + investmentController1);

      isLoading = false;
    });
    super.initState();
  }

  final oCcy = NumberFormat("#,##0.00", "en_US");
  final FocusNode _nodeText1 = FocusNode();
  // final FocusNode _nodeText2 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    PrimaryOfferController _controller =
        Provider.of<PrimaryOfferController>(context, listen: true);

    return KeyboardActions(
      config: _buildConfig(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// allocation request detail box
            Container(
              width: width,
              padding: EdgeInsets.only(
                  top: height * .015, left: width * .04, bottom: 0, right: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: AppColors.white1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '${widget.primaryOfferDataInfo.companyName}',
                    style: poppinsRegular.copyWith(
                      color: AppColors.lightBlueColor,
                      fontWeight: FontWeight.w600,
                      fontSize: width * .035,
                    ),
                  ),
                  SizedBox(height: height * 0.003),
                  Row(
                    children: [
                      Text(
                        "Minimum Investment :",
                        style: poppinsRegular.copyWith(
                            color: AppColors.lightBlueColor,
                            fontWeight: FontWeight.w400,
                            fontSize: width * .028,
                            letterSpacing: 1.0),
                      ),
                      Text(
                          " \$${widget.primaryOfferDataInfo.minimumInvestment}",
                          style: poppinsRegular.copyWith(
                              color: AppColors.greyColor,
                              fontSize: width * .028,
                              letterSpacing: .5))
                    ],
                  ),
                  SizedBox(height: height * 0.003),
                  Row(
                    children: [
                      Text(
                        "Closing Date :",
                        style: poppinsRegular.copyWith(
                            color: AppColors.lightBlueColor,
                            fontSize: width * .028,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1),
                      ),
                      Text(" ${widget.primaryOfferDataInfo.closingDate}",
                          style: poppinsRegular.copyWith(
                              letterSpacing: .5,
                              color: AppColors.greyColor,
                              fontSize: width * .028))
                    ],
                  ),
                  SizedBox(height: height * 0.003),
                  Row(
                    children: [
                      Text(
                        "Investment Manager :",
                        style: poppinsRegular.copyWith(
                            color: AppColors.lightBlueColor,
                            fontSize: width * .028,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1),
                      ),
                      Text(" ${widget.primaryOfferDataInfo.investmentManager}",
                          style: poppinsRegular.copyWith(
                              letterSpacing: .5,
                              color: AppColors.greyColor,
                              fontSize: width * .028))
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                ],
              ),
            ),

            /// quantity Box
            SizedBox(height: height * 0.01),
            Container(
              width: width,
              padding: EdgeInsets.only(
                  top: height * .015,
                  left: width * .04,
                  bottom: height * .01,
                  right: width * .04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: AppColors.white1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   child: Text("Placement Amount",
                  //       style: poppinsRegular.copyWith(
                  //           color: AppColors.lightBlueColor,
                  //           fontSize: width * .035,
                  //           fontWeight: FontWeight.w600,
                  //           letterSpacing: .5)),
                  // ),
                  Text(
                    'Placement Amount',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlueColor,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'How much would you like to invest ?',
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w400,
                      color: AppColors.greyColor,
                    ),
                  ),
                  io.Platform.isAndroid
                      ? MyTextField(
                          //  focusNode: _nodeText1,
                          controller: _controller.investmentController,
                          keyboardType: TextInputType.number,
                          hintText: '',
                          suffixText: 'USD',
                          onChanged: (val) {
                            if (double.parse(widget
                                    .primaryOfferDataInfo.minimumInvestment
                                    .toString()) <=
                                double.parse(
                                    _controller.investmentController.text)) {
                            } else {
                              Fluttertoast.showToast(
                                msg:
                                    "The entered value should be same or above of the Minimum Investment . Review your detail and try again.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: whiteColor,
                                textColor: greenColor,
                                fontSize: 15,
                              );
                            }
                          })
                      : MyTextField(
                          focusNode: _nodeText1,
                          controller: _controller.investmentController,
                          keyboardType: TextInputType.number,
                          hintText: '',
                          suffixText: 'USD',
                          onChanged: (val) {
                            if (double.parse(widget
                                    .primaryOfferDataInfo.minimumInvestment
                                    .toString()) <=
                                double.parse(
                                    _controller.investmentController.text)) {
                            } else {
                              Fluttertoast.showToast(
                                msg:
                                    "The entered value should be same or above of the Minimum Investment . Review your detail and try again.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: whiteColor,
                                textColor: greenColor,
                                fontSize: 15,
                              );
                            }
                          }),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Minimum amount: \$${widget.primaryOfferDataInfo.minimumInvestment}',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 9.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
              width: width,
              padding: EdgeInsets.only(
                  top: height * .0,
                  left: width * .04,
                  bottom: 0,
                  right: width * .04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: AppColors.white1,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: height * .01, bottom: height * .005),
                    child: Text("Document Signing Method",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlueColor,
                        )),
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select your preffered method',
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w400,
                          color: AppColors.greyColor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height * .01),
                    child: Row(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: () {
                              _controller.setEsign();
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
                              child: _controller.esign == true
                                  ? const Center(
                                      child: Icon(Icons.check,
                                          color: AppColors.lightBlueColor,
                                          size: 12.0),
                                    )
                                  : const SizedBox(),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: width * .015),
                          child: Text("E - Sign",
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightBlueColor,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: height * .01, bottom: height * .01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: () {
                              _controller.setDownload();
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
                              child: _controller.download == true
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
                            child: Text("Download & sign",
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.lightBlueColor,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.01),
            Container(
                width: width,
                padding: EdgeInsets.only(
                    top: height * .012,
                    left: width * .04,
                    bottom: 0,
                    right: width * .04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(11.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Transaction Summery",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlueColor,
                        )),
                    Container(
                      margin: EdgeInsets.only(top: height * .01),
                      child: Text("Total Investment",
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600,
                            color: AppColors.lightBlueColor,
                          )),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.pink,
                            margin: EdgeInsets.only(
                                right: width * .1, top: height * .005),
                            child: Text(
                              "This is your placement investment amount",
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width * .05),
                          child: Text(
                              '\$${_controller.investmentController.text.isEmpty ? 0.00 : oCcy.format(double.parse(_controller.investmentController.text.replaceAll(RegExp('[^0-9]'), '')))} USD',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightBlueColor,
                              )),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * .015),
                      child: Text(
                        "Bursa Fees",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlueColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.pink,
                            margin: EdgeInsets.only(
                                right: width * .1, top: height * .005),
                            child: Text(
                              "Placement Fees at ${widget.primaryOfferDataInfo.busraFees}%",
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width * .05),
                          child: Text(
                              _controller.investmentController.text == ""
                                  ? "\$0.0 USD"
                                  : '\$${oCcy.format(double.parse((1 * double.parse(_controller.investmentController.text.replaceAll(RegExp('[^0-9]'), '')) * (double.parse(widget.primaryOfferDataInfo.busraFees.toString()) / 100)).toStringAsFixed(2)))} USD',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightBlueColor,
                              )),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * .015),
                      child: Text(
                        "Total Amount",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlueColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            // color: Colors.pink,
                            margin: EdgeInsets.only(
                                right: width * .1, top: height * .005),
                            child: Text(
                              "This is the amount you  you will need to pay",
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 11.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: width * .05),
                          child: Text(
                              _controller.investmentController.text == ""
                                  ? "\$0.0 USD"
                                  : '\$${oCcy.format(double.parse(_controller.investmentController.text.replaceAll(RegExp('[^0-9]'), '')) * (double.parse(widget.primaryOfferDataInfo.busraFees.toString()) / 100) + double.parse(_controller.investmentController.text.replaceAll(RegExp('[^0-9]'), '')))} USD',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.lightBlueColor,
                              )),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * .015),
                      child: Text(
                        "Select Payment Method",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlueColor,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(),
                      width: width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: width * .002,
                            color: lightBlueColorWithopacity30,
                          ),
                        ),
                      ),
                      child: DropdownButton<PaymentTypeInfo>(
                        hint: Text(
                          "Select Payment Method",
                          style: poppinsRegular.copyWith(
                            color: lightBlueColorWithopacity40,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: poppinsRegular.copyWith(
                          color: blackColor,
                          fontSize: width * .04,
                          // fontWeight: FontWeight.w500,
                        ),
                        isExpanded: true,
                        underline: Container(),
                        value: _controller.selectedPaymentType,
                        items: List.generate(
                            _controller.paymentTypeList!.length, (index) {
                          return DropdownMenuItem<PaymentTypeInfo>(
                              child: Text(
                                _controller.paymentTypeList![index].value!,
                                style: poppinsRegular.copyWith(
                                  color: blackColor,
                                  fontSize: width * .04,
                                  //   fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: _controller.paymentTypeList![index]);
                        }),
                        onChanged: (value) {
                          _controller.setPaymentType(value);
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: height * .015, bottom: height * .01),
                      child: Text(
                        "Third Party Decleration",
                        style: GoogleFonts.poppins().copyWith(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlueColor,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(5.0),
                            onTap: () {
                              // setState(() {
                              //   check3 = !check3;
                              // });
                              _controller.setThirdParty();
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
                              child: _controller.thirdParty == true
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
                                "Check the box if the name on the credit/debit card is diffrent from your name.",
                                style: GoogleFonts.poppins().copyWith(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.w400,
                                  color: greyColor,
                                )),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        log("message" +
                            '${double.parse(widget.primaryOfferDataInfo.minimumInvestment.toString())}');
                        log("messaggfge" +
                            '${double.parse(_controller.investmentController.text.replaceAll(RegExp('[^0-9]'), ''))}');

                        double.parse(widget
                                        .primaryOfferDataInfo.minimumInvestment
                                        .toString()) <=
                                    double.parse(_controller
                                        .investmentController.text
                                        .replaceAll(RegExp('[^0-9]'), '')) &&
                                _controller
                                    .investmentController.text.isNotEmpty &&
                                _controller.thirdParty != false &&
                                _controller.selectedPaymentType != null
                            ? Get.dialog(
                                ConnsentDialog(
                                  primaryOfferDataInfo:
                                      widget.primaryOfferDataInfo,
                                ),
                              )
                            : null;

                        _controller.investmentController.text.isNotEmpty &&
                            _controller.thirdParty != false &&
                            _controller.selectedPaymentType != null;
                        if (_controller.investmentController.text.isNotEmpty &&
                            _controller.thirdParty != false &&
                            _controller.selectedPaymentType != null) {
                          if (double.parse(widget
                                  .primaryOfferDataInfo.minimumInvestment
                                  .toString()) <=
                              double.parse(_controller.investmentController.text
                                  .replaceAll(RegExp('[^0-9]'), ''))) {
                            Get.dialog(
                              ConnsentDialog(
                                primaryOfferDataInfo:
                                    widget.primaryOfferDataInfo,
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  "The entered value should be same or above of the Minimum Investment . Review your detail and try again.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: whiteColor,
                              textColor: greenColor,
                              fontSize: 15,
                            );
                          }
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please fill all the fields.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: whiteColor,
                            textColor: greenColor,
                            fontSize: 15,
                          );
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: height * .015, bottom: height * .015),
                        height: height * .05,
                        width: width * .9,
                        decoration: BoxDecoration(
                          color: _controller
                                      .investmentController.text.isNotEmpty &&
                                  _controller.thirdParty != false &&
                                  _controller.selectedPaymentType != null &&
                                  double.parse(widget.primaryOfferDataInfo
                                          .minimumInvestment
                                          .toString()) <=
                                      double.parse(_controller
                                          .investmentController.text
                                          .replaceAll(RegExp('[^0-9]'), ''))
                              ? greenColor
                              : grey1Color,
                          borderRadius: BorderRadius.all(
                            Radius.circular(width * .02),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Next",
                            style: poppinsRegular.copyWith(
                                color: whiteColor,
                                fontSize: width * .04,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
