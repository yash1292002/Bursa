import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KycDetailScreen extends StatefulWidget {
  KycDetailScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;

  @override
  State<KycDetailScreen> createState() => _KycDetailScreenState();
}

class _KycDetailScreenState extends State<KycDetailScreen> {
  // List<String?> kycAnswers = [];

  @override
  void initState() {
    super.initState();
    AuthController _authController =
        Provider.of<AuthController>(context, listen: false);
    Future.delayed(const Duration(microseconds: 10), () {
      check(_authController);
    });
  }

  bool isDone = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthController _authContorller =
        Provider.of<AuthController>(context, listen: true);
    return Container(
      margin: EdgeInsets.only(
        top: height * .01,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.all(
          Radius.circular(
            width * .02,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        top: height * .02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: height * .58,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: width * .05, right: width * .05),
                        child: Text(
                          kycQuestions[index],
                          style: poppinsRegular.copyWith(
                            fontSize: width * .035,
                            color: lightBlueColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: width * .02,
                          left: width * .15,
                          right: width * .15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _authContorller.kycAnswers[index] = "Yes";
                                });
                                check(_authContorller);
                              },
                              child: Container(
                                width: width * .28,
                                padding: EdgeInsets.only(
                                    left: width * .02,
                                    right: width * .02,
                                    top: width * .015,
                                    bottom: width * .015),
                                decoration: BoxDecoration(
                                    color: _authContorller.kycAnswers[index] ==
                                                null ||
                                            _authContorller.kycAnswers[index] !=
                                                "Yes"
                                        ? whiteColor
                                        : darkblue1,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * .04,
                                      ),
                                    ),
                                    border: Border.all(
                                      color:
                                          _authContorller.kycAnswers[index] ==
                                                      null ||
                                                  _authContorller
                                                          .kycAnswers[index] !=
                                                      "Yes"
                                              ? lightBlueColorWithopacity30
                                              : transparentColor,
                                    )),
                                alignment: Alignment.center,
                                child: Text(
                                  "Yes",
                                  style: poppinsRegular.copyWith(
                                      color:
                                          _authContorller.kycAnswers[index] ==
                                                      null ||
                                                  _authContorller
                                                          .kycAnswers[index] !=
                                                      "Yes"
                                              ? lightBlueColor
                                              : whiteColor,
                                      fontSize: width * .03),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _authContorller.kycAnswers[index] = "No";
                                });
                                check(_authContorller);
                              },
                              child: Container(
                                width: width * .28,
                                padding: EdgeInsets.only(
                                    left: width * .02,
                                    right: width * .02,
                                    top: width * .015,
                                    bottom: width * .015),
                                decoration: BoxDecoration(
                                    color: _authContorller.kycAnswers[index] ==
                                                null ||
                                            _authContorller.kycAnswers[index] !=
                                                "No"
                                        ? whiteColor
                                        : darkblue1,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        width * .04,
                                      ),
                                    ),
                                    border: Border.all(
                                      color:
                                          _authContorller.kycAnswers[index] ==
                                                      null ||
                                                  _authContorller
                                                          .kycAnswers[index] !=
                                                      "No"
                                              ? lightBlueColorWithopacity30
                                              : transparentColor,
                                    )),
                                alignment: Alignment.center,
                                child: Text(
                                  "No",
                                  style: poppinsRegular.copyWith(
                                      color:
                                          _authContorller.kycAnswers[index] ==
                                                      null ||
                                                  _authContorller
                                                          .kycAnswers[index] !=
                                                      "No"
                                              ? lightBlueColor
                                              : whiteColor,
                                      fontSize: width * .03),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: height * .03,
                  );
                },
                itemCount: kycQuestions.length),
          ),
          GestureDetector(
            onTap: () {
              _authContorller.kycAnswers.forEach((element) {
                if (element == null) {
                  isDone = false;
                }
              });
              (isDone) ? widget.ontap() : null;
            },
            child: Container(
              height: width * .11,
              margin: EdgeInsets.only(
                  // top: height * .01,
                  bottom: height * .03,
                  left: width * .05,
                  right: width * .05),
              decoration: BoxDecoration(
                color: (isDone) ? greenColor : grey1Color,
                borderRadius: BorderRadius.all(Radius.circular(width * .02)),
              ),
              alignment: Alignment.center,
              child: Text(
                "Next",
                style: poppinsRegular.copyWith(
                  color: whiteColor,
                  fontSize: width * .036,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void check(AuthController _authController) {
    setState(() {
      isDone = true;
    });
    _authController.kycAnswers.forEach(((element) {
      if (element == null) {
        setState(() {
          isDone = false;
        });
      }
    }));
  }
}
