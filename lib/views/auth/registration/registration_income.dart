import 'dart:developer';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/models/employement_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class EmployementAndIncomeDetailScreen extends StatefulWidget {
  EmployementAndIncomeDetailScreen({Key? key, required this.onTap})
      : super(key: key);
  VoidCallback onTap;

  @override
  State<EmployementAndIncomeDetailScreen> createState() =>
      _EmployementAndIncomeDetailScreenState();
}

class _EmployementAndIncomeDetailScreenState
    extends State<EmployementAndIncomeDetailScreen> {
  DateTime selectedDate = DateTime.now();
  final oCcy = NumberFormat("#,##0.00", "en_US");
  bool isLoading = true;
  var maskFormatter = MaskTextInputFormatter(mask: '##/##/####');

  // @override
  // void initState() {

  //   AuthController _controller =
  //       Provider.of<AuthController>(context, listen: false);
  //   super.initState();

  // }

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
        // KeyboardActionsItem(
        //   focusNode: _nodeText2,
        // ),
      ],
    );
  }

  var regExp = RegExp(r'!/^\d{1,2}\/\d{1,2}\/\d{4}$/');
  bool isValid = true;
  bool isValidDate(dateString) {
    log("dateString===" + dateString);
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
      child: SingleChildScrollView(
        child: Container(
          height: height * .73,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Please provide your employment details",
                      style: poppinsRegular.copyWith(
                          color: lightBlueColor,
                          fontSize: width * .046,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: width * .1,
                      ),
                      width: width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            width: width * .002,
                            color: lightBlueColorWithopacity30,
                          ),
                        ),
                      ),
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
                            _authController.employementInfoList!.length,
                            (index) {
                          return DropdownMenuItem<EmployementInfo>(
                              child: Text(
                                _authController
                                    .employementInfoList![index].name!,
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value:
                                  _authController.employementInfoList![index]);
                        }),
                        onChanged: (value) {
                          _authController.setEmployement(value);
                        },
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     top: width * .08,
                    //   ),
                    //   width: width,
                    //   decoration: BoxDecoration(
                    //     border: Border(
                    //       bottom: BorderSide(
                    //         width: width * .002,
                    //         color: greyColor,
                    //       ),
                    //     ),
                    //   ),
                    //   child: DropdownButton(
                    //     hint: Text(
                    //       "Country",
                    //       style: poppinsRegular.copyWith(
                    //         color: lightBlueColorWithopacity40,
                    //         fontSize: width * .04,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //     style: poppinsRegular.copyWith(
                    //       color: lightBlueColor,
                    //       fontSize: width * .04,
                    //       fontWeight: FontWeight.w500,
                    //     ),
                    //     isExpanded: true,
                    //     underline: Container(),
                    //     value: nationality,
                    //     items: List.generate(countryList.length, (index) {
                    //       return DropdownMenuItem(
                    //           child: Text(
                    //             countryList[index],
                    //             style: poppinsRegular.copyWith(
                    //               color: lightBlueColor,
                    //               fontSize: width * .04,
                    //               fontWeight: FontWeight.w500,
                    //             ),
                    //           ),
                    //           value: countryList[index]);
                    //     }),
                    //     onChanged: (value) {
                    //       setState(() {
                    //         country = value as String;
                    //       });
                    //     },
                    //   ),
                    // ),

                    Container(
                      margin: EdgeInsets.only(
                        top: width * .08,
                      ),
                      child: Column(
                        children: [
                          io.Platform.isAndroid
                              ? TextFormField(
                                  style: poppinsRegular.copyWith(
                                    color: lightBlueColor,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller:
                                      _authController.incomeTextController,
                                  // focusNode: _nodeText1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "Annual Income",
                                    border: InputBorder.none,
                                    suffixIcon: Text("AED",
                                        style: poppinsRegular.copyWith(
                                          color: lightBlueColorWithopacity40,
                                          fontSize: width * .04,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    suffixIconConstraints: BoxConstraints.loose(
                                        Size(width * .1, width * .1)),
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
                                    color: lightBlueColor,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  controller:
                                      _authController.incomeTextController,
                                  focusNode: _nodeText1,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                    ThousandsFormatter(),
                                  ],
                                  decoration: InputDecoration(
                                    hintText: "Annual Income",
                                    border: InputBorder.none,
                                    suffixIcon: Text("AED",
                                        style: poppinsRegular.copyWith(
                                          color: lightBlueColorWithopacity40,
                                          fontSize: width * .04,
                                          fontWeight: FontWeight.w500,
                                        )),
                                    suffixIconConstraints: BoxConstraints.loose(
                                        Size(width * .1, width * .1)),
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
                    Container(
                      margin: EdgeInsets.only(
                        top: width * .08,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .04,
                              fontWeight: FontWeight.w500,
                            ),
                            controller: _authController.employeeNameController,
                            decoration: InputDecoration(
                              hintText: "Company Name",
                              border: InputBorder.none,
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
                    // GestureDetector(
                    //   onTap: () {
                    //     showDatePicker(
                    //       context: context,
                    //       initialDate: selectedDate,
                    //       firstDate: DateTime(1990),
                    //       lastDate: DateTime.now(),
                    //     ).then((value) {
                    //       if (value != null) {
                    //         setState(() {
                    //           selectedDate = value;
                    //         });
                    //         _authController.dateOfEmploymentController.text =
                    //             DateFormat("dd/MM/yyyy").format(selectedDate);
                    //       }
                    //     });
                    //   },
                    Container(
                      margin: EdgeInsets.only(
                        top: width * .08,
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .04,
                              fontWeight: FontWeight.w500,
                            ),
                            // enabled: false,
                            inputFormatters: [maskFormatter],
                            keyboardType: TextInputType.number,
                            controller:
                                _authController.dateOfEmploymentController,
                            onChanged: (val) {
                              var date = ["MM", "dd", "yyyy"];
                              log(val);
                              log(val.split("/").toString());
                              if (val.split("/").length == 3) {
                                date[0] = val.split("/")[1];
                                date[1] = val.split("/")[0];
                                date[2] = val.split("/")[2];
                                log("date====" + date.join("/"));
                                var datetime = date.join("/");
                                isValid = isValidDate(datetime);
                                log("check=========" + isValid.toString());
                              } else {}
                            },
                            decoration: InputDecoration(
                              hintText: "Date of Employment (DD/MM/YY)",
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
                  onTap:
                      (_authController.incomeTextController.text.isNotEmpty &&
                              _authController
                                  .employeeNameController.text.isNotEmpty &&
                              _authController.selectedEmployement != null &&
                              _authController
                                  .dateOfEmploymentController.text.isNotEmpty
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

                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          : null),
                  child: Container(
                    height: width * .11,
                    margin: EdgeInsets.only(
                      top: width * .1,
                    ),
                    decoration: BoxDecoration(
                      color: (_authController
                                  .incomeTextController.text.isNotEmpty &&
                              _authController
                                  .employeeNameController.text.isNotEmpty &&
                              _authController.selectedEmployement != null &&
                              _authController
                                  .dateOfEmploymentController.text.isNotEmpty)
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
      ),
    );
  }
}
