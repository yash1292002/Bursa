import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:bursa_flutter/models/country_model.dart';
import 'package:bursa_flutter/models/nationalities_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressScreen extends StatefulWidget {
  AddressScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  // s();
  DateTime selectedDate = DateTime(2004);
  // String? nationality;
  // String? country;
  // List<String> nationalities = [
  //   "indian",
  //   "Dubaian",
  //   "Bangladeshi",
  //   "Nigerian",
  //   "Somali",
  // ];

  // List<String> countryList = [
  //   "India",
  //   "Dubai",
  //   "Bangladesh",
  //   "Nigeria",
  //   "America",
  // ];
  // bool isLoading = true;
  @override
  void initState() {
    AuthController _authController =
        Provider.of<AuthController>(context, listen: false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthController _authController =
        Provider.of<AuthController>(context, listen: true);
    return SingleChildScrollView(
      child: Container(
        height: height * .73,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.all(
            Radius.circular(
              width * .03,
            ),
          ),
        ),
        padding: EdgeInsets.only(
            top: height * .03,
            bottom: height * .03,
            left: width * .05,
            right: width * .05),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    "What is your nationality and permenant address ?",
                    style: poppinsRegular.copyWith(
                        color: lightBlueColor,
                        fontSize: width * .046,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: width * .08,
                    ),
                    width: width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: width * .002,
                          color: lightBlueColorWithopacity30,
                        ),
                      ),
                    ),
                    child: DropdownButton<CountryInfo>(
                      hint: Text(
                        "Country",
                        style: poppinsRegular.copyWith(
                          color: lightBlueColorWithopacity40,
                          fontSize: width * .04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: poppinsRegular.copyWith(
                        color: blackColor,
                        fontSize: width * .04,
                        // fontWeight: FontWeight.w500,
                      ),
                      isExpanded: true,
                      underline: Container(),
                      value: _authController.selectedCountry,
                      items: List.generate(_authController.countryList!.length,
                          (index) {
                        return DropdownMenuItem<CountryInfo>(
                            child: Text(
                              _authController.countryList![index].name!,
                              style: poppinsRegular.copyWith(
                                color: blackColor,
                                fontSize: width * .04,
                                //   fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: _authController.countryList![index]);
                      }),
                      onChanged: (value) {
                        _authController.setCountry(value);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: width * .1,
                    ),
                    width: width,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: width * .002,
                          color: lightBlueColorWithopacity30,
                        ),
                      ),
                    ),
                    child: DropdownButton<NationalityInfo>(
                      hint: Text(
                        "Nationality",
                        style: poppinsRegular.copyWith(
                          color: lightBlueColorWithopacity40,
                          fontSize: width * .04,
                          //fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: poppinsRegular.copyWith(
                        color: blackColor,
                        fontSize: width * .04,
                        fontWeight: FontWeight.w500,
                      ),
                      isExpanded: true,
                      underline: Container(),
                      value: _authController.selectedNationality,
                      items: List.generate(
                          _authController.nationalitiesList!.length, (index) {
                        return DropdownMenuItem<NationalityInfo>(
                            child: Text(
                              _authController.nationalitiesList![index].name!,
                              style: poppinsRegular.copyWith(
                                color: blackColor,
                                fontSize: width * .04,
                                // fontWeight: FontWeight.w500,
                              ),
                            ),
                            value: _authController.nationalitiesList![index]);
                      }),
                      onChanged: (value) {
                        // setState(() {
                        //   _authController.setNationality(value as String);
                        // });
                        _authController.setNationality(value);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: width * .08,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          style: poppinsRegular.copyWith(
                            color: blackColor,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                          ),
                          controller: _authController.cityNameController,
                          decoration: InputDecoration(
                            hintText: "City",
                            border: InputBorder.none,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lightBlueColorWithopacity40,
                              ),
                            ),
                            hintStyle: poppinsRegular.copyWith(
                              color: lightBlueColorWithopacity40,
                              fontSize: width * .04,
                              //  fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: lightBlueColorWithopacity30,
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: width * .08,
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          style: poppinsRegular.copyWith(
                            color: blackColor,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                          ),
                          onChanged: (text) {
                            setState(() {});
                          },
                          controller: _authController.addressNameController,
                          decoration: InputDecoration(
                            hintText: "Address",
                            border: InputBorder.none,
                            disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: lightBlueColorWithopacity40,
                              ),
                            ),
                            hintStyle: poppinsRegular.copyWith(
                              color: lightBlueColorWithopacity40,
                              fontSize: width * .04,
                              //  fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(
                          height: 1,
                          color: lightBlueColorWithopacity30,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: (_authController.selectedCountry != null &&
                        _authController.selectedNationality != null &&
                        _authController.cityNameController.text.isNotEmpty &&
                        _authController.addressNameController.text.isNotEmpty
                    ? () {
                        widget.ontap();
                        FocusScope.of(context).requestFocus(FocusNode());
                      }
                    : null),
                child: Container(
                  height: width * .11,
                  margin: EdgeInsets.only(
                    top: width * .1,
                  ),
                  decoration: BoxDecoration(
                    color: (_authController.selectedCountry != null &&
                            _authController.selectedNationality != null &&
                            _authController
                                .cityNameController.text.isNotEmpty &&
                            _authController
                                .addressNameController.text.isNotEmpty)
                        ? greenColor
                        : grey1Color,
                    borderRadius:
                        BorderRadius.all(Radius.circular(width * .02)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Next",
                    style: poppinsRegular.copyWith(
                      color: whiteColor,
                      fontSize: width * .036,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
