import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'dart:io' as io;

class BankDetails extends StatefulWidget {
  BankDetails({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;
  @override
  State<BankDetails> createState() => _BankDetailsState();
}

class _BankDetailsState extends State<BankDetails> {
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
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(context);

    return KeyboardActions(
      config: _buildConfig(context),
      child: SingleChildScrollView(
        child: Column(
          children: [
            /// allocation request detail box
            Container(
              width: width,
              padding: EdgeInsets.only(
                  top: height * .02, left: width * .02, right: width * .02),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: AppColors.white1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: width * .008),
                    child: Text(
                      "Please add bank account details that you would like to receive money in a post successful bid by a potential buyer.",
                      style: poppinsRegular.copyWith(
                          color: lightBlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: width * .04),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: width * .008, top: height * .02),
                        child: Text(
                          "Account name",
                          style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: width * .04),
                        ),
                      ),
                      Container(
                        // height: height * .06,
                        margin: EdgeInsets.only(
                            top: height * .01,
                            left: width * .008,
                            right: width * .008),
                        // width: width,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: greyColor),
                            color: lightGreyColor1,
                            borderRadius: BorderRadius.circular(width * .02)),
                        child: io.Platform.isAndroid
                            ? TextField(
                                maxLines: 2,
                                focusNode: _nodeText1,
                                // cursorColor: greyColor,
                                controller:
                                    _offerShareController.accountNameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: width * .02,
                                  ),
                                  border: InputBorder.none,
                                  // hintText: 'Enter Your Bank Details'
                                ),
                              )
                            : TextField(
                                maxLines: 2,
                                focusNode: _nodeText1,
                                controller:
                                    _offerShareController.accountNameController,
                                // cursorColor: greyColor,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: width * .02,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: width * .008, top: height * .02),
                        child: Text(
                          "Bank name",
                          style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: width * .04),
                        ),
                      ),
                      Container(
                        // height: height * .06,
                        margin: EdgeInsets.only(
                            top: height * .01,
                            left: width * .008,
                            right: width * .008),
                        width: width,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: greyColor),
                            color: lightGreyColor1,
                            borderRadius: BorderRadius.circular(width * .02)),
                        child: io.Platform.isAndroid
                            ? TextField(
                                // maxLines: 5,
                                // focusNode: _nodeText2,
                                // cursorColor: greyColor,
                                controller:
                                    _offerShareController.bankNameController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: width * .02,
                                  ),
                                  border: InputBorder.none,
                                  // hintText: 'Enter Your Bank Details'
                                ),
                              )
                            : TextField(
                                // maxLines: 5,
                                // focusNode: _nodeText2,
                                controller:
                                    _offerShareController.bankNameController,
                                // cursorColor: greyColor,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: width * .02,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: width * .008, top: height * .02),
                        child: Text(
                          "Iban number",
                          style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontWeight: FontWeight.bold,
                              fontSize: width * .04),
                        ),
                      ),
                      Container(
                        // height: height * .06,
                        margin: EdgeInsets.only(
                            top: height * .01,
                            left: width * .008,
                            right: width * .008),
                        width: width,
                        decoration: BoxDecoration(
                            // border: Border.all(width: 1, color: greyColor),
                            color: lightGreyColor1,
                            borderRadius: BorderRadius.circular(width * .02)),
                        child: io.Platform.isAndroid
                            ? TextField(
                                // maxLines: 5,
                                // focusNode: _nodeText3,
                                // cursorColor: greyColor,
                                controller:
                                    _offerShareController.ibnNumberController,
                                // keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: width * .02,
                                  ),
                                  border: InputBorder.none,

                                  // hintText: 'Enter Your Bank Details'
                                ),
                              )
                            : TextField(
                                // maxLines: 5,
                                focusNode: _nodeText3,
                                controller:
                                    _offerShareController.ibnNumberController,
                                // keyboardType: TextInputType.number,
                                // cursorColor: greyColor,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: width * .02,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: (_offerShareController
                                .accountNameController.text.isNotEmpty &&
                            _offerShareController
                                .bankNameController.text.isNotEmpty &&
                            _offerShareController
                                .ibnNumberController.text.isNotEmpty)
                        ? () {
                            widget.onTap();
                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        : null,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: height * .2,
                          bottom: height * .05,
                          left: width * .02,
                          right: width * .02),
                      height: height * .06,
                      width: width,
                      decoration: BoxDecoration(
                          color: (_offerShareController
                                      .accountNameController.text.isNotEmpty &&
                                  _offerShareController
                                      .bankNameController.text.isNotEmpty &&
                                  _offerShareController
                                      .ibnNumberController.text.isNotEmpty)
                              ? greenColor
                              : grey1Color,
                          borderRadius: BorderRadius.circular(width * .025)),
                      child: Container(
                        margin: EdgeInsets.only(top: height * .01),
                        child: Text(
                          "Next",
                          textAlign: TextAlign.center,
                          style: poppinsRegular.copyWith(
                            color: whiteColor,
                            fontSize: width * .05,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// quantity Box
          ],
        ),
      ),
    );
  }
}
