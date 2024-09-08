import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StepTwoScreen extends StatefulWidget {
  StepTwoScreen({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  // bool certified = false;
  // bool nonCertified = true;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(context, listen: true);
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
                Text(
                  'What kind of certificate you would like to issue ?',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins().copyWith(
                    color: AppColors.lightBlueColor,
                    fontSize: 16.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16.0),

                /// certified and non-certified button
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          // setState(() {
                          //   certified = true;
                          //   nonCertified = false;
                          // });
                          _controller.setCertified(true);
                          _controller.setNonCertified(false);
                        },
                        btnHeight: 40.0,
                        margin: const EdgeInsets.all(0.0),
                        btnText: 'Certified',
                        btnColor: _controller.certified == true
                            ? AppColors.darkblue1
                            : AppColors.white1,
                        btnTextColor: _controller.certified == true
                            ? AppColors.white1
                            : AppColors.lightGrey,
                        borderColor: _controller.certified == true
                            ? AppColors.darkblue1
                            : AppColors.lightGrey,
                        btnTextSize: 12.0,
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomButton(
                        onTap: () {
                          // setState(() {
                          // certified = false;
                          // nonCertified = true;
                          _controller.setCertified(false);
                          _controller.setNonCertified(true);

                          // });
                        },
                        btnHeight: 40.0,
                        margin: const EdgeInsets.all(0.0),
                        btnText: 'Non-Certified',
                        btnColor: _controller.nonCertified == true
                            ? AppColors.darkblue1
                            : AppColors.white1,
                        btnTextColor: _controller.nonCertified == true
                            ? AppColors.white1
                            : AppColors.lightGrey,
                        borderColor: _controller.nonCertified == true
                            ? AppColors.darkblue1
                            : AppColors.lightGrey,
                        btnTextSize: 12.0,
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
                          'Certified : ',
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 13.0,
                            color: AppColors.lightBlueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Requires pre-approval of the shares issuer (the company) as it '
                          'will have company logo and needs to be signed by atleast one '
                          'director. Certificated shares enable you to receive corporate '
                          'communications directly and use them as collateral at the same '
                          'time for borrowing purposes.',
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
                          'Non-Certified (also known as book entry) :',
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 13.0,
                            color: AppColors.lightBlueColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Refers to an investor’s ability to own different types of '
                          'securities without needing a physical certificate. '
                          'Instead, your interests in companies you invest in will be '
                          'recorded in book-entry form as a way of keeping track '
                          'of them and everyone else’s shares.'
                          '\n\nSo, when you need to trade them, the ownership will be '
                          'transferred in book form within Bursa platform without '
                          'necessitating the change in ownership via physical certificates. '
                          'Therefore, any stocks held in that manner are known as book '
                          'shares or book-entry form shares.',
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 11.0,
                            color: AppColors.greyColor2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        /// visit website
                        const SizedBox(height: 16.0),
                        Text(
                          'For a comparison between both types, please visit '
                          'our frequently asked questions page on '
                          '\nwww.wearebursa.com/FAQ. ',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins().copyWith(
                            fontSize: 11.0,
                            color: AppColors.blueColor2,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                ),
                CustomButton(
                  onTap: _controller.certified == true
                      ? () {
                          Get.dialog(
                            Material(
                              borderRadius: BorderRadius.circular(11.0),
                              color: Colors.transparent,
                              child: Container(
                                width: width,
                                height: height,
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 130.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11.0),
                                  color: AppColors.white1,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: height * 0.036),

                                      /// celebrate image
                                      Center(
                                        child: SvgPicture.asset(
                                          AppImages.errorImage,
                                          height: width * 0.25,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.012),

                                      /// error texts
                                      Center(
                                        child: Text(
                                          'We are really sorry, but we '
                                          '\ncant process your request as '
                                          '\nyour’shares issuer is not '
                                          '\nlisted with Bursa.',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins().copyWith(
                                            fontSize: 16.0,
                                            color: AppColors.lightBlueColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.05),

                                      /// details texts
                                      Center(
                                        child: Text(
                                          'You can still request non certified shares,'
                                          '\nand we will inform you as soon as your '
                                          '\nissuer signs up to our services.',
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.poppins().copyWith(
                                            fontSize: 14.0,
                                            color: AppColors.greyColor,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: height * 0.06),

                                      CustomButton(
                                        onTap: () {
                                          Get.back();
                                        },
                                        borderRadius: 80.0,
                                        btnText: 'Change certificate type',
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 24.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      : widget.onTap,
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
