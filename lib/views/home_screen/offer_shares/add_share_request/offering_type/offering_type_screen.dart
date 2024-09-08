import 'package:bursa_flutter/controllers/offer_share_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../consts/color_const.dart';
import '../../../../../widgets/custom_button.dart';

class OfferingTypeScreen extends StatefulWidget {
  OfferingTypeScreen({Key? key, required this.onTap}) : super(key: key);
  Function onTap;

  @override
  State<OfferingTypeScreen> createState() => _OfferingTypeScreenState();
}

class _OfferingTypeScreenState extends State<OfferingTypeScreen> {
  // bool private = false;
  // bool auction = true;
  Future<void>? _launched;
  // String _phone = '';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    OfferShareController _controller =
        Provider.of<OfferShareController>(context, listen: true);
    const String toLaunch = 'https://www.sharebursa.com/';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Container(
            width: width,
            padding:
                const EdgeInsets.symmetric(horizontal: 36.0, vertical: 22.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'How do you want to offer your \nshares ?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins().copyWith(
                      color: AppColors.lightBlueColor,
                      fontSize: 15.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),

                /// private and auction button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          // setState(() {
                          //   _controller.private == true;
                          //   _controller.auction == false;
                          // });
                          _controller.setAction();
                        },
                        btnHeight: 40.0,
                        margin: const EdgeInsets.all(0.0),
                        btnText: 'Private',
                        btnColor: _controller.private == true
                            ? AppColors.darkblue1
                            : AppColors.white1,
                        btnTextColor: _controller.private == true
                            ? AppColors.white1
                            : AppColors.lightGrey,
                        borderColor: _controller.private == true
                            ? AppColors.darkblue1
                            : AppColors.lightGrey,
                        btnTextSize: 12.0,
                        borderRadius: 10.0,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          // setState(() {
                          //   _controller.private == false;
                          //   _controller.auction == true;
                          // });
                          _controller.setPrivate();
                        },
                        btnHeight: 40.0,
                        margin: const EdgeInsets.all(0.0),
                        btnText: 'Auction',
                        btnColor: _controller.auction == true
                            ? AppColors.darkblue1
                            : AppColors.white1,
                        btnTextColor: _controller.auction == true
                            ? AppColors.white1
                            : AppColors.lightGrey,
                        borderColor: _controller.auction == true
                            ? AppColors.darkblue1
                            : AppColors.lightGrey,
                        btnTextSize: 12.0,
                        borderRadius: 10.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: width,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(11.0),
              color: AppColors.white1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24.0),

                        /// certified description
                        Text(
                          '*Private Offering :',
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 13.0,
                            color: AppColors.lightBlueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Your share offering will be matched with one potential '
                          'investor and the process will be managed by a dedicated '
                          'Bursa Investment Advisor',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 11.0,
                            color: AppColors.greyColor2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        /// non-Certified description
                        const SizedBox(height: 16.0),
                        Text(
                          'Auction Offering :',
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 13.0,
                            color: AppColors.lightBlueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Your share offering will be listed and marketed for public '
                          'bidding by multiple investors. \n\n'
                          '*Private offering is also known as properiety deal andhas '
                          'higher transaction costs that is typically incured by '
                          'both seller and buyer. \n\n'
                          'Transaction fees are 2% \n'
                          'Minimum Transaction Value: \$1mn USD',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 11.0,
                            color: AppColors.greyColor2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        /// visit website
                        const SizedBox(height: 16.0),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _launched = _launchInBrowser(toLaunch);
                            });
                          },
                          child: Text(
                            'For a comparison between both types, please visit our frequently '
                            'asked questions page on'
                            '\nwww.sharebursa.com/FAQ.  ',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 11.0,
                              color: AppColors.blueColor2,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  onTap: () => widget.onTap(),
                  btnText: 'Next',
                  margin: const EdgeInsets.all(0.0),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
