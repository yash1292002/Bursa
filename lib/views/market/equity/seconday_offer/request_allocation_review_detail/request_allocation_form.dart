import 'dart:developer';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/models/Limit_offer_model.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';

import '../../../../../controllers/offer_share_controller.dart';
import '../../../../home_screen/offer_shares/add_share_request/components/my_text_field.dart';
import 'dart:io' as io;

class RequestAllocationForm extends StatefulWidget {
  RequestAllocationForm(
      {Key? key, required this.onTap, required this.offerShareBid})
      : super(key: key);
  VoidCallback onTap;
  final OfferShareBid offerShareBid;

  @override
  State<RequestAllocationForm> createState() => _RequestAllocationFormState();
}

class _RequestAllocationFormState extends State<RequestAllocationForm> {
  // TextEditingController quantityController = TextEditingController();
  // TextEditingController bidPriceOneController = TextEditingController();
  // TextEditingController bidPriceTwoController = TextEditingController();
  bool isLoading = true;
  final oCcy = NumberFormat("#,##0.00", "en_US");
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var _offerShareController =
          Provider.of<OfferShareController>(context, listen: false);

      // offerShareController.getLimitOffers();
      // offerShareController.resetDropdown();
      setState(() {
        _offerShareController.quantityBid = TextEditingController(
            text: widget.offerShareBid.quantity.toString());
      });

