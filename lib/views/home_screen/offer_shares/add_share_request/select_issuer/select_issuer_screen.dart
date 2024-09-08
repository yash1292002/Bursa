import 'dart:developer';

import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:bursa_flutter/models/Limit_offer_model.dart';
import 'package:bursa_flutter/models/offer_share1_model.dart';
import 'package:bursa_flutter/models/register_share_model.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../consts/textstyle_const.dart';
import '../components/my_text_field.dart';
import 'dart:io' as io;
import 'package:intl/intl.dart';

class SelectIssuerScreen extends StatefulWidget {
  SelectIssuerScreen({Key? key, this.onTap, this.registerInfoData})
      : super(key: key);
  final Function? onTap;
  RegisterShareInfo? registerInfoData;
  @override
  State<SelectIssuerScreen> createState() => _SelectIssuerScreenState();
}

class _SelectIssuerScreenState extends State<SelectIssuerScreen> {
  final oCcy = NumberFormat("#,##0.00", "en_US");

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      OfferShareController _offerShareController =
          Provider.of<OfferShareController>(context, listen: false);

      //   offerShareController.getCompanyShares();
      //   // offerShareController.getBursaFees();
      //   log("List of shares" + offerShareController.companyShares.toString());
      // });
      // _offerShareController.getCompanyShareWithOffer().then((value) {
      //   setState(() {
      //     isLoading = false;
      //   });
      // });
      setState(() {
        isLoading = false;
      });

