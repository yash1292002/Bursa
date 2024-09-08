import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';

import 'package:flutter/material.dart';

class RegisterSharInfo1 extends StatefulWidget {
  const RegisterSharInfo1({Key? key}) : super(key: key);

  @override
  State<RegisterSharInfo1> createState() => _RegisterSharInfo1State();
}

class _RegisterSharInfo1State extends State<RegisterSharInfo1> {
  bool registershareInfo = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

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
          // height: height,
          // width: width,
          margin: EdgeInsets.only(
              left: width * .04, right: width * .02, top: height * .05),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        // setregisterGoback(true);
                      },
                      child: Image.asset(
                        "assets/icons/back_button.png",
                        height: height * .06,
                        width: width * .1,
                      )),
                  Container(
                    margin: EdgeInsets.only(left: width * .18),
                    child: Text(
                      "Register Shares",
                      style: poppinsRegular.copyWith(
                          color: white1,
                          fontWeight: FontWeight.w500,
                          fontSize: width * .048,
                          letterSpacing: .05),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
