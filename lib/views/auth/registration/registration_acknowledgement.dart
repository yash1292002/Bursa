import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AcknowledgementScreen extends StatefulWidget {
  AcknowledgementScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;

  @override
  State<AcknowledgementScreen> createState() => _AcknowledgementScreenState();
}

class _AcknowledgementScreenState extends State<AcknowledgementScreen> {
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
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    AuthController _controller =
        Provider.of<AuthController>(context, listen: true);
    const String toLaunch = 'https://www.sharebursa.com/';
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  width * .03,
                ),
              ),
            ),
            padding: EdgeInsets.only(
              top: height * .02,
              bottom: height * .02,
              left: width * .05,
              right: width * .05,
            ),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/warningicon.png",
                  height: height * .07,
                  width: width * .18,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .005,
                    bottom: height * .005,
                  ),
                  child: Text("Risk Warning",
                      textAlign: TextAlign.center,
                      style: poppinsRegular.copyWith(
                        fontSize: width * .038,
                        color: brownColor,
                      )),
                ),
                // Text(
                //   "",
                //   style: poppinsRegular.copyWith(
                //     fontSize: width * .030,
                //     color: lightBlueColor,
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .012,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: RichText(
                          // textAlign: TextAlign.start,
                          text: TextSpan(children: [
                            TextSpan(
                              text:
                                  "Although Bursa is a platform addressing the challenges associated with private market investments, all users are required to acknowedge reading and understanding the below risk warnings.",
                              style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .032,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "\n\nTo know more about our risk management framework and relevant controls, please visit",
                              style: poppinsRegular.copyWith(
                                color: lightBlueColor,
                                fontSize: width * .030,
                              ),
                            ),
                            // TextSpan(
                            //   onEnter: (event) {
                            //     print("onEnter" + event.toString());
                            //   },
                            //   text: " www.weareburs.com/FAQ",
                            //   style: poppinsRegular.copyWith(
                            //     color: blueColor,
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: width * .030,
                            //   ),
                            // )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _launched = _launchInBrowser(toLaunch);
                        });
                      },
                      child: Text("www.sharebursa.com",
                          style: poppinsRegular.copyWith(
                            color: blueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: width * .030,
                          )),
                    ),
                  ],
                ),

                // child: Text(
                //   "To know more about our risk management framework and relevant controls, please visit www.weareburs.com/FAQ.",
                //   style: poppinsRegular.copyWith(
                //     fontSize: width * .030,
                //     color: lightBlueColor,
                //   ),
                // ),

                Container(
                  margin: EdgeInsets.only(
                    top: height * .012,
                    bottom: height * .01,
                  ),
                  child: Text(
                    "The risks associated with private market transactions include, but not limited to:",
                    style: poppinsRegular.copyWith(
                      fontSize: width * .030,
                      color: lightBlueColor,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: width * .03,
                      ),
                      child: Text(
                        "●",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .026,
                          color: greenColor1,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Loss of Capital: Listed transactions pertain to primary and secondary share offerings of startups and SMEs that have no or very little established track record, for which the observed failure rate is high.",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .030,
                          color: lightBlueColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            width: width,
            decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  width * .03,
                ),
              ),
            ),
            margin: EdgeInsets.only(
              top: height * .01,
            ),
            padding: EdgeInsets.only(
              top: height * .02,
              bottom: height * .02,
              left: width * .05,
              right: width * .05,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Consent & Acknowledgement",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .033,
                        color: lightBlueColor,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: width * .03, right: 0),
                      child: FlutterSwitch(
                        width: width * .1,
                        height: width * .05,
                        toggleSize: width * .04,
                        value: _controller.isconsent,
                        toggleColor: greenColor,
                        borderRadius: width * .03,
                        activeColor: greenColorWithOpacity20,
                        inactiveColor: lightGreyColor,
                        padding: width * .006,
                        onToggle: (val) {
                          _controller.setConsent(val);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .01,
                  ),
                  child: Text(
                    "I have read and understood all the risks set out in the risk warning that are associated with investing in private market transactions listed in Bursa’s platform.",
                    style: poppinsRegular.copyWith(
                      fontSize: width * .030,
                      color: const Color(0xff617996),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: _controller.isconsent ? widget.ontap : null,
                  child: Container(
                    height: width * .11,
                    margin: EdgeInsets.only(
                      top: height * .01,
                    ),
                    decoration: BoxDecoration(
                      color: _controller.isconsent ? greenColor : grey1Color,
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
        ],
      ),
    );
  }
}
