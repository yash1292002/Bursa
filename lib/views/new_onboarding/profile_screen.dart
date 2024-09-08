import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/controllers/profileController.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    AuthController _controller =
        Provider.of<AuthController>(context, listen: false);
    ProfileController _profileController =
        Provider.of<ProfileController>(context, listen: false);
    _profileController.setUserDetail(_controller.userDetail!);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    ProfileController _controller =
        Provider.of<ProfileController>(context, listen: true);
    AuthController _controller1 =
        Provider.of<AuthController>(context, listen: true);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            blueColor,
            greenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: transparentColor,
        body: Container(
          margin: EdgeInsets.only(
            left: width * .04,
            right: width * .02,
            top: height * .05,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushAndRemoveUntil(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeScreen()),
                        //     (route) => false);
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        "assets/icons/back_button.png",
                        height: height * .06,
                        width: width * .1,
                      )),
                  Container(
                    margin: EdgeInsets.only(left: width * .15),
                    child: Text(
                      "Investor Details",
                      textAlign: TextAlign.center,
                      style: poppinsRegular.copyWith(
                          color: white1,
                          fontWeight: FontWeight.w500,
                          fontSize: width * .048,
                          letterSpacing: .05),
                    ),
                  ),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.only(top: height * .02),
              //   decoration: BoxDecoration(
              //       color: greenColor1,
              //       borderRadius: BorderRadius.circular(width * .04)),
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: EdgeInsets.only(
              //           top: height * .01,
              //           left: width * .02,
              //           right: width * .005,
              //         ),
              //         child: Image.asset(
              //           "assets/icons/right.png",
              //           height: height * .055,
              //         ),
              //       ),
              //       Container(
              //           margin: EdgeInsets.only(
              //               top: height * .025,
              //               bottom: height * .025,
              //               left: width * .02,
              //               right: width * .02),
              //           child: Text(
              //             "Your Onbarord Request is approved",
              //             style: poppinsRegular.copyWith(
              //                 color: whiteColor,
              //                 fontSize: width * .035,
              //                 fontWeight: FontWeight.w500),
              //           )),
              //       Icon(
              //         Icons.close,
              //         size: width * .05,
              //         color: lightgreen,
              //       )
              //     ],
              //   ),
              // ),
              Expanded(
                child: Container(
                  margin:
                      EdgeInsets.only(top: height * .02, bottom: height * .02),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(width * .03),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(top: height * .02),
                            child: Text(
                              "Personal Details",
                              style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .045,
                                  fontWeight: FontWeight.w600),
                            )),

                        //=================== first name =========================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Full Name",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.firstNameController,
                                decoration: InputDecoration(
                                  hintText: "Full Name",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //==================email Address=============================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Email Address",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.emailController,
                                decoration: InputDecoration(
                                  hintText: "Email Address",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///=========================date of birth ===========================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Birth Of Date",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              Container(
                                margin: EdgeInsets.only(top: width * .0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      child: SizedBox(
                                        height: 50.0,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                DateFormat("dd MMM yyyy").format(
                                                    DateTime.parse(_controller
                                                        .dateOfBirthController
                                                        .text)),
                                                style: poppinsRegular.copyWith(
                                                  color: lightBlueColor,
                                                  fontSize: width * .04,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // Container(
                                    //     height: 1, color: lightBlueColorWithopacity20)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          height: 1,
                          color: lightBlueColorWithopacity20,
                        ),
                        //================================Mobile Number ==============================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: height * .01),
                                child: Text(
                                  "Mobile Number",
                                  style: poppinsRegular.copyWith(
                                      color: lightBlueColor.withOpacity(.7)),
                                ),
                              ),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  // fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.phoneController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                decoration: InputDecoration(
                                  // // contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    width: width * .14,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(
                                            left: width * .02,
                                          ),
                                          child: Text(
                                            '+971',
                                            style: poppinsRegular.copyWith(
                                              color: lightBlueColor,
                                              fontSize: width * .04,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  hintText: "Phone Number",
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.zero,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //===========================Country ====================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: height * .01),
                                child: Text(
                                  "Country",
                                  style: poppinsRegular.copyWith(
                                      color: lightBlueColor.withOpacity(.7)),
                                ),
                              ),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  // fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.countryController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                decoration: InputDecoration(
                                  // // contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    width: width * .1,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/dubai.png",
                                          height: height * .04,
                                          // width: width * .8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  hintText: "Country",
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.zero,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //===========================Nationality ====================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: height * .01),
                                child: Text(
                                  "Nationality",
                                  style: poppinsRegular.copyWith(
                                      color: lightBlueColor.withOpacity(.7)),
                                ),
                              ),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  // fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.nationalityController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(9),
                                ],
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        signed: true, decimal: true),
                                decoration: InputDecoration(
                                  // // contentPadding: EdgeInsets.zero,
                                  prefixIcon: Container(
                                    width: width * .1,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/images/dubai.png",
                                          height: height * .04,
                                          // width: width * .8,
                                        ),
                                      ],
                                    ),
                                  ),
                                  hintText: "Nationality",
                                  border: InputBorder.none,
                                  // contentPadding: EdgeInsets.zero,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ================================= city ==================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "City",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.cityNameController,
                                decoration: InputDecoration(
                                  hintText: "City",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ================================= city ==================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Address",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.addressController,
                                decoration: InputDecoration(
                                  hintText: "Address",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //================================= Employement & Income ========================
                        Container(
                          margin: EdgeInsets.only(
                              top: height * .03, bottom: height * .03),
                          child: Text(
                            "Employement & Income",
                            style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .045,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        //==================================== Emplyoed status
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Employement Status",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                enabled: false,
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                controller:
                                    _controller.employementStatusController,
                                decoration: InputDecoration(
                                  hintText: "Employement",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //================+++Annual Income =========================================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Annual Income",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.incomeController,
                                decoration: InputDecoration(
                                  hintText: "100,000",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ///==================================== Employer Name ================

                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Employer Name",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.employernameController,
                                decoration: InputDecoration(
                                  hintText: "Employer Name",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //====================================== date of employement ====================================
                        Container(
                          margin: EdgeInsets.only(
                            left: width * .04,
                            right: width * .04,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Date Of Employement",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              Container(
                                margin: EdgeInsets.only(top: width * .0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      child: SizedBox(
                                        height: 50.0,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                DateFormat("dd MMM yyyy").format(
                                                    DateTime.parse(_controller
                                                        .dateOfBirthController
                                                        .text)),
                                                style: poppinsRegular.copyWith(
                                                  color: lightBlueColor,
                                                  fontSize: width * .04,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1,
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //=================================Education & Experience ======================================
                        Container(
                          margin: EdgeInsets.only(
                              top: height * .03, bottom: height * .03),
                          child: Text(
                            "Education & Experience",
                            style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .045,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        //====================================  Employed Status =================================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Employment Status",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor.withOpacity(.7)),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller:
                                    _controller.employesStatusController,
                                decoration: InputDecoration(
                                  hintText: "Employed",
                                  border: InputBorder.none,
                                  disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: lightBlueColorWithopacity20,
                                    ),
                                  ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //==============================================prior  Experience ===================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .04),
                                  child: Text(
                                    "Do you have prior experience investing in equity or debt transactions?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: _controller1
                                              .userDetail!.havePriorExpirence ==
                                          true
                                      ? greenColor
                                      : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.experience,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!
                                                    .havePriorExpirence ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "Prior Experience",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //========================================= traning ================================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Did you attend or obtain any tranining regarding investment in private or public markets ?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color:
                                      _controller1.userDetail!.haveTraining ==
                                              true
                                          ? greenColor
                                          : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.training,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!.haveTraining ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "Traning",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ========================================work Experience===========

                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Do you have more than 5 years of professional work experience ?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color:
                                      _controller1.userDetail!.haveExperience ==
                                              true
                                          ? greenColor
                                          : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.moreExperience,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!
                                                    .haveExperience ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "Employed",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        //==============================Additional Information=======================

                        Container(
                          margin: EdgeInsets.only(
                              top: height * .03, bottom: height * .03),
                          child: Text(
                            "Additional Information",
                            style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .045,
                                fontWeight: FontWeight.w600),
                          ),
                        ),

                        //==============================================Citizen===================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Are you a U.S Citizen or have any U.S dealings ?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: _controller1.userDetail!.isUsCitizen ==
                                          true
                                      ? greenColor
                                      : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.citizen,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!.isUsCitizen ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "Citizen",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //========================================= public sector ================================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Do you currently work in the public sector or a first degree relative of someone holding a prominant public position ?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: _controller1.userDetail!
                                              .isPublicSectorEmployee ==
                                          true
                                      ? greenColor
                                      : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.publicSector,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!
                                                    .isPublicSectorEmployee ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "public Sector",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // ========================================indivisual ===========

                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Are you investing funds on behalf of a company or another indivisual ?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color:
                                      _controller1.userDetail!.isIndividual ==
                                              true
                                          ? greenColor
                                          : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.indivisual,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!.isIndividual ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "indivisual",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //=============================================== Criminal Record ============================
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Have you been connected to criminal activity, or been convicted as a criminal  ?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color: _controller1
                                              .userDetail!.haveCriminalRecord ==
                                          true
                                      ? greenColor
                                      : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.criminal,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!
                                                    .haveCriminalRecord ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "Criminal Record",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(top: height * .01),
                                  child: Text(
                                    "Are part of any criminal organization involved in money laundering, human or weapon trafficing?",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .035,
                                        color: lightBlueColor),
                                  )),
                              TextFormField(
                                style: poppinsRegular.copyWith(
                                  color:
                                      _controller1.userDetail!.haveConvicted ==
                                              true
                                          ? greenColor
                                          : lightBlueColor,
                                  fontSize: width * .038,
                                  fontWeight: FontWeight.w500,
                                ),
                                enabled: false,
                                controller: _controller.convicated,
                                decoration: InputDecoration(
                                  prefixIcon: Container(
                                    width: width * .05,
                                    height: height * .05,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(width * .08)),
                                    child: Row(
                                      children: [
                                        _controller1.userDetail!
                                                    .haveConvicted ==
                                                true
                                            ? Icon(
                                                Icons.done,
                                                color: greenColor,
                                              )
                                            : Icon(
                                                Icons.close,
                                                color: lightBlueColor,
                                              )
                                      ],
                                    ),
                                  ),
                                  hintText: "Conviceted",
                                  border: InputBorder.none,
                                  disabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none
                                      // borderSide: BorderSide(
                                      //   color: lightBlueColorWithopacity20,
                                      // ),
                                      ),
                                  hintStyle: poppinsRegular.copyWith(
                                    color: lightBlueColorWithopacity40,
                                    fontSize: width * .04,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //===================================== Profile Verification ========================
                        Container(
                          margin: EdgeInsets.only(
                              top: height * .03, bottom: height * .03),
                          child: Text(
                            "Profile Verification",
                            style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .045,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04, right: width * .04),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: height * .01, bottom: height * .01),
                                  child: Text(
                                    "Front Side",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .04,
                                        fontWeight: FontWeight.w600,
                                        color: lightBlueColor),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * .08)),
                                  child: Image.network(
                                    _controller.frontImg!,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04,
                              right: width * .04,
                              top: height * .04,
                              bottom: height * .02),
                          height: 1,
                          color: lightgreenColor,
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              left: width * .04,
                              right: width * .04,
                              bottom: height * .15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      top: height * .01, bottom: height * .01),
                                  child: Text(
                                    "Back Side",
                                    style: poppinsRegular.copyWith(
                                        fontSize: width * .04,
                                        fontWeight: FontWeight.w600,
                                        color: lightBlueColor),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(width * .04)),
                                  child: Image.network(
                                    _controller.backImg!,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 300),
                  reverseDuration: const Duration(milliseconds: 300),
                  type: PageTransitionType.rightToLeft,
                  child: const HomeScreen(),
                ),
                (route) => false);
          },
          child: Container(
            margin: EdgeInsets.only(
              bottom: height * .025,
              left: width * .02,
              top: height * .02,
            ),
            height: height * .07,
            width: width * .88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              // color: lightBlueColor,
              borderRadius: BorderRadius.circular(08),
              color: greenColor1,
              border: Border.all(
                color: AppColors.whiteColor.withOpacity(0.1),
                // width: 1,
              ),
            ),
            child: Text(
              "Back",
              style: poppinsRegular.copyWith(
                  fontSize: width * .036,
                  fontWeight: FontWeight.w500,
                  color: whiteColor),
            ),
          ),
        ),
      ),
    );
  }
}
