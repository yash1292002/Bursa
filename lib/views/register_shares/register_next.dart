import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/views/home_screen/issue_digital_certificate/register_certificate/register_certificate_screen.dart';
import 'package:bursa_flutter/views/register_shares/ragester_share.dart';

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../consts/color_const.dart';
import 'register_shar_cupon.dart';

class RegisterNext extends StatefulWidget {
  RegisterNext({
    Key? key,
    this.isCertificate,
  }) : super(key: key);
  bool? isCertificate;

  @override
  State<RegisterNext> createState() => _RegisterNextState();
}

class _RegisterNextState extends State<RegisterNext> {
  bool _registernext = false;

  void setRegister(bool value) {
    _registernext = value;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    AuthController _controller =
        Provider.of<AuthController>(context, listen: true);
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            blueColor,
            greenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: _registernext
            ? const RegisterSharInfo()
            : Container(
                margin: EdgeInsets.only(
                    left: width * .04, right: width * .0, top: height * .06),
                child: Column(
///////////////
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/icons/back_button.png",
                            height: height * .06,
                            width: width * .1,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: widget.isCertificate!
                                  ? width * .11
                                  : width * .18),
                          child: Text(
                            widget.isCertificate!
                                ? "Issue Digital Certificates"
                                : "Register Shares",
                            style: poppinsRegular.copyWith(
                                color: white1,
                                fontWeight: FontWeight.w500,
                                fontSize: width * .048,
                                letterSpacing: .05),
                          ),
                        ),
                      ],
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: height * .09,
                                left: width * .02,
                                right: width * .04),
                            // height: height * .6,
                            width: width * .88,
                            decoration: BoxDecoration(
                              color: whiteColor,
                              borderRadius: BorderRadius.circular(width * .04),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: height * .1),
                                  child: Center(
                                      child: Image.asset(
                                    "assets/icons/register.png",
                                    height: height * .16,
                                    width: width * .4,
                                  )),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      top: width * .1,
                                      left: width * .08,
                                      right: width * .08),
                                  child: Text(
                                    widget.isCertificate!
                                        ? "You don't have any digital certificate now"
                                        : "You don’t have any registered shares",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor,
                                        fontSize: width * .04,
                                        fontWeight: FontWeight.w600),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: widget.isCertificate!
                                      ? () {
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
                                                  const RegisterCertificateScreen(),
                                            ),
                                          );
                                        }
                                      : () {
                                          // setRegister(true);
                                          _controller.userDetail!
                                                      .verificationState ==
                                                  "Pending"
                                              ? showDialog(
                                                  context: context,
                                                  barrierColor:
                                                      darkGreyColorWithOpacity80,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      width *
                                                                          .02))),
                                                      content: StatefulBuilder(
                                                          builder: (context,
                                                              setState) {
                                                        return Container(
                                                          height: width * .9,
                                                          width: width * .7,
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: width * .02,
                                                            bottom: width * .03,
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Image.asset(
                                                                "assets/icons/failed.png",
                                                                height: height *
                                                                    .14,
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        top: height *
                                                                            .01),
                                                                child: Text(
                                                                  "Your account verification is under process.\nTry again later.",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: poppinsRegular.copyWith(
                                                                      color:
                                                                          lightBlueColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          width *
                                                                              .05),
                                                                ),
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  Navigator.pushAndRemoveUntil(
                                                                      context,
                                                                      PageTransition(
                                                                        duration:
                                                                            const Duration(milliseconds: 300),
                                                                        reverseDuration:
                                                                            const Duration(milliseconds: 300),
                                                                        type: PageTransitionType
                                                                            .rightToLeft,
                                                                        child:
                                                                            const HomeScreen(),
                                                                      ),
                                                                      (route) => false);
                                                                },
                                                                child:
                                                                    Container(
                                                                  margin: EdgeInsets.only(
                                                                      top: height *
                                                                          .09),
                                                                  height:
                                                                      height *
                                                                          .055,
                                                                  width: width *
                                                                      .7,
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          greenColor1,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8)),
                                                                  child: Column(
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                width * .02),
                                                                        child:
                                                                            Text(
                                                                          "Back",
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                          style: poppinsRegular.copyWith(
                                                                              color: whiteColor,
                                                                              fontSize: width * .045,
                                                                              fontWeight: FontWeight.w600),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  })
                                              : Navigator.push(
                                                  context,
                                                  PageTransition(
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    reverseDuration:
                                                        const Duration(
                                                            milliseconds: 300),
                                                    type: PageTransitionType
                                                        .rightToLeft,
                                                    child: const RagisterShar(),
                                                  ),
                                                );
                                        },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        top: height * .14,
                                        left: width * .04,
                                        right: width * .04,
                                        bottom: height * .04),
                                    height: height * .07,
                                    width: width * .76,
                                    decoration: BoxDecoration(
                                        color: greenColor,
                                        borderRadius:
                                            BorderRadius.circular(width * .02)),
                                    child: Center(
                                        child: Text(
                                      widget.isCertificate!
                                          ? "Register your digital certificate"
                                          : "Register Share",
                                      style: poppinsRegular.copyWith(
                                          color: whiteColor,
                                          fontSize: width * .04,
                                          letterSpacing: 1),
                                    )),
                                  ),
                                )
                              ],
                            ),
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
}
