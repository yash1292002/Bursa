import 'dart:developer';
import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:page_transition/page_transition.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../consts/color_const.dart';
import 'register_conformation.dart';

class RegisterUploadScreen extends StatefulWidget {
  RegisterUploadScreen({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterUploadScreen> createState() => _RegisterUploadScreenState();
}

class _RegisterUploadScreenState extends State<RegisterUploadScreen> {
  // String? upload;
  List<String> uploadStatus = [
    "My Dekstop",
    "Local disk:C",
    "Local disk:D",
  ];

  // bool isConsent = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return Container(
      // height: height * .7,
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
          top: height * .02,
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
                "Storage Location",
                style: poppinsRegular.copyWith(
                    color: lightBlueColor,
                    fontSize: width * .039,
                    fontWeight: FontWeight.w700),
              ),
              Container(
                margin: EdgeInsets.only(top: height * .008, right: width * .1),
                child: Text(
                  "Where do you want to upload the documents from ?",
                  style: poppinsRegular.copyWith(
                      color: greyColor,
                      fontSize: width * .033,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Container(
                height: height * .05,
                margin: EdgeInsets.only(
                  top: height * .01,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(
                    width * .01,
                  )),
                  border: Border.all(
                    width: width * .002,
                    color: greyColor,
                  ),
                ),
                padding: EdgeInsets.only(left: width * .02, right: width * .02),
                child: DropdownButton(
                  hint: Text(
                    "My Dekstop",
                    style: poppinsRegular.copyWith(
                      color: lightBlueColorWithopacity40,
                      fontSize: width * .04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: poppinsRegular.copyWith(
                    color: blackColor,
                    fontSize: width * .04,
                    fontWeight: FontWeight.w500,
                  ),
                  isExpanded: true,
                  underline: Container(),
                  value: _registerShareController.upload,
                  items: List.generate(
                    uploadStatus.length,
                    (index) {
                      return DropdownMenuItem(
                          child: Text(
                            uploadStatus[index],
                            style: poppinsRegular.copyWith(
                              color: blackColor,
                              fontSize: width * .04,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          value: uploadStatus[index]);
                    },
                  ),
                  onChanged: (value) {
                    // setState(() {
                    //   upload = value as String;
                    // });
                    _registerShareController.setUpload(value as String);
                    log(value);
                  },
                ),
              ),
              ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: height * .02),
                      height: height * .16,
                      width: width * .8,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * .02),
                          border: Border.all(width: .5, color: lightGreyColor)),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: width * .04),
                                child: Image.asset(
                                  upload_File[index]["img"],
                                  height: height * .1,
                                  width: width * .12,
                                  //color: whiteColor,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: width * .04, top: height * .025),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      upload_File[index]["title"],
                                      style: poppinsRegular.copyWith(
                                          color: lightBlueColor,
                                          fontSize: width * .035,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      upload_File[index]["sub_title"],
                                      style: poppinsRegular.copyWith(
                                          color: greyColor,
                                          fontSize: width * .03,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          index == 0
                              ? Container(
                                  margin: EdgeInsets.only(left: width * .024),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: width * .028,
                                            bottom: width * .008),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Scanning",
                                              style: poppinsRegular.copyWith(
                                                  color: lightBlueColor,
                                                  fontSize: width * .03),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right: width * .04),
                                                child: Text(
                                                  "100%",
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: lightBlueColor,
                                                          fontSize:
                                                              width * .03),
                                                )),
                                          ],
                                        ),
                                      ),
                                      LinearPercentIndicator(
                                        width: width * .73,
                                        animation: true,
                                        lineHeight: height * .008,
                                        animationDuration: 500,
                                        percent: 1,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        barRadius: Radius.circular(width * .04),
                                        progressColor: blueColor1,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: width * .024),
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            left: width * .028,
                                            bottom: width * .008),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Uploading",
                                              style: poppinsRegular.copyWith(
                                                  color: lightBlueColor,
                                                  fontSize: width * .03),
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    right: width * .04),
                                                child: Text(
                                                  "50%",
                                                  style:
                                                      poppinsRegular.copyWith(
                                                          color: lightBlueColor,
                                                          fontSize:
                                                              width * .03),
                                                )),
                                          ],
                                        ),
                                      ),
                                      LinearPercentIndicator(
                                        width: width * .73,
                                        animation: true,
                                        lineHeight: height * .01,
                                        animationDuration: 500,
                                        percent: .5,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        barRadius: Radius.circular(width * .04),
                                        progressColor: blueColor1,
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      height: height * .005,
                    );
                  },
                  itemCount: upload_File.length)
            ],
          ),
          GestureDetector(
            onTap: () {
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
                                        "Please ensure reading the terms and conditions before submitting your request. You can access the full terms and conditions on ",
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
                                onTap: () {
                                  widget.onTap;
                                  Navigator.pop(context);
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //   builder: (context) => ConfirmationScreen(),
                                  // ));
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      reverseDuration:
                                          const Duration(milliseconds: 300),
                                      type: PageTransitionType.rightToLeft,
                                      child: const ConfirmationScreen(),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: width * .1,
                                  decoration: BoxDecoration(
                                    color: greenColor,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(width * .02)),
                                  ),
                                  alignment: Alignment.center,
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
                                      Padding(
                                        padding:
                                            EdgeInsets.only(left: width * .02),
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
              (_registerShareController.upload != null) ? widget.onTap : null;
              print({
                _registerShareController.selectedConpanies.toString(),
                _registerShareController.comapnyNameController.text,
                _registerShareController.pdffile.toString(),
                _registerShareController.selectedGrantType.toString(),
                _registerShareController.selectedEquityRounds.toString(),
                _registerShareController.selectDebtsRounds.toString(),
                _registerShareController.numberofShareController.text,
                _registerShareController.dateOfEmploymentController.text,
                _registerShareController.rupeesController.text,
                _registerShareController.firstNameController.text,
                _registerShareController.lastNameController.text,
                _registerShareController.emailController.text,
                _registerShareController.countrycode.toString() +
                    _registerShareController.phoneNumberController.text,
                _registerShareController.upload.toString()
              });
              //  _registerShareController.registerShare();
            },
            child: Container(
              height: width * .11,
              width: width * .78,
              margin: EdgeInsets.only(top: height * .015, bottom: height * .03),
              decoration: BoxDecoration(
                color: (_registerShareController.upload != null)
                    ? greenColor
                    : grey1Color,
                borderRadius: BorderRadius.all(Radius.circular(width * .02)),
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
                  Padding(
                    padding: EdgeInsets.only(left: width * .02),
                    child: Icon(
                      Icons.arrow_right_alt,
                      color: whiteColor,
                      size: width * .08,
                    ),
                  )
                ],
              ),
            ),
          )
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
