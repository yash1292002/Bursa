import 'dart:developer';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/strings.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/widgets/dialogs/status_faild_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

import '../../../Services/api_services.dart';
import 'dart:io' as io;

class PersonalDetailScreen extends StatefulWidget {
  PersonalDetailScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;
  @override
  State<PersonalDetailScreen> createState() => _PersonalDetailScreenState();
}

class _PersonalDetailScreenState extends State<PersonalDetailScreen> {
  //remove the

  // final TextEditingController _firstNameController = TextEditingController();
  // final TextEditingController _lastNameController = TextEditingController();
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _birthOfDateController = TextEditingController();
  // final TextEditingController _phoneNumberController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  var maskFormatter = MaskTextInputFormatter(mask: '##/##/####');
  bool isLoading = false;
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

  var regExp = RegExp(r'!/^\d{1,2}\/\d{1,2}\/\d{4}$/');

  bool isValid = true;
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
    AuthController _authController =
        Provider.of<AuthController>(context, listen: true);
    return KeyboardActions(
      config: _buildConfig(context),
      child: Container(
        height: height * .73,
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              width * .03,
            ),
          ),
        ),
        padding: EdgeInsets.only(
            top: height * .03,
            bottom: height * .03,
            left: width * .05,
            right: width * .05),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Personal Details",
                    style: poppinsRegular.copyWith(
                        color: lightBlueColor,
                        fontSize: width * .046,
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: width * .1,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          style: poppinsRegular.copyWith(
                            color: blackColor,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                          ),
                          enabled: false,
                          controller: _authController.fullNameController,
                          decoration: InputDecoration(
                            hintText: "Full Name",
                            border: InputBorder.none,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lightBlueColorWithopacity40,
                              ),
                            ),
                            hintStyle: poppinsRegular.copyWith(
                              color: lightBlueColorWithopacity40,
                              fontSize: width * .04,
                              // fontWeight: FontWeight.w500,
                            ),
                          ),
                          maxLines: 1,
                        ),
                        Container(
                          height: 1,
                          color: lightBlueColorWithopacity30,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: width * .08,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          style: poppinsRegular.copyWith(
                            color: blackColor,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                          ),
                          enabled: false,
                          initialValue: _authController.emirateId,
                          // controller: _authController.lastNameController,
                          decoration: InputDecoration(
                            hintText: "Emirates Id",
                            border: InputBorder.none,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lightBlueColorWithopacity40,
                              ),
                            ),
                            hintStyle: poppinsRegular.copyWith(
                              color: lightBlueColorWithopacity40,
                              fontSize: width * .04,
                              //fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: lightBlueColorWithopacity30,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: width * .08,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          style: poppinsRegular.copyWith(
                            color: blackColor,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                          ),
                          controller: _authController.emailController,
                          decoration: InputDecoration(
                            hintText: "Email Address",
                            border: InputBorder.none,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lightBlueColorWithopacity40,
                              ),
                            ),
                            hintStyle: poppinsRegular.copyWith(
                              color: lightBlueColorWithopacity40,
                              fontSize: width * .04,
                              // fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: lightBlueColorWithopacity30,
                        )
                      ],
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     showDatePicker(
                  //             context: context,
                  //             initialDate: selectedDate,
                  //             firstDate: DateTime(1800),
                  //             // lastDate: DateTime((DateTime.now().year - 18)),
                  //             lastDate: DateTime.now())
                  //         .then((value) {
                  //       if (value != null) {
                  //         setState(() {
                  //           selectedDate = value;
                  //         });
                  //         _authController.birthofdateController.text =
                  //             DateFormat("dd/MM/yyyy").format(selectedDate);
                  //       }
                  //     });
                  //   },
                  io.Platform.isAndroid
                      ? Container(
                          margin: EdgeInsets.only(
                            top: width * .08,
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: blackColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                // enabled: false,
                                controller:
                                    _authController.birthofdateController,
                                // focusNode: _nodeText2,
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskFormatter],
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
                                    log("data--s--d-sd-" + isValid.toString());
                                  } else {}
                                },
                                decoration: InputDecoration(
                                  hintText: "Date of Birth (DD/MM/YY)",
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: lightBlueColor,
                                    size: width * .055,
                                  ),

                                  // disabledBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: lightBlueColorWithopacity40,
                                  //   ),
                                  // ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                color: lightBlueColorWithopacity30,
                              )
                            ],
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                            top: width * .08,
                          ),
                          child: Column(
                            children: [
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: blackColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                // enabled: false,
                                controller:
                                    _authController.birthofdateController,
                                focusNode: _nodeText2,
                                keyboardType: TextInputType.number,
                                inputFormatters: [maskFormatter],
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
                                    log("My is Valid Value" +
                                        isValid.toString());
                                  } else {}
                                },
                                decoration: InputDecoration(
                                  hintText: "Birth Date (DD/MM/YY)",
                                  border: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.calendar_today_outlined,
                                    color: lightBlueColor,
                                    size: width * .055,
                                  ),

                                  // disabledBorder: UnderlineInputBorder(
                                  //   borderSide: BorderSide(
                                  //     color: lightBlueColorWithopacity40,
                                  //   ),
                                  // ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    //fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Container(
                                height: 1,
                                color: lightBlueColorWithopacity30,
                              )
                            ],
                          ),
                        ),

                  Container(
                    margin: EdgeInsets.only(
                      top: width * .08,
                    ),
                    child: Column(
                      children: [
                        io.Platform.isAndroid
                            ? TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: blackColor,
                                  fontSize: width * .04,
                                  // fontWeight: FontWeight.w500,
                                ),
                                // focusNode: _nodeText1,
                                controller:
                                    _authController.phoneNumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                onChanged: (text) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  // // contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    width: width * .2,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/dubai.png",
                                          height: height * .04,
                                          // width: width * .8,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: width * .02,
                                          ),
                                          child: Text(
                                            '+971',
                                            style: poppinsRegular.copyWith(
                                              color: blackColor,
                                              fontSize: width * .04,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  // prefix: Container(
                                  //   margin: EdgeInsets.only(left: width * .01),
                                  //   width: width * .1,
                                  //   child: Row(
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       Text(
                                  //         '+971',
                                  //         style: poppinsRegular.copyWith(
                                  //           color: blackColor,
                                  //           fontSize: width * .04,
                                  //           fontWeight: FontWeight.w500,
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),

                                  hintText: "5XXXXXXXX",
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.zero,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity40,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            : TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: blackColor,
                                  fontSize: width * .04,
                                  // fontWeight: FontWeight.w500,
                                ),
                                focusNode: _nodeText1,
                                controller:
                                    _authController.phoneNumberController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                onChanged: (text) {
                                  setState(() {});
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  // // contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    width: width * .2,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/dubai.png",
                                          height: height * .04,
                                          // width: width * .8,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: width * .02,
                                          ),
                                          child: Text(
                                            '+971',
                                            style: poppinsRegular.copyWith(
                                              color: blackColor,
                                              fontSize: width * .04,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                  // prefix: Container(
                                  //   margin: EdgeInsets.only(left: width * .01),
                                  //   width: width * .1,
                                  //   child: Row(
                                  //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //     children: [
                                  //       Text(
                                  //         '+971',
                                  //         style: poppinsRegular.copyWith(
                                  //           color: blackColor,
                                  //           fontSize: width * .04,
                                  //           fontWeight: FontWeight.w500,
                                  //         ),
                                  //       )
                                  //     ],
                                  //   ),
                                  // ),

                                  hintText: "5XXXXXXXX",
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.zero,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity40,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                        Container(
                          height: 1,
                          color: lightBlueColorWithopacity30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (_authController.fullNameController.text.isNotEmpty &&
                        // _authController.lastNameController.text.isNotEmpty &&
                        _authController.emailController.text.isNotEmpty &&
                        _authController.birthofdateController.text.isNotEmpty &&
                        _authController.phoneNumberController.text.isNotEmpty)
                    ? () async {
                        if (isLoading) {
                          return;
                        }
                        if (emailRegex
                            .hasMatch(_authController.emailController.text)) {
                          if (_authController.phoneNumberController.text
                                  .startsWith("5") &&
                              _authController
                                      .phoneNumberController.text.length ==
                                  9) {
                            if (isValid == true) {
                              FocusScope.of(context).requestFocus(FocusNode());

                              setState(() {
                                isLoading = true;
                              });

                              bool emailStatus = await ApiServices()
                                  .verifyEmailOrPhone(
                                      _authController.emailController.text);
                              bool phoneStatus = await ApiServices()
                                  .verifyEmailOrPhone(_authController
                                      .phoneNumberController.text);

                              bool idStatus = await ApiServices()
                                  .verifyEmiratesId(
                                      _authController.emirateId ?? "");
                              log("status");
                              log("emailStatus: $emailStatus");
                              log("phoneStatus: $phoneStatus");
                              log("idStatus: $idStatus");
                              setState(() {
                                isLoading = false;
                              });
                              if (idStatus) {
                                Get.dialog(
                                    const StatusFailedDialog(
                                        text:
                                            AppStrings.emiratesIdAlreadyTaken),
                                    barrierDismissible: false);

                                return;
                              } else if (emailStatus) {
                                Get.dialog(
                                    const StatusFailedDialog(
                                        text: AppStrings.emailAlreadyTaken),
                                    barrierDismissible: false);

                                return;
                              }
                              if (phoneStatus) {
                                Get.dialog(
                                    const StatusFailedDialog(
                                        text: AppStrings.phoneAlreadyTaken),
                                    barrierDismissible: false);

                                return;
                              }

                              widget.ontap();
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
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please enter the valid Phone Number",
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
                            msg: "Please enter the valid email address",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: whiteColor,
                            textColor: greenColor,
                            fontSize: 15,
                          );
                        }
                        if (_authController.phoneNumberController.text
                            .startsWith("5")) {
                          log("Yes Start With 5");
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please enter the valid Phone Number",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: whiteColor,
                            textColor: greenColor,
                            fontSize: 15,
                          );
                        }
                      }
                    : null,
                child: Container(
                  height: width * .11,
                  margin: EdgeInsets.only(
                    top: width * .1,
                  ),
                  decoration: BoxDecoration(
                    color: (_authController
                                .fullNameController.text.isNotEmpty &&
                            // _authController.lastNameController.text.isNotEmpty &&
                            _authController.emailController.text.isNotEmpty &&
                            _authController
                                .birthofdateController.text.isNotEmpty &&
                            _authController
                                .phoneNumberController.text.isNotEmpty)
                        ? greenColor
                        : grey1Color,
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * .02)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    isLoading ? "Please wait..." : "Next",
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
    );
  }
}
