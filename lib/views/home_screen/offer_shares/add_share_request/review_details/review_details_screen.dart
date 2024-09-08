import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:bursa_flutter/models/offer_share1_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../widgets/custom_button.dart';
import '../components/consent_dialog.dart';
import '../components/review_point.dart';

class ReviewDetailsScreen extends StatefulWidget {
  ReviewDetailsScreen({
    Key? key,
    required this.onTap,
    required this.offerShare,
  }) : super(key: key);
  VoidCallback onTap;
  final OfferShareDetails? offerShare;

  @override
  State<ReviewDetailsScreen> createState() => _ReviewDetailsScreenState();
}

class _ReviewDetailsScreenState extends State<ReviewDetailsScreen> {
  @override
  TextEditingController _accountNameController = TextEditingController();
  TextEditingController _bankNameController = TextEditingController();
  TextEditingController _ibanController = TextEditingController();
  void initState() {
    super.initState();

    // log(widget.offerShareDetails.toString());
    OfferShareController _controller =
        Provider.of<OfferShareController>(context, listen: false);
    _accountNameController =
        TextEditingController(text: _controller.accountNameController.text);
    _bankNameController =
        TextEditingController(text: _controller.bankNameController.text);
    _ibanController =
        TextEditingController(text: _controller.ibnNumberController.text);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    OfferShareController _controller =
        Provider.of<OfferShareController>(context, listen: true);

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        color: AppColors.white1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Please confirm your offering \ndetails.',
            style: GoogleFonts.poppins().copyWith(
              color: AppColors.lightBlueColor,
              fontSize: 15.0,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: height * 0.024),
          Divider(
            color: AppColors.greyColor.withOpacity(0.6),
            thickness: 0.5,
          ),
          SizedBox(height: height * 0.008),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ReviewPoint(
                    titleText: 'Company Shares',
                    descText:
                        _controller.selectedOfferShare!.companyName.toString(),
                  ),
                  ReviewPoint(
                    titleText: 'Quantity of shares offered for sale',
                    descText: _controller.selectedOfferShare!.numberOfShares
                        .toString(),
                  ),
                  // ReviewPoint(
                  //   titleText: 'Remaining Shares',
                  //   descText: '8,000',
                  // ),
                  ReviewPoint(
                    titleText: 'Offer Price',
                    descText: '\$${_controller.offerText.text}',
                  ),
                  ReviewPoint(
                    titleText: 'Offer process',
                    descText:
                        _controller.auction == true ? 'Auction' : 'Private',
                  ),
                  ReviewPoint(
                    titleText: 'Offer Period',
                    descText:
                        _controller.selectedLimitDetails!.value.toString(),
                  ),
                  ReviewPoint(
                      titleText: 'Account Name',
                      descText: _accountNameController.text),
                  ReviewPoint(
                      titleText: 'Bank Name',
                      descText: _bankNameController.text),
                  ReviewPoint(
                      titleText: 'Iban Number', descText: _ibanController.text),
                ],
              ),
            ),
          ),
          CustomButton(
            onTap: () {
              Get.dialog(
                const ConsentDialog(),
              );
            },
            btnText: 'Submit',
            margin: const EdgeInsets.all(0.0),
          ),
        ],
      ),
    );
  }
}
