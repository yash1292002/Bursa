import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/views/home_screen/bid_buy_shares/buy_share/buy_share_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../consts/color_const.dart';
import '../../../consts/textstyle_const.dart';
import 'bid_share/bid_share_screen.dart';

class BidBuyShareScreen extends StatefulWidget {
  const BidBuyShareScreen({Key? key}) : super(key: key);

  @override
  State<BidBuyShareScreen> createState() => _BidBuyShareScreenState();
}

class _BidBuyShareScreenState extends State<BidBuyShareScreen> {
  bool bidShareActive = true;
  bool buyShareActive = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
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
        backgroundColor: Colors.transparent,

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
            "Bid & Buy Share",
            style: poppinsRegular.copyWith(
              color: AppColors.white1,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),

        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 24.0),

            /// tab bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bidShareActive = true;
                          buyShareActive = false;
                        });
                      },
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                      child: Ink(
                        width: width,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0),
                          ),
                          border: Border.all(
                            color: bidShareActive == true
                                ? Colors.transparent
                                : AppColors.white1.withOpacity(0.2),
                            width: 0.5,
                          ),
                          color: bidShareActive == true
                              ? AppColors.cyanColor.withOpacity(0.1)
                              : null,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.activeBidShareIcon,
                                height: 30.0, width: 30.0, fit: BoxFit.fill),
                            const SizedBox(width: 12.0),
                            Text(
                              'Bid Shares',
                              style: GoogleFonts.poppins().copyWith(
                                color: AppColors.white1,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          bidShareActive = false;
                          buyShareActive = true;
                        });
                      },
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      child: Ink(
                        width: width,
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          border: Border.all(
                            color: buyShareActive == true
                                ? Colors.transparent
                                : AppColors.white1.withOpacity(0.2),
                            width: 0.5,
                          ),
                          color: buyShareActive == true
                              ? AppColors.cyanColor.withOpacity(0.1)
                              : null,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppImages.inActiveBuyShareIcon,
                                height: 30.0, width: 30.0, fit: BoxFit.fill),
                            const SizedBox(width: 12.0),
                            Text(
                              'Buy Shares',
                              style: GoogleFonts.poppins().copyWith(
                                color: AppColors.white1,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// tab bar body
            bidShareActive == true
                ? const BidShareScreen()
                : const BuyShareScreen(),
          ],
        ),
      ),
    );
  }
}
