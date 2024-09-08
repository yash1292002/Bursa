import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../consts/color_const.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
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
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: transparentColor,

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
            ),

            body: SafeArea(
              child: Column(
                children: [
                  SizedBox(height: height * 0.13),
                  Container(
                    width: width,
                    margin: const EdgeInsets.symmetric(horizontal: 24.0),
                    padding: const EdgeInsets.fromLTRB(40.0, 60.0, 40.0, 40.0),
                    decoration: BoxDecoration(
                      color: AppColors.white1,
                      borderRadius: BorderRadius.circular(11.0),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Image.asset(AppImages.celebrateImage,
                              height: width * .25),
                        ),
                        SizedBox(height: height * 0.025),

                        /// congrats texts
                        Center(
                          child: Text(
                            'Thank you for submitting your \noffer request.',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 16.0,
                              color: AppColors.lightBlueColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(height: height * 0.04),

                        Center(
                          child: Text(
                            'Your request EOR-0001 will be reviewed by '
                            '\nour buy-side team and arrange to contact '
                            '\nyou within 48 hours. ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins().copyWith(
                              fontSize: 12.0,
                              color: AppColors.greyColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                        SizedBox(height: height * 0.093),
                        /* CustomButton(
                          onTap: (){
                            */ /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersisNavBar(),
                              ),
                            );*/ /*
                          },
                          btnColor: AppColors.greenColor1.withOpacity(0.1),
                          btnText: 'View Request Details',
                          btnTextColor: AppColors.greenColor,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          borderRadius: 10.0,
                          borderColor: AppColors.greenColor.withOpacity(0.1),
                        ),*/
                        CustomButton(
                          onTap: () {
                            /*Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersisNavBar(),
                              ),
                            );*/
                          },
                          btnColor: AppColors.greenColor1.withOpacity(0.1),
                          btnText: 'View Request Details',
                          btnTextColor: AppColors.greenColor,
                          margin: const EdgeInsets.symmetric(horizontal: 16.0),
                          borderRadius: 10.0,
                          borderColor: AppColors.greenColor.withOpacity(0.1),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Image.asset(AppImages.logoImage, height: height * 0.1),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
