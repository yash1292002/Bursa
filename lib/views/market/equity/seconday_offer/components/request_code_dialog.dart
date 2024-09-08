import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/views/market/equity/seconday_offer/components/success_code_dialog.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../controllers/offer_share_controller.dart';
import 'invalid_code_dialog.dart';

class RequestCodeDialog extends StatefulWidget {
  const RequestCodeDialog({Key? key}) : super(key: key);

  @override
  State<RequestCodeDialog> createState() => _RequestCodeDialogState();
}

class _RequestCodeDialogState extends State<RequestCodeDialog> {
  final TextEditingController privateKey = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var offerShareController = Provider.of<OfferShareController>(context);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: width,
          margin: const EdgeInsets.symmetric(horizontal: 24.0),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              /// Enter your Bid  Request Code texts
              SizedBox(height: height * 0.04),
              Text(
                'Enter your Bid Request Code',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// description texts
              SizedBox(height: height * 0.015),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Enter your invitation code to invest in specific opportunity',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greyColor2,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              /// code field
              SizedBox(height: height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Container(
                  height: 40.0,
                  width: width,
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: AppColors.lightBlueColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: TextFormField(
                    controller: privateKey,
                    style: poppinsRegular.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.lightBlueColor,
                    ),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: '',
                      border: InputBorder.none,
                      hintStyle: poppinsRegular.copyWith(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.lightBlueColor,
                      ),
                    ),
                  ),
                ),
              ),

              /// Submit Button
              SizedBox(height: height * 0.03),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  onTap: () async {
                    if (privateKey.text.trim().isNotEmpty) {
                      OfferShareBid? offerShareBid = await offerShareController
                          .getPrivateShare(privateKey.text.trim());

                      offerShareController.setSelectedBidShare(offerShareBid);

                      if (offerShareBid == null) {
                        Get.back();
                        Get.dialog(
                          const InvalidCodeDialog(),
                        );
                      } else {
                        Get.back();
                        Get.dialog(
                          SuccessCodeDialog(offerShareBid: offerShareBid),
                        );
                      }
                    } else {
                      Fluttertoast.showToast(
                        msg: "Please enter the code",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: whiteColor,
                        textColor: greenColor,
                        fontSize: 15,
                      );
                    }
                  },
                  btnText: 'Submit',
                ),
              ),

              /// Cancel Button
              SizedBox(height: height * 0.015),
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: poppinsRegular.copyWith(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w500,
                    color: AppColors.greenColor,
                  ),
                ),
              ),

              SizedBox(height: height * 0.015),
            ],
          ),
        ),
      ),
    );
  }
}
