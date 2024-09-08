import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/views/auth/face_finger/finger/scan_failed_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../consts/app_images.dart';
import '../../../../consts/color_const.dart';
import '../../../../widgets/custom_button.dart';
import '../../../home_screen/home_screen.dart';

class AllSetDialog extends StatefulWidget {
  const AllSetDialog({Key? key}) : super(key: key);

  @override
  State<AllSetDialog> createState() => _AllSetDialogState();
}

class _AllSetDialogState extends State<AllSetDialog> {
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);
    _controller.init();
    _controller.loginNewUser().then((value) {
      if (value) {
        _controller.getUserInfo().then((value) {
          setState(() {
            isLoading = false;
          });
        });
      } else {
        Navigator.pop(context);
        Get.dialog(const ScanFailedDialog(), barrierDismissible: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: greenColor,
                ),
              )
            : Container(
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
                    SizedBox(height: height * 0.06),
                    Image.asset(AppImages.celebrateImage, height: width * .25),

                    /// Unsucessfull Access text
                    SizedBox(height: height * 0.06),
                    Text(
                      'You are all set !',
                      style: GoogleFonts.poppins().copyWith(
                        color: AppColors.lightBlueColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    /// This operation couldn’t be completed
                    SizedBox(height: height * 0.015),
                    Text(
                      'Your access is successfully authenticated .',
                      style: GoogleFonts.poppins().copyWith(
                        color: AppColors.greyColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    /// Retry button
                    SizedBox(height: height * 0.07),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: CustomButton(
                        onTap: () {
                          //Get.offAll(const PersisNavBar());
                          Get.offAll(const HomeScreen());
                        },
                        btnText: 'Next',
                      ),
                    ),

                    SizedBox(height: height * 0.05),
                  ],
                ),
              ),
      ),
    );
  }
}
