import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../../../../consts/color_const.dart';
import '../secondary_offer_detail_screen.dart';

class SuccessCodeDialog extends StatefulWidget {
  const SuccessCodeDialog({Key? key, required this.offerShareBid})
      : super(key: key);
  final OfferShareBid offerShareBid;

  @override
  State<SuccessCodeDialog> createState() => _SuccessCodeDialogState();
}

class _SuccessCodeDialogState extends State<SuccessCodeDialog> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
              SizedBox(height: height * 0.064),
              Image.asset(AppImages.celebrateImage, height: height * 0.1),

              /// Succsess text
              SizedBox(height: height * 0.064),
              Text(
                'Code Authenticated Successfully',
                style: GoogleFonts.poppins().copyWith(
                  color: AppColors.lightBlueColor,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),

              /// description texts
              SizedBox(height: height * 0.01),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Your Bid request code is authenticated . Please proceed next',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.greyColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              /// Next button
              SizedBox(height: height * 0.052),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: CustomButton(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        duration: const Duration(milliseconds: 300),
                        reverseDuration: const Duration(milliseconds: 300),
                        type: PageTransitionType.rightToLeft,
                        child: SecondaryOfferDetailScreen(
                            offerShareBid: widget.offerShareBid),
                      ),
                    );
                  },
                  btnText: 'Next',
                ),
              ),

              SizedBox(height: height * 0.054),
            ],
          ),
        ),
      ),
    );
  }
}
