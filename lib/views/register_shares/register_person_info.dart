import 'dart:developer';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:bursa_flutter/widgets/coutry_code_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_next_button.dart';
import 'dart:io' as io;

class RegisterPersonInfo extends StatefulWidget {
  RegisterPersonInfo({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterPersonInfo> createState() => _RegisterPersonInfoState();
}

class _RegisterPersonInfoState extends State<RegisterPersonInfo> {
  RegExp emailRegEx = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  final FocusNode _nodeText1 = FocusNode();
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return KeyboardActions(
      config: _buildConfig(context),
      child: Container(
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
            bottom: height * .02,
            left: width * .06,
            right: width * .06),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "Who is your main contact person at issuer company ?",
                    style: poppinsRegular.copyWith(
                        color: lightBlueColor,
                        fontSize: width * .038,
                        fontWeight: FontWeight.w700),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * .015),
                    child: Text(
                      "To ensure regulatory compliance, we will need to verify that you are still a shareholder.",
                      style: poppinsRegular.copyWith(
                          color: greyColor2,
                          fontSize: width * .033,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomInputField(
                    isBigText: true,
                    isEnabled: true,
                    editingController:
                        _registerShareController.firstNameController,
                    hintText: "Full Name",
                    onTextChange: (String s) {
                      if (s.isEmpty) {
                        log("Empty");
                        setState(() {});
                      }
                    },
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  CustomInputField(
                    isBigText: true,
                    isEnabled: true,
                    inputType: TextInputType.emailAddress,
                    editingController: _registerShareController.emailController,
                    hintText: "Email Address",
                    onTextChange: (String s) {
                      if (s.isEmpty) {
                        return "Please enter email";
                      } else if (!emailRegEx.hasMatch(s)) {
                        return "Please enter valid email";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  io.Platform.isAndroid
                      ? CustomInputField(
                          isBigText: true,
                          isEnabled: true,
                          inputType: TextInputType.phone,
                          editingController:
                              _registerShareController.phoneNumberController,
                          // focusNode: _nodeText1,
                          hintText: "5XXXXXXXX",
                          prefixWidget: const CountryCodeWidget(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9),
                          ],
                          onTextChange: (String s) {
                            if (s.isEmpty) {
                              log("Empty");
                              setState(() {});
                            }
                          },
                        )
                      : CustomInputField(
                          isBigText: true,
                          isEnabled: true,
                          inputType: TextInputType.phone,
                          editingController:
                              _registerShareController.phoneNumberController,
                          focusNode: _nodeText1,
                          hintText: "5XXXXXXXX",
                          prefixWidget: const CountryCodeWidget(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(9),
                          ],
                          onTextChange: (String s) {
                            if (s.isEmpty) {
                              log("Empty");
                              setState(() {});
                            }
                          },
                        ),
                  SizedBox(
                    height: width * .08,
                  ),
                  CustomNextButton(
                    onTap: () {
                      // widget.onTap();
                      if (_registerShareController
                              .firstNameController.text.isEmpty &&
                          _registerShareController
                              .lastNameController.text.isEmpty &&
                          _registerShareController
                              .emailController.text.isEmpty &&
                          _registerShareController
                              .phoneNumberController.text.isEmpty) {
                        widget.onTap();
                      } else {
                        if (_registerShareController
                            .emailController.text.isNotEmpty) {
                          if (emailRegEx.hasMatch(
                              _registerShareController.emailController.text)) {
                            widget.onTap();
                          } else {
                            Fluttertoast.showToast(
                              msg: "Please enter the valid  Email",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: whiteColor,
                              textColor: greenColor,
                              fontSize: 15,
                            );
                          }
                        } else {
                          widget.onTap();
                        }
                      }
                      FocusScope.of(context).requestFocus(FocusNode());
                    },

                    // onTap: (
                    //     _registerShareController
                    //               .firstNameController.text.isNotEmpty &&
                    //     _registerShareController
                    //         .lastNameController.text.isNotEmpty &&
                    //     _registerShareController
                    //         .emailController.text.isNotEmpty
                    // _registerShareController
                    //     .phoneNumberController.text.isNotEmpty
                    // )
                    //     ? () {
                    // if (emailRegEx.hasMatch(_registerShareController
                    //     .emailController.text)) {
                    //   // if (_registerShareController
                    //   //         .phoneNumberController.text
                    //   //         .startsWith("5") &&
                    //   //     _registerShareController
                    //   //             .phoneNumberController.text.length ==
                    //   //         9) {
                    //   //   widget.onTap();
                    //   // } else {
                    //   //   Fluttertoast.showToast(
                    //   //     msg: "Please enter the valid Phone Number",
                    //   //     toastLength: Toast.LENGTH_SHORT,
                    //   //     gravity: ToastGravity.BOTTOM,
                    //   //     timeInSecForIosWeb: 1,
                    //   //     backgroundColor: whiteColor,
                    //   //     textColor: greenColor,
                    //   //     fontSize: 15,
                    //   //   );
                    //   // }
                    //           widget.onTap();
                    //         } else {
                    //           Fluttertoast.showToast(
                    //             msg: "Please Enter valid email",
                    //             toastLength: Toast.LENGTH_SHORT,
                    //             gravity: ToastGravity.BOTTOM,
                    //             timeInSecForIosWeb: 1,
                    //             backgroundColor: whiteColor,
                    //             textColor: greenColor,
                    //             fontSize: 15,
                    //           );
                    //         }
                    //       }
                    //     : null,
                    btnColor: greenColor,
                    text: "Next",
                    marginBottom: 0,
                    marginTop: height * .14,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
