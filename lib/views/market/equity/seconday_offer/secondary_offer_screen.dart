import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/models/bid_model.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/offer_share_controller.dart';
import 'components/request_code_dialog.dart';
import 'secondary_offer_detail_screen.dart';

class SecondaryOfferScreen extends StatefulWidget {
  const SecondaryOfferScreen({Key? key}) : super(key: key);

  @override
  State<SecondaryOfferScreen> createState() => _SecondaryOfferScreenState();
}

class _SecondaryOfferScreenState extends State<SecondaryOfferScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(context, listen: false);
    _offerShareController.resetSelectedBidShare();
    // setState(() {
    //   _offerShareController.resetSelectedCategoryInfoData();
    // });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    OfferShareController _offerShareController =
        Provider.of<OfferShareController>(context, listen: true);

    AuthController _controller =
        Provider.of<AuthController>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// get the code? texts
        SizedBox(height: height * 0.024),
        Center(
          child: InkWell(
            onTap: () {
              Get.dialog(
                const RequestCodeDialog(),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                'Got the Code ?',
                style: poppinsRegular.copyWith(
                  color: AppColors.whiteColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            'Enter your  invitation  code to invest in specific opportunity',
            textAlign: TextAlign.center,
            style: poppinsRegular.copyWith(
              color: AppColors.whiteColor,
              fontWeight: FontWeight.w500,
              fontSize: 14.0,
            ),
          ),
        ),

        /// box
        SizedBox(height: height * 0.028),
        Expanded(
          child: FutureBuilder<List<OfferShareBid>?>(
            future:
                _offerShareController.getOfferShares(_controller.userDetail!),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  OfferShareBid offerShareBid = snapshot.data![index];
                  return Container(
                    width: width,
                    padding: const EdgeInsets.only(
                        top: 18.0, left: 18.0, bottom: 18.0, right: 36.0),
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: AppColors.whiteColor,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.network(
                            offerShareBid.logo,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return SvgPicture.asset(AppImages.blankImg);
                            },
                          ),
                        ),
                        const SizedBox(width: 24.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  secondaryData(
                                      'Name', offerShareBid.companyName),
                                  secondaryData(
                                      'Type', offerShareBid.offerType),
                                ],
                              ),
                              SizedBox(height: height * 0.015),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  secondaryData('Last Valuation', '\$ 55mn'),
                                  secondaryData('Shares Offered',
                                      offerShareBid.quantity.toString()),
                                ],
                              ),
                              SizedBox(height: height * 0.015),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  secondaryData('Offer Price',
                                      '\$${offerShareBid.offerPrice}'),
                                  Expanded(
                                    child: CustomButton(
                                      onTap: () {
                                        if (!offerShareBid.isPayed) {
                                          _offerShareController
                                              .setSelectedBidShare(
                                                  offerShareBid);

                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              reverseDuration: const Duration(
                                                  milliseconds: 300),
                                              type: PageTransitionType
                                                  .rightToLeft,
                                              child: SecondaryOfferDetailScreen(
                                                  offerShareBid: offerShareBid),
                                            ),
                                          );
                                        }
                                      },
                                      btnText: offerShareBid.isPayed
                                          ? 'Bid Completed'
                                          : 'Bid Now',
                                      btnHeight: 30.0,
                                      enabled: !offerShareBid.isPayed,
                                      btnColor: offerShareBid.isPayed
                                          ? AppColors.greenColor
                                          : AppColors.blueColor,
                                      btnTextSize:
                                          offerShareBid.isPayed ? 10.0 : 12.0,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }

  Widget secondaryData(topText, bottomText) => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              topText,
              style: poppinsRegular.copyWith(
                color: AppColors.greyColor2,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 3.0),
            Text(
              bottomText,
              style: poppinsRegular.copyWith(
                color: AppColors.lightBlueColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );
}
