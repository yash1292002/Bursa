import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/models/employement_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EducationDetailScreen extends StatefulWidget {
  EducationDetailScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;

  @override
  State<EducationDetailScreen> createState() => _EducationDetailScreenState();
}

class _EducationDetailScreenState extends State<EducationDetailScreen> {
  // String? employement;
  // List<String> employmentStatus = [
  //   "Full Time",
  //   "Part Time",
  //   "Contract",
  //   "Internship",
  //   "Freelance",
  // ];

  //List<String?> educationAnswers = [];
  // bool isLoading = true;

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
    AuthController _authController =
        Provider.of<AuthController>(context, listen: true);
    return Column(
      children: [
        Container(
          // height: 50,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.all(
              Radius.circular(
                width * .02,
              ),
            ),
          ),

          child: Container(
            height: height * .05,
            margin: EdgeInsets.only(
                top: height * .025,
                bottom: height * .025,
                left: width * .05,
                right: width * .05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(
                width * .01,
              )),
              border: Border.all(
                width: width * .002,
                color: lightBlueColorWithopacity30,
              ),
            ),
            padding: EdgeInsets.only(left: width * .02, right: width * .02),
            child: IgnorePointer(
              ignoring: true,
              child: DropdownButton<EmployementInfo>(
                hint: Text(
                  "Employement",
                  style: poppinsRegular.copyWith(
                    color: lightBlueColorWithopacity40,
                    fontSize: width * .04,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                style: poppinsRegular.copyWith(
                  color: lightBlueColor,
                  fontSize: width * .04,
                  fontWeight: FontWeight.w500,
                ),
                isExpanded: true,
                underline: Container(),
                value: _authController.selectedEmployement,
                items: List.generate(
                    _authController.employementInfoList!.length, (index) {
                  return DropdownMenuItem<EmployementInfo>(
                      child: Text(
                        _authController.employementInfoList![index].name!,
                        style: poppinsRegular.copyWith(
                          color: lightBlueColor,
                          fontSize: width * .04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: _authController.employementInfoList![index]);
                }),
                onChanged: (value) {
                  setState(() {
                    _authController.setEmployement(value);
                  });
                },
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
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
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: width * .05, right: width * .05),
                            child: Text(
                              educationQuestion[index],
                              style: poppinsRegular.copyWith(
                                fontSize: width * .035,
                                color: darkBlueColor,
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
                                      _authController.educationAnswers[index] =
                                          "Yes";
                                    });
                                    check(_authController);
                                  },
                                  child: Container(
                                    width: width * .28,
                                    padding: EdgeInsets.only(
                                        left: width * .02,
                                        right: width * .02,
                                        top: width * .015,
                                        bottom: width * .015),
                                    decoration: BoxDecoration(
                                        color: _authController.educationAnswers[
                                                        index] ==
                                                    null ||
                                                _authController
                                                            .educationAnswers[
                                                        index] !=
                                                    "Yes"
                                            ? whiteColor
                                            : darkblue1,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            width * .04,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: _authController
                                                              .educationAnswers[
                                                          index] ==
                                                      null ||
                                                  _authController
                                                              .educationAnswers[
                                                          index] !=
                                                      "Yes"
                                              ? lightBlueColorWithopacity30
                                              : transparentColor,
                                        )),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Yes",
                                      style: poppinsRegular.copyWith(
                                          color: _authController
                                                              .educationAnswers[
                                                          index] ==
                                                      null ||
                                                  _authController
                                                              .educationAnswers[
                                                          index] !=
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
                                      _authController.educationAnswers[index] =
                                          "No";
                                    });
                                    check(_authController);
                                  },
                                  child: Container(
                                    width: width * .28,
                                    padding: EdgeInsets.only(
                                        left: width * .02,
                                        right: width * .02,
                                        top: width * .015,
                                        bottom: width * .015),
                                    decoration: BoxDecoration(
                                        color: _authController.educationAnswers[
                                                        index] ==
                                                    null ||
                                                _authController
                                                            .educationAnswers[
                                                        index] !=
                                                    "No"
                                            ? whiteColor
                                            : darkblue1,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(
                                            width * .04,
                                          ),
                                        ),
                                        border: Border.all(
                                          color: _authController
                                                              .educationAnswers[
                                                          index] ==
                                                      null ||
                                                  _authController
                                                              .educationAnswers[
                                                          index] !=
                                                      "No"
                                              ? lightBlueColorWithopacity30
                                              : transparentColor,
                                        )),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "No",
                                      style: poppinsRegular.copyWith(
                                          color: _authController
                                                              .educationAnswers[
                                                          index] ==
                                                      null ||
                                                  _authController
                                                              .educationAnswers[
                                                          index] !=
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
                    itemCount: educationQuestion.length),
                GestureDetector(
                  onTap: () {
                    // check value selectd or not
                    (_authController.selectedEmployement != null && isDone)
                        ? widget.ontap()
                        : () {};
                  },
                  child: Container(
                    height: width * .11,
                    margin: EdgeInsets.only(
                        // top: height * .01,
                        bottom: height * .03,
                        left: width * .05,
                        right: width * .05),
                    decoration: BoxDecoration(
                      color: (_authController.selectedEmployement != null &&
                              isDone)
                          ? greenColor
                          : grey1Color,
                      borderRadius:
                          BorderRadius.all(Radius.circular(width * .02)),
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
          ),
        ),
      ],
    );
  }

  void check(AuthController _authController) {
    setState(() {
      isDone = true;
    });
    _authController.educationAnswers.forEach(((element) {
      if (element == null) {
        setState(() {
          isDone = false;
        });
      }
    }));
  }
}