      setState(() {
        isLoading = false;
      });
    });
  }

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
              padding: const EdgeInsets.only(
                  top: 20.0, left: 24.0, bottom: 16.0, right: 60.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: AppColors.white1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Allocation Request Detrails',
                    style: poppinsRegular.copyWith(
                      color: AppColors.lightBlueColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    children: [
                      dataColumn('Company :', widget.offerShareBid.companyName),
                      dataColumn('Offer Price :',
                          '\$${oCcy.format(double.parse(widget.offerShareBid.offerPrice.toString()))}'),
                    ],
                  ),
                  SizedBox(height: height * 0.015),
                  Row(
                    children: [
                      // dataColumn('Share Class :', 'Series C'),
                      dataColumn('Shares Offered :',
                          widget.offerShareBid.quantity.toString()),
                    ],
                  ),
                ],
              ),
            ),

            /// quantity Box
            SizedBox(height: height * 0.01),
            Container(
              width: width,
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11.0),
                color: AppColors.white1,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
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
                      'How many shares would you like to buy ?',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                    io.Platform.isAndroid
                        ? MyTextField1(
                            // focusNode: _nodeText1,
                            controller:
                                _offerShareController.quantityBidController,
                            keyboardType: TextInputType.number,
                            hintText: '',
                            suffixText: 'Shares',
                          )
                        : MyTextField1(
                            focusNode: _nodeText1,
                            controller:
                                _offerShareController.quantityBidController,
                            keyboardType: TextInputType.number,
                            hintText: '',
                            suffixText: 'Shares',
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

                    /// bid price one field
                    const SizedBox(height: 10.0),
                    Text(
                      'Bid Price',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightBlueColor,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'How much are you willing to buy the share for? '
                      '(bid price should be above  or equal to the offer price',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                    io.Platform.isAndroid
                        ? MyTextField(
                            // focusNode: _nodeText2,
                            controller:
                                _offerShareController.bidPriceOneController,
                            keyboardType: TextInputType.number,

                            // hintText: '\$11.10',
                            prefixText: '\$',
                            suffixText: 'Per Shares',
                            onChanged: (value) {
                              if (widget.offerShareBid.offerPrice <=
                                  int.parse(_offerShareController
                                      .bidPriceOneController.text)) {
                                log("message");
                                // Fluttertoast.showToast(
                                //   msg: "Done",
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.BOTTOM,
                                //   timeInSecForIosWeb: 1,
                                //   backgroundColor: whiteColor,
                                //   textColor: greenColor,
                                //   fontSize: 15,
                                // );
                              } else {
                                log("dsdsdsdsd");
                                Fluttertoast.showToast(
                                  msg:
                                      "The entered value should be same or above of the offer price . Review your detail and try again.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: whiteColor,
                                  textColor: greenColor,
                                  fontSize: 15,
                                );
                              }
                            },
                          )
                        : MyTextField(
                            focusNode: _nodeText2,
                            controller:
                                _offerShareController.bidPriceOneController,
                            keyboardType: TextInputType.number,
                            prefixText: '\$',
                            // hintText: '\$11.10',
                            suffixText: 'Per Shares',
                            onChanged: (value) {
                              String str = _offerShareController
                                  .bidPriceOneController.text
                                  .trim();
                              String bidPriceOneController =
                                  str.replaceAll(RegExp('[^0-9]'), '');
                              if (widget.offerShareBid.offerPrice <=
                                  int.parse(bidPriceOneController)) {
                                log("message");
                                // Fluttertoast.showToast(
                                //   msg: "Done",
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.BOTTOM,
                                //   timeInSecForIosWeb: 1,
                                //   backgroundColor: whiteColor,
                                //   textColor: greenColor,
                                //   fontSize: 15,
                                // );
                              } else {
                                log("dsdsdsdsd");
                                Fluttertoast.showToast(
                                  msg:
                                      "The entered value should be same or above of the offer price . Review your detail and try again.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: whiteColor,
                                  textColor: greenColor,
                                  fontSize: 15,
                                );
                              }
                            },
                          ),

                    /// bid price two field
                    const SizedBox(height: 10.0),
                    Text(
                      'Bid Price (Maximum)',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightBlueColor,
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'This is the maximum price you will buy the shares for.',
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w400,
                        color: AppColors.greyColor,
                      ),
                    ),
                    io.Platform.isAndroid
                        ? MyTextField(
                            // focusNode: _nodeText3,
                            controller:
                                _offerShareController.bidPriceTwoController,
                            keyboardType: TextInputType.number,
                            hintText: '',
                            suffixText: 'Per Shares',
                            prefixText: '\$',
                            onChanged: (value) {
                              String str = _offerShareController
                                  .bidPriceTwoController.text
                                  .trim();
                              String bidPriceTwoController =
                                  str.replaceAll(RegExp('[^0-9]'), '');
                              if (widget.offerShareBid.offerPrice <=
                                  int.parse(bidPriceTwoController)) {
                                log("message");
                                // Fluttertoast.showToast(
                                //   msg: "Done",
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.BOTTOM,
                                //   timeInSecForIosWeb: 1,
                                //   backgroundColor: whiteColor,
                                //   textColor: greenColor,
                                //   fontSize: 15,
                                // );
                              } else {
                                log("dsdsdsdsd");
                                Fluttertoast.showToast(
                                  msg:
                                      "The entered value should be same or above of the offer price . Review your detail and try again.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: whiteColor,
                                  textColor: greenColor,
                                  fontSize: 15,
                                );
                              }
                            },
                          )
                        : MyTextField(
                            focusNode: _nodeText3,
                            controller:
                                _offerShareController.bidPriceTwoController,
                            keyboardType: TextInputType.number,
                            hintText: '',
                            suffixText: 'Per Shares',
                            prefixText: '\$',
                            onChanged: (value) {
                              String str = _offerShareController
                                  .bidPriceTwoController.text
                                  .trim();
                              String bidPriceTwoController =
                                  str.replaceAll(RegExp('[^0-9]'), '');
                              if (widget.offerShareBid.offerPrice <=
                                  int.parse(bidPriceTwoController)) {
                                log("message");
                                // Fluttertoast.showToast(
                                //   msg: "Done",
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.BOTTOM,
                                //   timeInSecForIosWeb: 1,
                                //   backgroundColor: whiteColor,
                                //   textColor: greenColor,
                                //   fontSize: 15,
                                // );
                              } else {
                                log("dsdsdsdsd");
                                Fluttertoast.showToast(
                                  msg:
                                      "The entered value should be same or above of the offer price . Review your detail and try again.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: whiteColor,
                                  textColor: greenColor,
                                  fontSize: 15,
                                );
                              }
                            },
                          ),

                    /// Limit Bid field
                    const SizedBox(height: 10.0),
                    Text(
                      'Limit Bid',
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
                              value:
                                  _offerShareController.limitDetails![index]);
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
                    ),

                    /// next button
                    SizedBox(height: height * 0.03),
                    //   CustomButton(
                    //     onTap:
                    // (_offerShareController.bidPriceOneController.text
                    //             .trim()
                    //             .isNotEmpty &&
                    //         _offerShareController
                    //             .bidPriceTwoController.text
                    //             .trim()
                    //             .isNotEmpty &&
                    //         _offerShareController
                    //             .quantityBidController.text
                    //             .trim()
                    //             .isNotEmpty &&
                    //         _offerShareController.selectedLimitDetails !=
                    //             null)
                    //     // _registerShareController.pdffile != null
                    //     ? () {
                    //         String str = _offerShareController
                    //             .bidPriceTwoController.text
                    //             .trim();
                    //         String bidPriceTwoController =
                    //             str.replaceAll(RegExp('[^0-9]'), '');
                    //         String str1 = _offerShareController
                    //             .bidPriceOneController.text
                    //             .trim();
                    //         String bidPriceOneController =
                    //             str1.replaceAll(RegExp('[^0-9]'), '');
                    //         if (widget.offerShareBid.offerPrice <=
                    //             int.parse(bidPriceOneController)) {
                    //           if (int.parse(bidPriceOneController) <=
                    //               int.parse(bidPriceTwoController)) {
                    //             widget.onTap();
                    //           } else {
                    //             // Fluttertoast.showToast(
                    //             //   msg:
                    //             //       "Bid Share Max Prize is equal or greater-then Min Price",
                    //             //   toastLength: Toast.LENGTH_SHORT,
                    //             //   gravity: ToastGravity.BOTTOM,
                    //             //   timeInSecForIosWeb: 1,
                    //             //   backgroundColor: whiteColor,
                    //             //   textColor: redColor,
                    //             //   fontSize: 15,
                    //             // );
                    //             showDialog(
                    //                 context: context,
                    //                 barrierColor:
                    //                     darkGreyColorWithOpacity80,
                    //                 builder: (BuildContext context) {
                    //                   return AlertDialog(
                    //                     shape: RoundedRectangleBorder(
                    //                         borderRadius:
                    //                             BorderRadius.all(
                    //                                 Radius.circular(
                    //                                     width * .02))),
                    //                     content: StatefulBuilder(
                    //                         builder: (context, setState) {
                    //                       return Container(
                    //                         height: height * .44,
                    //                         width: width * .7,
                    //                         margin: EdgeInsets.only(
                    //                           top: width * .01,
                    //                           bottom: width * .03,
                    //                         ),
                    //                         child: Column(
                    //                           children: [
                    //                             Image.asset(
                    //                               "assets/icons/failed.png",
                    //                               height: height * .14,
                    //                             ),
                    //                             Container(
                    //                               margin: EdgeInsets.only(
                    //                                   top: height * .02),
                    //                               child: Text(
                    //                                 "The entered value should be same or above of the offer price . Review your detail and try again OK.",
                    //                                 textAlign:
                    //                                     TextAlign.center,
                    //                                 style: poppinsRegular
                    //                                     .copyWith(
                    //                                         color:
                    //                                             lightBlueColor,
                    //                                         fontWeight:
                    //                                             FontWeight
                    //                                                 .bold,
                    //                                         fontSize:
                    //                                             width *
                    //                                                 .042),
                    //                               ),
                    //                             ),
                    //                             GestureDetector(
                    //                               onTap: () {
                    //                                 Navigator.pop(
                    //                                     context);
                    //                               },
                    //                               child: Container(
                    //                                 margin:
                    //                                     EdgeInsets.only(
                    //                                         top: height *
                    //                                             .05),
                    //                                 height: height * .055,
                    //                                 width: width * .7,
                    //                                 decoration: BoxDecoration(
                    //                                     color:
                    //                                         greenColor1,
                    //                                     borderRadius:
                    //                                         BorderRadius
                    //                                             .circular(
                    //                                                 8)),
                    //                                 child: Column(
                    //                                   children: [
                    //                                     Container(
                    //                                       margin: EdgeInsets
                    //                                           .only(
                    //                                               top: width *
                    //                                                   .02),
                    //                                       child: Text(
                    //                                         "Ok",
                    //                                         textAlign:
                    //                                             TextAlign
                    //                                                 .center,
                    //                                         style: poppinsRegular.copyWith(
                    //                                             color:
                    //                                                 whiteColor,
                    //                                             fontSize:
                    //                                                 width *
                    //                                                     .045,
                    //                                             fontWeight:
                    //                                                 FontWeight
                    //                                                     .w600),
                    //                                       ),
                    //                                     ),
                    //                                   ],
                    //                                 ),
                    //                               ),
                    //                             ),
                    //                           ],
                    //                         ),
                    //                       );
                    //                     }),
                    //                   );
                    //                 });
                    //           }
                    //         } else {
                    //           showDialog(
                    //               context: context,
                    //               barrierColor:
                    //                   darkGreyColorWithOpacity80,
                    //               builder: (BuildContext context) {
                    //                 return AlertDialog(
                    //                   shape: RoundedRectangleBorder(
                    //                       borderRadius: BorderRadius.all(
                    //                           Radius.circular(
                    //                               width * .02))),
                    //                   content: StatefulBuilder(
                    //                       builder: (context, setState) {
                    //                     return Container(
                    //                       height: height * .44,
                    //                       width: width * .7,
                    //                       margin: EdgeInsets.only(
                    //                         top: width * .01,
                    //                         bottom: width * .03,
                    //                       ),
                    //                       child: Column(
                    //                         children: [
                    //                           Image.asset(
                    //                             "assets/icons/failed.png",
                    //                             height: height * .14,
                    //                           ),
                    //                           Container(
                    //                             margin: EdgeInsets.only(
                    //                                 top: height * .02),
                    //                             child: Text(
                    //                               "The entered value should be same or above of the offer price . Review your detail and try again OK.",
                    //                               textAlign:
                    //                                   TextAlign.center,
                    //                               style: poppinsRegular
                    //                                   .copyWith(
                    //                                       color:
                    //                                           lightBlueColor,
                    //                                       fontWeight:
                    //                                           FontWeight
                    //                                               .bold,
                    //                                       fontSize:
                    //                                           width *
                    //                                               .042),
                    //                             ),
                    //                           ),
                    //                           GestureDetector(
                    //                             onTap: () {
                    //                               Navigator.pop(context);
                    //                             },
                    //                             child: Container(
                    //                               margin: EdgeInsets.only(
                    //                                   top: height * .05),
                    //                               height: height * .055,
                    //                               width: width * .7,
                    //                               decoration: BoxDecoration(
                    //                                   color: greenColor1,
                    //                                   borderRadius:
                    //                                       BorderRadius
                    //                                           .circular(
                    //                                               8)),
                    //                               child: Column(
                    //                                 children: [
                    //                                   Container(
                    //                                     margin: EdgeInsets
                    //                                         .only(
                    //                                             top: width *
                    //                                                 .02),
                    //                                     child: Text(
                    //                                       "Ok",
                    //                                       textAlign:
                    //                                           TextAlign
                    //                                               .center,
                    //                                       style: poppinsRegular.copyWith(
                    //                                           color:
                    //                                               whiteColor,
                    //                                           fontSize:
                    //                                               width *
                    //                                                   .045,
                    //                                           fontWeight:
                    //                                               FontWeight
                    //                                                   .w600),
                    //                                     ),
                    //                                   ),
                    //                                 ],
                    //                               ),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       ),
                    //                     );
                    //                   }),
                    //                 );
                    //               });
                    //         }

                    //         FocusScope.of(context)
                    //             .requestFocus(new FocusNode());
                    //       }
                    //     : null,

                    //     // onTap: () {
                    //     //   if (quantityController.text.isEmpty ||
                    //     //       bidPriceOneController.text.isEmpty ||
                    //     //       bidPriceTwoController.text.isEmpty ||
                    //     //       _offerShareController
                    //     //           .selectedLimitOffer!.value.isEmpty) {
                    //     //     Fluttertoast.showToast(
                    //     //       msg: "Please fill all fields!",
                    //     //       toastLength: Toast.LENGTH_SHORT,
                    //     //       gravity: ToastGravity.BOTTOM,
                    //     //       timeInSecForIosWeb: 1,
                    //     //       backgroundColor: whiteColor,
                    //     //       textColor: greenColor,
                    //     //       fontSize: 15,
                    //     //     );
                    //     //   } else if (double.parse(
                    //     //           quantityController.text.trim()) <
                    //     //       1000) {
                    //     //     Fluttertoast.showToast(
                    //     //       msg: "Minimum quantity: 1000 shares",
                    //     //       toastLength: Toast.LENGTH_SHORT,
                    //     //       gravity: ToastGravity.BOTTOM,
                    //     //       timeInSecForIosWeb: 1,
                    //     //       backgroundColor: whiteColor,
                    //     //       textColor: greenColor,
                    //     //       fontSize: 15,
                    //     //     );
                    //     //   } else {
                    //     //     widget.offerShareBid.bidQuantity =
                    //     //         double.parse(quantityController.text.trim());
                    //     //     widget.offerShareBid.minBidPrice =
                    //     //         double.parse(bidPriceOneController.text.trim());
                    //     //     widget.offerShareBid.maxBidPrice =
                    //     //         double.parse(bidPriceTwoController.text.trim());
                    //     //     widget.offerShareBid.limitBid =
                    //     //         _offerShareController.selectedLimitOffer!.value;

                    //     //     widget.onTap();
                    //     //   }
                    //     // },
                    //     btnText: 'Next',
                    //     btnColor: widget.offerShareBid.offerPrice <=
                    //             int.parse((_offerShareController
                    //                     .bidPriceOneController.text)
                    //                 .replaceAll(RegExp('[^0-9]'), ''))
                    //         ? greenColor1
                    //         : greyColor,
                    //   ),
                    GestureDetector(
                      onTap:
                          (_offerShareController.bidPriceOneController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _offerShareController
                                      .bidPriceTwoController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _offerShareController
                                      .quantityBidController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _offerShareController.selectedLimitDetails !=
                                      null&& widget.offerShareBid.offerPrice <=
                                      double.parse((_offerShareController
                                              .bidPriceOneController.text)
                                          .replaceAll(RegExp('[^0-9]'), '')) &&
                                  double.parse((_offerShareController.bidPriceOneController.text).replaceAll(RegExp('[^0-9]'), '')) <=
                                      double.parse((_offerShareController
                                              .bidPriceTwoController.text)
                                          .replaceAll(RegExp('[^0-9]'), '')))
                              // _registerShareController.pdffile != null
                              ? widget.onTap   : null,
                      child: Container(
                        height: width * .11,
                        decoration: BoxDecoration(
                          color: _offerShareController
                                      .bidPriceOneController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _offerShareController.bidPriceTwoController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _offerShareController.quantityBidController.text
                                      .trim()
                                      .isNotEmpty &&
                                  _offerShareController.selectedLimitDetails !=
                                      null &&
                                  widget.offerShareBid.offerPrice <=
                                      double.parse((_offerShareController
                                              .bidPriceOneController.text)
                                          .replaceAll(RegExp('[^0-9]'), '')) &&
                                  double.parse((_offerShareController.bidPriceOneController.text).replaceAll(RegExp('[^0-9]'), '')) <=
                                      double.parse((_offerShareController
                                              .bidPriceTwoController.text)
                                          .replaceAll(RegExp('[^0-9]'), ''))
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
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dataColumn(topText, bottomText) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              topText,
              style: poppinsRegular.copyWith(
                color: AppColors.lightBlueColor,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              bottomText,
              style: poppinsRegular.copyWith(
                color: AppColors.greyColor2,
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}
