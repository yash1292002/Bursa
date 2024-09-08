import 'dart:developer';
import 'dart:io';

import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:bursa_flutter/views/register_shares/register_conformation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../consts/color_const.dart';
import '../../widgets/custom_next_button.dart';
import '../../widgets/file_picker_button.dart';
import '../../widgets/loading_progress_widget.dart';

class RegisterUploadDoc extends StatefulWidget {
  RegisterUploadDoc({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterUploadDoc> createState() => _RegisterUploadDocState();
}

class _RegisterUploadDocState extends State<RegisterUploadDoc> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return Container(
      margin: EdgeInsets.only(bottom: width * .03, top: width * .02),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            width * .03,
          ),
        ),
      ),
      padding: EdgeInsets.only(
          top: height * .04,
          // bottom: height * .03,
          left: width * .06,
          right: width * .06),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "The below documents are needed to verify ownership, review any restrictions on the granted shares, and know the issuer. ",
                style: poppinsRegular.copyWith(
                    color: greyColor,
                    fontSize: width * .033,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .02),
                child: Text(
                  "Share Ownership Documentation",
                  style: poppinsRegular.copyWith(
                      color: lightBlueColor,
                      fontSize: width * .036,
                      fontWeight: FontWeight.w600),
                ),
              ),
              FilePickerButton(
                isFileAdded: _registerShareController.padf1File != null,
                fileAddedText: _registerShareController.padf1File != null
                    ? _registerShareController.padf1File!.path.split("/").last
                    : "",
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc'],
                  );
                  if (result != null) {
                    final path = result.files.single.path!;
                    // setState(() {
                    //   pdffile = File(path);
                    // });
                    _registerShareController.setPdf1File(File(path));
                  }
                  log(_registerShareController.padf1File.toString());
                },
                description:
                    "Shareholder agreement (i.e SAFE, Notes, Certificates, etc..)",
              ),
              Container(
                margin: EdgeInsets.only(top: height * .02),
                child: Text(
                  "Company Information",
                  style: poppinsRegular.copyWith(
                      color: lightBlueColor,
                      fontSize: width * .035,
                      fontWeight: FontWeight.w600),
                ),
              ),
              FilePickerButton(
                isFileAdded: _registerShareController.photofile != null,
                fileAddedText: _registerShareController.photofile != null
                    ? _registerShareController.photofile!.path.split("/").last
                    : "",
                onTap: () async {
                  final result1 = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['pdf', 'doc'],
                  );
                  if (result1 != null) {
                    final path = result1.files.single.path!;
                    // setState(() {
                    //   photofile = File(path);
                    // });
                    _registerShareController.setPhotoFile(File(path));
                  }
                  log(_registerShareController.photofile.toString());
                },
                description:
                    "Investor Presentation, Financial Performance, Trade License, etc...",
              ),
            ],
          ),
          CustomNextButton(
            onTap: () {
              // (_registerShareController.photofile != null &&
              //         _registerShareController.padf1File != null)
              showDialog(
                  context: context,
                  barrierColor: darkGreyColorWithOpacity80,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(width * .02))),
                      content: StatefulBuilder(builder: (context, setState) {
                        return Container(
                          height: width * .9,
                          margin: EdgeInsets.only(
                            top: width * .03,
                            bottom: width * .03,
                          ),
                          child: Column(
                            children: [
                              Text(
                                "One last step before submiting your request.",
                                style: poppinsRegular.copyWith(
                                  fontSize: width * .04,
                                  color: darkBlueColor2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: width * .03, bottom: width * .03),
                                child: RichText(
                                  // textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        "Please ensure reading the terms and conditions before submitting your request. You can access the full terms and conditions at ",
                                    style: poppinsRegular.copyWith(
                                      fontSize: width * .028,
                                      fontWeight: FontWeight.w500,
                                      color: greyColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        termcondition();
                                      },
                                    children: [
                                      TextSpan(
                                          text:
                                              "www.wearebursa.com/termsandconditions",
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              termcondition();
                                            },
                                          style: poppinsRegular.copyWith(
                                            fontSize: width * .028,
                                            color: blueColor2,
                                            fontWeight: FontWeight.w500,
                                          ))
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: blackColorWithOpacity50,
                                    width: width * .0005,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(
                                      width * .02,
                                    ),
                                  ),
                                ),
                                padding: EdgeInsets.only(
                                  left: width * .06,
                                  right: width * .06,
                                  top: height * .02,
                                  bottom: height * .015,
                                ),
                                margin: EdgeInsets.only(
                                  top: width * .08,
                                  bottom: width * .1,
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Consent",
                                          style: poppinsRegular.copyWith(
                                            fontSize: width * .04,
                                            color: darkBlueColor2,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: width * .03, right: 0),
                                          child: FlutterSwitch(
                                            width: width * .1,
                                            height: width * .05,
                                            toggleSize: width * .04,
                                            value: _registerShareController
                                                .clickOn,
                                            toggleColor: greenColor,
                                            borderRadius: width * .03,
                                            activeColor:
                                                greenColorWithOpacity20,
                                            inactiveColor:
                                                blackColorWithOpacity20,
                                            padding: width * .006,
                                            onToggle: (val) {
                                              setState(() {
                                                _registerShareController
                                                    .setClickOn(val);
                                              });
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: height * .01,
                                      ),
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              "You agree and abide by Bursa’s ",
                                          style: poppinsRegular.copyWith(
                                            fontSize: width * .028,
                                            color: greyColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              termcondition();
                                            },
                                          children: [
                                            TextSpan(
                                              text: "Terms and Conditions",
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  termcondition();
                                                },
                                              style: poppinsRegular.copyWith(
                                                fontSize: width * .028,
                                                color: blueColor2,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: _registerShareController.clickOn == false
                                    ? null
                                    : () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await _registerShareController
                                            .registerNewShare()
                                            .then((value) {
                                          if (value) {
                                            widget.onTap;
                                            Navigator.pop(context);
                                            // Navigator.of(context).push(MaterialPageRoute(
                                            //   builder: (context) => ConfirmationScreen(),
                                            // ));
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                reverseDuration: const Duration(
                                                    milliseconds: 300),
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child:
                                                    const ConfirmationScreen(),
                                              ),
                                            );
                                          }

                                          setState(() {
                                            isLoading = false;
                                          });
                                        });
                                      },
                                child: Container(
                                  height: width * .1,
                                  decoration: BoxDecoration(
                                    color: _registerShareController.clickOn ==
                                            false
                                        ? grey1Color
                                        : greenColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(width * .02)),
                                  ),
                                  alignment: Alignment.center,
                                  child: isLoading
                                      ? Consumer<RegisterShareController>(
                                          builder: (_, a, child) {
                                            return Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  "Sending your request: ${a.fileUploadProgress}/100",
                                                  style:
                                                      poppinsRegular.copyWith(
                                                    color: whiteColor,
                                                    fontSize: width * .027,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 1,
                                                  ),
                                                ),
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  margin:
                                                      const EdgeInsets.all(5.0),
                                                  child:
                                                      const CircularProgressIndicator(
                                                    strokeWidth: 1,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          child: const LoadingProgressWidget(),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * .02),
                                              child: Icon(
                                                Icons.arrow_right_alt,
                                                color: whiteColor,
                                                size: width * .08,
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    );
                  });
            },
            // btnColor: (_registerShareController.photofile != null &&
            //         _registerShareController.padf1File != null)
            //     ? greenColor
            //     : grey1Color,
            btnColor: greenColor,
            text: "Next",
            marginBottom: height * .03,
            marginTop: height * .0,
          ),
        ],
      ),
    );
  }

  /// this is use for term and condition
  void termcondition() {
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
