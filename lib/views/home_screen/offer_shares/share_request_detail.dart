import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/models/BidAllShare_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../consts/color_const.dart';
import '../../../consts/textstyle_const.dart';
import '../../../controllers/offer_share_controller.dart';
import '../../../widgets/small_chip_widget.dart';
import '../issue_digital_certificate/components/card_texts_widget.dart';

class ShareRequestDetail extends StatefulWidget {
  const ShareRequestDetail({Key? key, required this.offerShareBid})
      : super(key: key);
  final BidShareDetails offerShareBid;

  @override
  State<ShareRequestDetail> createState() => _ShareRequestDetailState();
}

class _ShareRequestDetailState extends State<ShareRequestDetail> {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      var offerShareController =
          Provider.of<OfferShareController>(context, listen: false);
      offerShareController.calculateBursaFee();
    });
  }

  final oCcy = NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var offerShareController = Provider.of<OfferShareController>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.blueColor,
            AppColors.greenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,

        /// Appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leadingWidth: 60.0,
          leading: IconButton(
            onPressed: () {
              //Get.offAll(const PersisNavBar());
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset('assets/icons/back_button.png'),
            ),
          ),
          centerTitle: true,
          title: Text(
            "Share Request Detail",
            style: poppinsRegular.copyWith(
              color: AppColors.white1,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              Container(
                width: width,
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 44.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// logo image
                    Center(
                      child: Image.network(
                          widget.offerShareBid.businessLogo.toString(),
                          height: 70.0,
                          width: 70.0,
                          fit: BoxFit.fill,
                          errorBuilder: (context, error, stackTrace) {
                        return SvgPicture.asset(
                          AppImages.blankImg,
                          height: 30.0,
                          width: 30.0,
                          fit: BoxFit.fill,
                        );
                      }),
                    ),
                    const SizedBox(height: 16.0),

                    /// company name
                    Text(
                      widget.offerShareBid.companyName.toString(),
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 16.0,
                        color: AppColors.lightBlueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    /// chip row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallChip(
                          onTap: () {},
                          chipText: 'Payment Done',
                          chipColor: AppColors.greenColor,
                        ),
                        const SizedBox(width: 4.0),
                        SmallChip(
                          onTap: () {},
                          chipText: 'Auction',
                          chipColor: AppColors.lightBlue1,
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.06),

                    /// name and date of birth row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Quantity Share',
                            descText: widget.offerShareBid.quantity.toString(),
                          ),
                        ),
                        const SizedBox(width: 24.0),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Offer Price',
                            descText:
                                '\$${oCcy.format(double.parse(widget.offerShareBid.maximumBidPrice.toString()))}',
                          ),
                        ),
                        Expanded(
                          child: CardTextsWidget(
                            titleText: 'Limit Offer ',
                            descText: widget.offerShareBid.offerTimeLimit,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: width,
                height: height * 0.32,
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    textRow(
                        'Total Sale Price',
                        'This is the amount due for \npayment by bidder',
                        '${oCcy.format(double.parse((widget.offerShareBid.quantity! * widget.offerShareBid.maximumBidPrice!).toStringAsFixed(2)))} USD'),
                    textRow('Bursa Fees', 'Transaction Fees set at 1%',
                        '${oCcy.format(double.parse((widget.offerShareBid.quantity! * widget.offerShareBid.maximumBidPrice! * (1 / 100)).toStringAsFixed(2)))} USD'),

                    // Here  after the + add Bursa fees
                    textRow('Net to seller', 'Net to seller',
                        '${oCcy.format(double.parse((widget.offerShareBid.quantity! * widget.offerShareBid.maximumBidPrice! + widget.offerShareBid.quantity! * widget.offerShareBid.maximumBidPrice! * (1 / 100)).toStringAsFixed(2)))} USD'),
                  ],
                ),
              ),
            ],
          ),
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
