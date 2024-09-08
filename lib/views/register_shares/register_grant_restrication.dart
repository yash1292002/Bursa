import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';

import '../../consts/color_const.dart';
import '../../widgets/custom_next_button.dart';
import 'dart:io' as io;

class RegisterGrantRestrication extends StatefulWidget {
  RegisterGrantRestrication({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterGrantRestrication> createState() =>
      _RegisterGrantRestricationState();
}

class _RegisterGrantRestricationState extends State<RegisterGrantRestrication> {
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
          focusNode: _nodeText1,
        ),
        KeyboardActionsItem(
          focusNode: _nodeText2,
        ),
        KeyboardActionsItem(
          focusNode: _nodeText3,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return KeyboardActions(
      config: _buildConfig(context),
      child: Container(
        margin: EdgeInsets.only(bottom: width * .03, top: width * .02),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // margin: EdgeInsets.only(left: width*.0),
                width: width * .9,
                // height: height * .32,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      width * .03,
                    ),
                  ),
                ),
                child: Column(
                  //  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          left: width * .03,
                          top: width * .04,
                          right: width * .04),
                      child: Center(
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  "What is the value of your investment in this company ? ",
                              style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w800),
                            ),
                            TextSpan(
                              text: "*",
                              style: poppinsRegular.copyWith(
                                  color: redColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w800),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Container(
                      // height: height * .07,
                      width: width * .8,
                      margin: EdgeInsets.only(
                          top: height * .015,
                          left: width * .04,
                          right: width * .04),
                      decoration: BoxDecoration(
                          color: lightGreyColor1,
                          borderRadius: BorderRadius.circular(width * .04)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          io.Platform.isAndroid
                              ? TextFormField(
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    color: lightBlueColor,
                                    fontSize: width * .045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  // focusNode: _nodeText1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter()
                                  ],
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      _registerShareController.rupeesController,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    suffixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .015),
                                      child: Text(
                                        "USD",
                                        style: poppinsRegular.copyWith(
                                            color: greenColor),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: redColor,
                                      ),
                                    ),
                                    hintStyle: poppinsRegular.copyWith(
                                      color: lightBlueColorWithopacity40,
                                      fontSize: width * .045,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              : TextFormField(
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    color: lightBlueColor,
                                    fontSize: width * .045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  focusNode: _nodeText3,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter()
                                  ],
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      _registerShareController.rupeesController,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    suffixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .015),
                                      child: Text(
                                        "USD",
                                        style: poppinsRegular.copyWith(
                                            color: greenColor),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    hintStyle: poppinsRegular.copyWith(
                                      color: lightBlueColorWithopacity40,
                                      fontSize: width * .045,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * .03,
                          top: width * .04,
                          right: width * .04),
                      child: Center(
                        child: Text(
                          "At What valuation you were granted these shares?",
                          textAlign: TextAlign.center,
                          style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .038,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Container(
                      // height: height * .07,
                      width: width * .8,
                      margin: EdgeInsets.only(
                          top: height * .015,
                          left: width * .04,
                          right: width * .04),
                      decoration: BoxDecoration(
                          color: lightGreyColor1,
                          borderRadius: BorderRadius.circular(width * .04)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          io.Platform.isAndroid
                              ? TextFormField(
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    color: lightBlueColor,
                                    fontSize: width * .045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  // focusNode: _nodeText1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter()
                                  ],
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      _registerShareController.grantValuation,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    suffixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .015),
                                      child: Text(
                                        "USD",
                                        style: poppinsRegular.copyWith(
                                            color: greenColor),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: redColor,
                                      ),
                                    ),
                                    hintStyle: poppinsRegular.copyWith(
                                      color: lightBlueColorWithopacity40,
                                      fontSize: width * .045,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              : TextFormField(
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    color: lightBlueColor,
                                    fontSize: width * .045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  focusNode: _nodeText1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter()
                                  ],
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      _registerShareController.grantValuation,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    suffixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .015),
                                      child: Text(
                                        "USD",
                                        style: poppinsRegular.copyWith(
                                            color: greenColor),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: redColor,
                                      ),
                                    ),
                                    hintStyle: poppinsRegular.copyWith(
                                      color: lightBlueColorWithopacity40,
                                      fontSize: width * .045,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: width * .03,
                          top: width * .04,
                          right: width * .04),
                      child: Center(
                        child: Text(
                          "what was the last valuation of this company",
                          textAlign: TextAlign.center,
                          style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .038,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                    Container(
                      // height: height * .07,
                      width: width * .8,
                      margin: EdgeInsets.only(
                          top: height * .015,
                          bottom: height * .02,
                          left: width * .04,
                          right: width * .04),
                      decoration: BoxDecoration(
                          color: lightGreyColor1,
                          borderRadius: BorderRadius.circular(width * .04)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          io.Platform.isAndroid
                              ? TextFormField(
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    color: lightBlueColor,
                                    fontSize: width * .045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  // focusNode: _nodeText1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter()
                                  ],
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      _registerShareController.lastValuation,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    suffixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .015),
                                      child: Text(
                                        "USD",
                                        style: poppinsRegular.copyWith(
                                            color: greenColor),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: redColor,
                                      ),
                                    ),
                                    hintStyle: poppinsRegular.copyWith(
                                      color: lightBlueColorWithopacity40,
                                      fontSize: width * .045,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                )
                              : TextFormField(
                                  textAlign: TextAlign.center,
                                  style: poppinsRegular.copyWith(
                                    color: lightBlueColor,
                                    fontSize: width * .045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  focusNode: _nodeText2,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter()
                                  ],
                                  textInputAction: TextInputAction.done,
                                  controller:
                                      _registerShareController.lastValuation,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    hintText: "",
                                    suffixIcon: Padding(
                                      padding:
                                          EdgeInsets.only(top: height * .015),
                                      child: Text(
                                        "USD",
                                        style: poppinsRegular.copyWith(
                                            color: greenColor),
                                      ),
                                    ),
                                    border: InputBorder.none,
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: redColor,
                                      ),
                                    ),
                                    hintStyle: poppinsRegular.copyWith(
                                      color: lightBlueColorWithopacity40,
                                      fontSize: width * .045,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .015),
                //height: height * .42,
                width: width,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      width * .03,
                    ),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: width * .05,
                          left: width * .06,
                          right: width * .06,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Restrictions",
                                  style: poppinsRegular.copyWith(
                                      fontSize: width * .038,
                                      color: lightBlueColor,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * .01, bottom: height * .02),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "To the best of your knwledge, are there any sale or transfer restrictions related to these shares ?",
                                      style: poppinsRegular.copyWith(
                                        fontSize: width * .033,
                                        color: greyColor2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: width * .03, right: 0),
                                    child: FlutterSwitch(
                                      width: width * .12,
                                      height: width * .06,
                                      toggleSize: width * .04,
                                      value: _registerShareController
                                          .isRestrication,
                                      toggleColor: greenColor,
                                      borderRadius: width * .03,
                                      activeColor: greenColorWithOpacity20,
                                      activeText: "Yes",
                                      valueFontSize: 10.0,
                                      showOnOff: true,
                                      activeTextColor: blackColor,
                                      inactiveColor: lightGreyColor,
                                      inactiveText: "No",
                                      inactiveTextColor: blackColor,
                                      padding: width * .006,
                                      onToggle: (val) {
                                        // setState(() {
                                        //   isConsent = val;
                                        // });
                                        _registerShareController
                                            .setIsConsent(val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: lightGreyColorWithOpacity50,
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: height * .02, bottom: height * .02),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Are you a cofounder or employee at the company ?",
                                      style: poppinsRegular.copyWith(
                                        fontSize: width * .033,
                                        color: greyColor2,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        left: width * .03, right: 0),
                                    child: FlutterSwitch(
                                      width: width * .12,
                                      height: width * .06,
                                      toggleSize: width * .04,
                                      value: _registerShareController
                                          .isRestrication1,
                                      toggleColor: greenColor,
                                      borderRadius: width * .03,
                                      activeColor: greenColorWithOpacity20,
                                      activeText: "Yes",
                                      valueFontSize: 10.0,
                                      showOnOff: true,
                                      activeTextColor: blackColor,
                                      inactiveColor: lightGreyColor,
                                      inactiveText: "No",
                                      inactiveTextColor: blackColor,
                                      padding: width * .006,
                                      onToggle: (val) {
                                        // setState(() {
                                        //   isConsent1 = val;
                                        // });
                                        _registerShareController
                                            .setIsConsent1(val);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomNextButton(
                        // onTap: (_registerShareController
                        //         .rupeesController.text.isNotEmpty
                        //         )
                        //     ? widget.onTap
                        //     : null,
                        onTap: (_registerShareController
                                .rupeesController.text.isNotEmpty
                            ? () {
                                widget.onTap();

                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            : null),

                        // btnColor: (_registerShareController
                        //         .rupeesController.text.isNotEmpty)
                        //     ? greenColor
                        //     : grey1Color,
                        btnColor: _registerShareController
                                .rupeesController.text.isEmpty
                            ? grey1Color
                            : greenColor,
                        text: "Next",
                        marginTop: height * .1,
                        marginBottom: height * .035,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
