import 'dart:developer';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';
import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import '../../widgets/custom_next_button.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'dart:io' as io;

class RegisterShareDate extends StatefulWidget {
  RegisterShareDate({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterShareDate> createState() => _RegisterShareDateState();
}

class _RegisterShareDateState extends State<RegisterShareDate> {
  DateTime selectedDate = DateTime.now();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
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
      ],
    );
  }

  var maskFormatter = MaskTextInputFormatter(mask: '##/##/####');
  var regExp = RegExp(r'!/^\d{1,2}\/\d{1,2}\/\d{4}$/');

  bool isValid = true;
  // bool isValidDate(dateString) {
  //   print("dateString===" + dateString);
  //   // First check for the pattern
  //   if (regExp.hasMatch(dateString)) return false;
  //   // DateFormat("dd/MM/yyyy").parseStrict(dateString);
  //   // Parse the date parts to integers
  //   var parts = dateString.split("/");
  //   var day = int.parse(parts[1], radix: 10);
  //   var month = int.parse(parts[0], radix: 10);
  //   var year = int.parse(parts[2], radix: 10);
  //   DateTime year1 = DateTime.now();

  //   // Check the ranges of month and year
  //   if (year < 1000 ||
  //       year > 2500 ||
  //       month == 0 ||
  //       month > 12 ||
  //       year1.year < year) {
  //     log("message");

  //     return false;
  //   }

  //   var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

  //   // Adjust for leap years
  //   if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
  //     monthLength[1] = 29;

  //   // Check the range of the day
  //   return day > 0 && day <= monthLength[month - 1];
  // }

  bool isValidDate(dateString) {
    print("dateString===" + dateString);
    // First check for the pattern
    if (regExp.hasMatch(dateString)) return false;
    // DateFormat("dd/MM/yyyy").parseStrict(dateString);
    // Parse the date parts to integers
    var parts = dateString.split("/");
    var day = int.parse(parts[1], radix: 10);
    var month = int.parse(parts[0], radix: 10);
    var year = int.parse(parts[2], radix: 10);
    DateTime year1 = DateTime.now();

    // Check the ranges of month and year
    if (year < 1000 ||
        year > 2500 ||
        month == 0 ||
        month > 12 ||
        year1.year < year) {
      log("message");

      return false;
    }

    var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Adjust for leap years
    if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
      monthLength[1] = 29;

    // Check the range of the day
    return day > 0 && day <= monthLength[month - 1];
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
                width: width * .86,
                height: height * .19,
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
                          left: width * .2,
                          top: width * .04,
                          right: width * .15),
                      child: Center(
                        child: Text(
                          "How many shares were granted to you ?",
                          style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .04,
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          (io.Platform.isAndroid)
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
                                  controller: _registerShareController
                                      .numberofShareController,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    // hintText: "10,000",
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
                                  controller: _registerShareController
                                      .numberofShareController,
                                  cursorColor: lightBlueColor,
                                  decoration: InputDecoration(
                                    // hintText: ",
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
                margin: EdgeInsets.only(
                    top: height * .015, left: width * .02, right: width * .02),
                // height: height * .42,
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
                          top: height * .04,
                          left: width * .1,
                          right: width * .1,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "When were these shares granted to you ?",
                              style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .045,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: height * .07,
                        width: width * .8,
                        margin: EdgeInsets.only(
                            top: height * .06,
                            left: width * .04,
                            right: width * .04),
                        decoration: BoxDecoration(
                            color: lightGreyColor1,
                            borderRadius: BorderRadius.circular(width * .04)),
                        child: Container(
                          margin: EdgeInsets.only(
                              top: width * .02,
                              left: width * .04,
                              bottom: width * .01),
                          // color: redColor,
                          child: Padding(
                            padding: EdgeInsets.only(left: width * .01),
                            child: TextFormField(
                              style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .04,
                                fontWeight: FontWeight.w500,
                              ),
                              focusNode: _nodeText2,
                              // enabled: false,
                              controller: _registerShareController
                                  .dateOfEmploymentController,
                              inputFormatters: [maskFormatter],
                              // validator: (val) {
                              //   // var date = ["MM", "dd", "yyyy"];
                              //   // print(val);
                              //   // print(val.split("/"));
                              //   // if (val.split("/").length == 3) {
                              //   //   date[0] = val.split("/")[1];
                              //   //   date[1] = val.split("/")[0];
                              //   //   date[2] = val.split("/")[2];
                              //   //   print("date====" + date.join("/"));
                              //   //   var datetime = date.join("/");
                              //   //   var day = isValidDate(datetime);
                              //   //   print(day);
                              //   // } else {}
                              //   if (isValidDate(val)) {
                              //     return "Enter valid date";
                              //   } else {
                              //     return "Invalid Date";
                              //   }
                              // },

                              keyboardType: TextInputType.number,
                              onChanged: (val) {
                                var date = ["MM", "dd", "yyyy"];
                                log(val);
                                log(val.split("/").toString());
                                if (val.split("/").length == 3) {
                                  date[0] = val.split("/")[1];
                                  date[1] = val.split("/")[0];
                                  date[2] = val.split("/")[2];
                                  print("date====" + date.join("/"));
                                  var datetime = date.join("/");
                                  isValid = isValidDate(datetime);
                                  log(isValid.toString());
                                } else {}
                              },
                              decoration: const InputDecoration(
                                  // fillColor: whiteColor,
                                  // filled: true,
                                  hintText: "DD/MM/YYYY",
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none),
                            ),
                          ),
                        ),
                      ),
                      CustomNextButton(
                        onTap: (_registerShareController
                                    .numberofShareController.text.isNotEmpty &&
                                _registerShareController
                                    .dateOfEmploymentController.text.isNotEmpty)
                            ? () {
                                if (isValid == true) {
                                  widget.onTap();
                                } else {
                                  Fluttertoast.showToast(
                                    msg: "Invalid Date",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: whiteColor,
                                    textColor: greenColor,
                                    fontSize: 15,
                                  );
                                }

                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                              }
                            : null,
                        btnColor: (_registerShareController
                                    .numberofShareController.text.isNotEmpty &&
                                _registerShareController
                                    .dateOfEmploymentController.text.isNotEmpty)
                            ? greenColor
                            : grey1Color,
                        text: "Next",
                        marginTop: height * .16,
                        marginBottom: width * .07,
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