      log("List of shares" + _offerShareController.companyShares.toString());
    });
  }

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

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(context, listen: true);

    return KeyboardActions(
      config: _buildConfig(context),
      child: SingleChildScrollView(
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                color: whiteColor,
              ))
            : Column(
                children: [
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      color: AppColors.white1,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Which shares would you like to offer for sale ?',
                            style: GoogleFonts.poppins().copyWith(
                              color: AppColors.lightBlueColor,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            'You will only be able to select one company share per request.',
                            style: GoogleFonts.poppins().copyWith(
                              color: AppColors.greyColor2,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            ),
                          ),

                          /// dropdown shares select
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: width * .002,
                                  color: lightBlueColorWithopacity30,
                                ),
                              ),
                            ),
                            child: DropdownButton(
                              hint: Text(
                                "Select your share",
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .036,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: poppinsRegular.copyWith(
                                color: blackColor,
                                fontSize: width * .036,
                                fontWeight: FontWeight.w500,
                              ),
                              isExpanded: true,
                              underline: DropdownButtonHideUnderline(
                                child: Container(),
                              ),
                              value: _offerShareController.selectedOfferShare,
                              items: List.generate(
                                  _offerShareController.offerShareList!.length,
                                  (index) {
                                return DropdownMenuItem<OfferShareDetails>(
                                    child: Text(
                                      _offerShareController
                                          .offerShareList![index].companyName!,
                                      style: poppinsRegular.copyWith(
                                        color: blackColor,
                                        fontSize: width * .04,
                                        //   fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: _offerShareController
                                        .offerShareList![index]);
                              }),

                              // _offerShareController.companyShares
                              //     ?.map(
                              //       (share) => DropdownMenuItem(
                              //         child: Text(
                              //           share.value,
                              //           style: poppinsRegular.copyWith(
                              //             color: blackColor,
                              //             fontSize: width * .036,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //         ),
                              //         value: share,
                              //       ),
                              //     )
                              //     .toList(),
                              onChanged: (value) => _offerShareController
                                  .setselectedCompanyShares(
                                      value as OfferShareDetails),
                            ),
                          ),
                          SizedBox(height: height * 0.015),

                          /// quantity share field
                          Text(
                            'Quantity',
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightBlueColor,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'How many shares would you like to sell ?',
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyColor,
                            ),
                          ),
                          io.Platform.isAndroid
                              ? MyTextField1(
                                  controller: _offerShareController
                                      .quantityTextController,
                                  keyboardType: TextInputType.number,
                                  // focusNode: _nodeText1,

                                  hintText: '',
                                  suffixText: 'Shares',
                                  onChanged: (value) =>
                                      _offerShareController.quantity =
                                          value.isNotEmpty
                                              ? double.parse(value)
                                              : 0,
                                )
                              : MyTextField1(
                                  controller: _offerShareController
                                      .quantityTextController,
                                  keyboardType: TextInputType.number,
                                  focusNode: _nodeText1,
                                  hintText: '',
                                  suffixText: 'Shares',
                                  onChanged: (value) =>
                                      _offerShareController.quantity =
                                          value.isNotEmpty
                                              ? double.parse(value)
                                              : 0,
                                ),
                          Container(
                            height: 1,
                            color: blackColorWithOpacity20,
                          ),
                          const SizedBox(height: 3.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Minimum quantity: 1000 shares',
                              style: GoogleFonts.poppins().copyWith(
                                fontSize: 9.0,
                                fontWeight: FontWeight.w400,
                                color: AppColors.greyColor,
                              ),
                            ),
                          ),

                          /// offer price field
                          const SizedBox(height: 10.0),
                          Text(
                            'Offer Price',
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightBlueColor,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'How much are you willing to sell the share for?',
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyColor,
                            ),
                          ),
                          io.Platform.isAndroid
                              ? MyTextField(
                                  controller: _offerShareController.offerText,
                                  keyboardType: TextInputType.number,
                                  hintText: '',
                                  // focusNode: _nodeText2,
                                  prefixText: "\$",
                                  suffixText: 'Per Shares',
                                  onChanged: (value) =>
                                      _offerShareController.offerPrice =
                                          value.isNotEmpty
                                              ? double.parse(value)
                                              : 0,
                                )
                              : MyTextField(
                                  controller: _offerShareController.offerText,
                                  keyboardType: TextInputType.number,
                                  hintText: '',
                                  prefixText: "\$",
                                  focusNode: _nodeText2,
                                  suffixText: 'Per Shares',
                                  onChanged: (value) =>
                                      _offerShareController.offerPrice =
                                          value.isNotEmpty
                                              ? double.parse(value)
                                              : 0,
                                ),

                          /// Limit offer field
                          const SizedBox(height: 10.0),
                          Text(
                            'Limit Offer',
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightBlueColor,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'When does your offer end ?',
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w400,
                              color: AppColors.greyColor,
                            ),
                          ),
                          //dropdown
                          Container(
                            width: width,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  width: width * .002,
                                  color: lightBlueColorWithopacity30,
                                ),
                              ),
                            ),
                            child: DropdownButton<LimitDetails>(
                              hint: Text(
                                "selecte Your Limit Offer",
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .036,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: poppinsRegular.copyWith(
                                color: blackColor,
                                fontSize: width * .036,
                                fontWeight: FontWeight.w500,
                              ),
                              isExpanded: true,
                              underline: DropdownButtonHideUnderline(
                                child: Container(),
                              ),
                              value: _offerShareController.selectedLimitDetails,
                              items: List.generate(
                                  _offerShareController.limitDetails!.length,
                                  (index) {
                                return DropdownMenuItem<LimitDetails>(
                                    child: Text(
                                      _offerShareController
                                          .limitDetails![index].value!,
                                      style: poppinsRegular.copyWith(
                                        color: blackColor,
                                        fontSize: width * .04,
                                        //   fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    value: _offerShareController
                                        .limitDetails![index]);
                              }),

                              // _offerShareController.companyShares
                              //     ?.map(
                              //       (share) => DropdownMenuItem(
                              //         child: Text(
                              //           share.value,
                              //           style: poppinsRegular.copyWith(
                              //             color: blackColor,
                              //             fontSize: width * .036,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //         ),
                              //         value: share,
                              //       ),
                              //     )
                              //     .toList(),
                              onChanged: (value) => _offerShareController
                                  .selectedLimitOffers = value as LimitDetails?,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Container(
                    width: width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11.0),
                      color: AppColors.white1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        textRow(
                            'Total Sale Price',
                            'This is the amount due for \npayment by bidder',
                            '\$${oCcy.format(double.parse(_offerShareController.totalSalePrice.toStringAsFixed(2)))} USD'),
                        textRow('Bursa Fees', 'Transaction Fees set at 1%',
                            '\$${oCcy.format(double.parse(_offerShareController.calculateBursaFee().toStringAsFixed(2)))} USD'),
                        textRow('Net Sale Price', 'Net to seller',
                            "\$${oCcy.format(_offerShareController.totalSalePrice - _offerShareController.bursaFees)} USD"),
                        const SizedBox(height: 8.0),
                        CustomButton(
                          onTap: (_offerShareController.selectedOfferShare !=
                                      null &&
                                  _offerShareController.selectedLimitDetails !=
                                      null &&
                                  _offerShareController
                                      .offerText.text.isNotEmpty &&
                                  _offerShareController
                                      .quantityTextController.text.isNotEmpty)
                              // _registerShareController.pdffile != null
                              ? () {
                                  widget.onTap!();

                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                }
                              : null,
                          // () {
                          //   FocusScope.of(context)
                          //       .requestFocus(new FocusNode());
                          //   // if (_offerShareController.selectedOfferShare == null ||
                          //     _offerShareController.selectedOfferShare ==
                          //         null ||
                          //     _offerShareController.offerText.text.isEmpty ||
                          //     _offerShareController
                          //         .quantityTextController.text.isEmpty) {
                          //   log("!1------");
                          //   Fluttertoast.showToast(
                          //     msg: "Please fill all fields!",
                          //     toastLength: Toast.LENGTH_SHORT,
                          //     gravity: ToastGravity.BOTTOM,
                          //     timeInSecForIosWeb: 1,
                          //     backgroundColor: whiteColor,
                          //     textColor: greenColor,
                          //     fontSize: 15,
                          //   );
                          // }
                          // //  else if (_offerShareController.quantity < 1000) {
                          // //   log("!2------");
                          // //   Fluttertoast.showToast(
                          // //     msg: "Minimum quantity: 1000 shares",
                          // //     toastLength: Toast.LENGTH_SHORT,
                          // //     gravity: ToastGravity.BOTTOM,
                          // //     timeInSecForIosWeb: 1,
                          // //     backgroundColor: whiteColor,
                          // //     textColor: greenColor,
                          // //     fontSize: 15,
                          // //   );
                          // // }
                          // else {
                          //   log("!3------");
                          //   // OfferShare share = OfferShare(
                          //   //     quantity: _offerShareController.quantity,
                          //   //     limitOffer: _offerShareController.l,
                          //   //     offerPrice: _offerShareController.offerPrice,
                          //   //     offerShareCompany: DropDownItem(
                          //   //         _offerShareController
                          //   //             .selectedOfferShare!.id!,
                          //   //         _offerShareController
                          //   //             .selectedOfferShare!.companyName!));

                          //   widget.onTap!();

                          // }

                          // },
                          btnText: 'Next',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget textRow(titleText, descText, descPrice) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              titleText,
              style: GoogleFonts.poppins().copyWith(
                fontSize: 12.0,
                color: AppColors.lightBlueColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    descText,
                    style: GoogleFonts.poppins().copyWith(
                      fontSize: 11.0,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  descPrice,
                  style: GoogleFonts.poppins().copyWith(
                    fontSize: 12.0,
                    color: AppColors.lightBlueColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
}
