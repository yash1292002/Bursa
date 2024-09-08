import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:bursa_flutter/consts/app_const.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class DocumentScreen extends StatefulWidget {
  DocumentScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;

  @override
  State<DocumentScreen> createState() => _DocumentScreenState();
}

class _DocumentScreenState extends State<DocumentScreen> {
  Object setStatus(String s) => {setState(() => _status = s)};
  String _status = "Loading...";
  bool isReadingRfid = false;
  String rfidUIHeader = "Reading RFID";
  Color rfidUIHeaderColor = Colors.black;
  String rfidDescription = "Place your phone on top of the NFC tag";
  double rfidProgress = -1;
  String progressValue = "";
  bool isLoading = true;
  // var _portrait = Image.asset('assets/images/portrait.png');
  // var _docImage = Image.asset('assets/images/id.png');
  List<List<String>> _scenarios = [];
  String _selectedScenario = "Ocr";
  bool _canRfid = false;
  bool _doRfid = false;
  // ignore: prefer_function_declarations_over_variables
  var printError =
      (Object error) => log((error as PlatformException).message.toString());

  @override
  void initState() {
    AuthController _authController =
        Provider.of<AuthController>(context, listen: false);
    _authController.resetFrontImage();
    super.initState();
    initPlatformState();
    const EventChannel('flutter_document_reader_api/event/completion')
        .receiveBroadcastStream()
        .listen((jsonString) => handleCompletion(
            DocumentReaderCompletion.fromJson(json.decode(jsonString))!));
    const EventChannel('flutter_document_reader_api/event/database_progress')
        .receiveBroadcastStream()
        .listen((progress) {
      setStatus("Initalizing... " + progress + "%");
      setState(() {
        progressValue = progress;
      });
    });
    const EventChannel(
            'flutter_document_reader_api/event/rfid_notification_completion')
        .receiveBroadcastStream()
        .listen((event) =>
            log("rfid_notification_completion: " + event.toString()));
  }

  void addCertificates() async {
    List certificates = [];
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final certPaths = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith('assets/certificates'));

    for (var path in certPaths) {
      var findExt = path.split('.');
      var pkdResourceType = 0;
      if (findExt.length > 0)
        pkdResourceType =
            PKDResourceType.getType(findExt[findExt.length - 1].toLowerCase());
      ByteData byteData = await rootBundle.load(path);
      var certBase64 = base64.encode(byteData.buffer
          .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
      certificates
          .add({"binaryData": certBase64, "resourceType": pkdResourceType});
    }

    DocumentReader.addPKDCertificates(certificates)
        .then((value) => log("certificates added"));
  }

  void handleCompletion(DocumentReaderCompletion completion) {
    if (isReadingRfid &&
        (completion.action == DocReaderAction.CANCEL ||
            completion.action == DocReaderAction.ERROR)) hideRfidUI();
    if (isReadingRfid && completion.action == DocReaderAction.NOTIFICATION) {
      updateRfidUI(completion.results!.documentReaderNotification);
    }
    if (completion.action == DocReaderAction.COMPLETE) if (isReadingRfid) {
      if (completion.results!.rfidResult != 1) {
        restartRfidUI();
      } else {
        hideRfidUI();
        displayResults(completion.results!);
      }
    } else {
      handleResults(completion.results!);
    }

    // if (completion.action == DocReaderAction.ERROR) {
    //   log("Error ---- " );
    // }
  }

  void showRfidUI() {
    // show animation
    setState(() => isReadingRfid = true);
  }

  hideRfidUI() {
    // show animation
    restartRfidUI();
    DocumentReader.stopRFIDReader();
    setState(() {
      isReadingRfid = false;
      rfidUIHeader = "Reading RFID";
      rfidUIHeaderColor = Colors.black;
    });
  }

  restartRfidUI() {
    setState(() {
      rfidUIHeaderColor = Colors.red;
      rfidUIHeader = "Failed!";
      rfidDescription = "Place your phone on top of the NFC tag";
      rfidProgress = -1;
    });
  }

  updateRfidUI(results) {
    if (results.code ==
        eRFID_NotificationCodes.RFID_NOTIFICATION_PCSC_READING_DATAGROUP) {
      setState(() =>
          rfidDescription = eRFID_DataFile_Type.getTranslation(results.number));
    }
    setState(() {
      rfidUIHeader = "Reading RFID";
      rfidUIHeaderColor = Colors.black;
      rfidProgress = results.value / 100;
    });
    if (io.Platform.isIOS) {
      DocumentReader.setRfidSessionStatus(
          rfidDescription + "\n" + results.value.toString() + "%");
    }
  }

  customRFID() {
    showRfidUI();
    DocumentReader.readRFID();
  }

  usualRFID() {
    setState(() => _doRfid = false);
    DocumentReader.startRFIDReader();
  }

  Future<void> initPlatformState() async {
    log(await DocumentReader.prepareDatabase("Full"));
    setStatus("Initializing...");
    ByteData byteData = await rootBundle.load("assets/regula.license");
    log(await DocumentReader.initializeReader(base64.encode(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes))));
    setStatus("Ready");
    bool canRfid = await DocumentReader.isRFIDAvailableForUse();
    setState(() => _canRfid = canRfid);
    List<List<String>> scenarios = [];
    var scenariosTemp =
        json.decode(await DocumentReader.getAvailableScenarios());
    for (var i = 0; i < scenariosTemp.length; i++) {
      DocumentReaderScenario? scenario = DocumentReaderScenario.fromJson(
          scenariosTemp[i] is String
              ? json.decode(scenariosTemp[i])
              : scenariosTemp[i]);
      scenarios.add([scenario!.name!, scenario.caption!]);
    }
    setState(() => _scenarios = scenarios);

    log('Available scenarios ---- ' + _scenarios.toString());
    DocumentReader.setConfig({
      "functionality": {
        "videoCaptureMotionControl": true,
        "showCaptureButton": true
      },
      "customization": {
        "showResultStatusMessages": true,
        "showStatusMessages": true
      },
      "processParams": {"scenario": _selectedScenario}
    });
    DocumentReader.setRfidDelegate(RFIDDelegate.NO_PA);

    setState(() {
      isLoading = false;
    });
    // addCertificates();
  }

  displayResults(DocumentReaderResults results) async {
    AuthController _authController =
        Provider.of<AuthController>(context, listen: false);

    // setState(() {
    _authController.fullNameController.text = results.getTextFieldValueByType(
                eVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES) !=
            null
        ? results
            .getTextFieldValueByType(
                eVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES)
            .toString()
            .replaceAll("\n", " ")
        : "";

    // log("data ------ " +
    //     results
    //         .getTextFieldValueByType(
    //             eVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES)
    //         .toString()
    //         .replaceAll("\n", " "));

    log("results.getTextFieldValueByType(eVisualFieldType.FT_IDENTITY_CARD_NUMBER) ---- " +
        results
            .getTextFieldValueByType(eVisualFieldType.FT_IDENTITY_CARD_NUMBER)
            .toString());
    _authController.setEmiratedId(results
        .getTextFieldValueByType(eVisualFieldType.FT_IDENTITY_CARD_NUMBER)
        .toString());

    // _authController.selectedNationality  = NationalityInfo(name: results.getGraphicFieldImageByType(eVisualFieldType.FT_ADDRESS_COUNTRY)??"");

    // if (results.getGraphicFieldImageByType(201) != null) {
    //   // _authController.portrait( Image.memory(Uri.parse("data:image/png;base64," +
    //   //         results
    //   //             .getGraphicFieldImageByType(eGraphicFieldType.GF_PORTRAIT)!
    //   //             .replaceAll('\n', ''))
    //   //     .data!
    //   //     .contentAsBytes()));
    // }

    if (results.textResult!.fields.isNotEmpty) {
      for (var textField in results.textResult!.fields) {
        for (var value in textField!.values) {
          log(textField.fieldName! +
              ', value: ' +
              value!.value! +
              ', source: ' +
              value.sourceType.toString());
        }
      }
      if (results.getTextFieldValueByType(
              eVisualFieldType.FT_IDENTITY_CARD_NUMBER) !=
          null) {
        Uint8List imageInUnit8List = Uri.parse("data:image/png;base64," +
                results
                    .getGraphicFieldImageByType(
                        eGraphicFieldType.GF_DOCUMENT_IMAGE)!
                    .replaceAll('\n', ''))
            .data!
            .contentAsBytes(); // store unit8List image here ;
        final tempDir = await getTemporaryDirectory();
        io.File file =
            await io.File('${tempDir.path}/${DateTime.now()}.png').create();
        file.writeAsBytesSync(imageInUnit8List);

        _authController.setFrountImage(file);

        log("file ---- " + file.path);
        showConfirmDialog(_authController);
        // } else {
        //   showFailedDialog(_authController);
      }
    } else {
      showFailedDialog(_authController);
    }

    // });
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showConfirmDialog(AuthController _controller) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    showDialog(
        context: context,
        barrierDismissible: false,
        // barrierColor: darkGreyColorWithOpacity80,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(width * .02))),
            content: StatefulBuilder(builder: (context, setState) {
              return Container(
                height: height * .6,
                width: width,
                margin: EdgeInsets.only(
                  top: height * .01,
                  // bottom: height * .01,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        right: width * .02,
                        bottom: height * .01,
                      ),
                      child: Image.asset(
                        "assets/images/celebrationimage.png",
                        height: height * .1,
                        width: width * .4,
                      ),
                    ),
                    Text(
                      "You are all set !",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .046,
                        color: lightBlueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "Your ID Verfication is approved .  Please \npress next to continue",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .031,
                        color: greyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: height * .03,
                        bottom: height * .01,
                      ),
                      // child: Text(
                      //   "Identity Document",
                      //   style: poppinsRegular.copyWith(
                      //     fontSize: width * .033,
                      //     color: lightBlueColor,
                      //   ),
                      // ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffE6F6F4),
                          borderRadius: BorderRadius.all(
                            Radius.circular(width * .03),
                          ),
                          border: Border.all(
                            color: const Color(0xff00A295),
                            width: width * .002,
                          )),
                      padding: EdgeInsets.only(
                        top: height * .01,
                        bottom: height * .01,
                        left: width * .04,
                        right: width * .04,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xff00A295),
                                  shape: BoxShape.circle,
                                ),
                                padding: EdgeInsets.all(
                                  width * .005,
                                ),
                                child: Icon(
                                  Icons.done,
                                  size: width * .025,
                                  color: whiteColor,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  left: width * .03,
                                ),
                                child: Text(
                                  "Verfication Approved",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .03,
                                    color: const Color(0xff00A295),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: height * .01,
                            ),
                            height: height * .15,
                            width: width,
                            child: Image.file(
                              _controller.frontImage!,
                              fit: BoxFit.fill,
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        height: width * .11,
                        margin: EdgeInsets.only(
                          top: height * .053,
                        ),
                        decoration: BoxDecoration(
                          color: greenColor,
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
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: height * .02,
                      ),
                      // child: Text(
                      //   "Back to Scan",
                      //   style: poppinsRegular.copyWith(
                      //     fontSize: width * .037,
                      //     color: blueColor,
                      //   ),
                      // ),
                    )
                  ],
                ),
              );
            }),
          );
        }).then((value) {
      log(value.toString());
      if (value == true) {
        widget.ontap();
      }
    });
  }

  //// failed dialog
  void showFailedDialog(AuthController _controller) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        // barrierColor: darkGreyColorWithOpacity80,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(width * .02))),
            content: StatefulBuilder(builder: (context, setState) {
              return Container(
                height: height * .4,
                width: width,
                margin: EdgeInsets.only(
                  top: height * .01,
                  // bottom: height * .01,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                          right: width * .02,
                          bottom: height * .01,
                          top: height * .01),
                      child: Image.asset(
                        "assets/icons/failed.png",
                        height: height * .1,
                        width: width * .4,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * .02),
                      child: Text(
                        "Scan Unsucessful",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .046,
                          color: lightBlueColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * .03),
                      child: Text(
                        "Unable to read the document . Please \ntry again .",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .031,
                          color: greyColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, true);
                      },
                      child: Container(
                        height: width * .11,
                        margin: EdgeInsets.only(
                          top: height * .064,
                        ),
                        decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius:
                              BorderRadius.all(Radius.circular(width * .02)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Back to Scan",
                          style: poppinsRegular.copyWith(
                            color: whiteColor,
                            fontSize: width * .036,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: height * .02,
                      ),
                      // child: Text(
                      //   "Back to Scan",
                      //   style: poppinsRegular.copyWith(
                      //     fontSize: width * .037,
                      //     color: blueColor,
                      //   ),
                      // ),
                    )
                  ],
                ),
              );
            }),
          );
        });
    //     .then((value) {
    //   log(value.toString());
    //   if (value == true) {
    //     widget.ontap();
    //   }
    // });
  }

  void handleResults(DocumentReaderResults results) {
    if (_doRfid && results != null && results.chipPage != 0) {
      String? accessKey =
          results.getTextFieldValueByType(eVisualFieldType.FT_MRZ_STRINGS);
      if (accessKey != null && accessKey != "") {
        DocumentReader.setRfidScenario({
          "mrz": accessKey.replaceAll('^', '').replaceAll('\n', ''),
          "pacePasswordType": eRFID_Password_Type.PPT_MRZ,
        });
      } else if (results.getTextFieldValueByType(159) != null &&
          results.getTextFieldValueByType(159) != "") {
        DocumentReader.setRfidScenario({
          "password": results.getTextFieldValueByType(159),
          "pacePasswordType": eRFID_Password_Type.PPT_CAN
        });
      }

      // customRFID();
      usualRFID();
    } else {
      displayResults(results);
    }
  }

  void onChangeRfid(bool? value) {
    setState(() => _doRfid = value! && _canRfid);
    DocumentReader.setConfig({
      "processParams": {"doRfid": _doRfid}
    });
  }

  Widget _buildRow(int index) {
    Radio radio = Radio(
        value: _scenarios[index][0],
        groupValue: _selectedScenario,
        onChanged: (value) => setState(() {
              _selectedScenario = value;
              DocumentReader.setConfig({
                "processParams": {"scenario": _selectedScenario}
              });
            }));
    return Container(
        child: ListTile(
            title: GestureDetector(
                onTap: () => radio.onChanged!(_scenarios[index][0]),
                child: Text(_scenarios[index][1])),
            leading: radio),
        padding: const EdgeInsets.only(left: 40));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    AuthController _authController =
        Provider.of<AuthController>(context, listen: true);
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: width,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    width * .02,
                  ),
                ),
              ),
              padding: EdgeInsets.only(
                top: height * .015,
                left: width * .02,
                right: width * .02,
                bottom: height * .025,
              ),
              child: Column(
                children: [
                  Text(
                    "Emirates ID",
                    style: poppinsRegular.copyWith(
                      fontSize: width * .055,
                      color: lightBlueColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: height * .002,
                    ),
                    child: Text(
                      "Please scan your Emirates ID",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .035,
                        color: lightBlueColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: height * .02,
                      bottom: height * .03,
                    ),
                    child: Text(
                      "Kindly provide front and back  photos of your Emirates ID",
                      style: poppinsRegular.copyWith(
                        fontSize: width * .03,
                        color: greyColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  GestureDetector(
                    //onTap: widget.ontap,
                    onTap: () {
                      AuthController _authController =
                          Provider.of<AuthController>(context, listen: false);
                      _authController.emailController.clear();
                      _authController.phoneNumberController.clear();

                      _authController.fullNameController.clear();
                      _authController.birthofdateController.clear();
                      DocumentReader.setConfig({
                        "processParams": {"scenario": _selectedScenario}
                      });
                      DocumentReader.showScanner();
                      log("On TAp");
                    },

                    child: Container(
                      margin: EdgeInsets.only(
                        left: width * .02,
                        right: width * .02,
                      ),
                      child: DottedBorder(
                        color: greyColor,
                        strokeWidth: 0.5,
                        radius: Radius.circular(
                          width * .02,
                        ),
                        borderType: BorderType.RRect,
                        child: Container(
                          width: width,
                          height: height * .215,
                          padding: EdgeInsets.only(
                            top: height * .03,
                            left: width * .03,
                            right: width * .03,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                width * .02,
                              ),
                            ),
                            color: lightGreyColor2,
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/icons/scanicon.png",
                                width: width * .13,
                                height: width * .13,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: height * .04,
                                ),
                                child: Text(
                                  "Emirates ID",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .042,
                                    color: lightBlueColor,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: height * .01,
                                ),
                                child: Text(
                                  "Tap to scan your Emirates ID",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .03,
                                    color: lightBlueColor,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: width * .02,
                      right: width * .02,
                      top: height * .02,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: width * .02,
                          ),
                          child: Icon(
                            Icons.done,
                            size: width * .045,
                            color: greenColor,
                          ),
                        ),
                        Text(
                          "Place ID on contrasting background",
                          style: poppinsRegular.copyWith(
                            color: greyColor,
                            fontSize: width * .031,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: width * .02,
                      right: width * .02,
                      top: height * .02,
                    ),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            right: width * .02,
                          ),
                          child: Icon(
                            Icons.done,
                            size: width * .045,
                            color: greenColor,
                          ),
                        ),
                        Text(
                          "Avoid glare and shadows",
                          style: poppinsRegular.copyWith(
                            color: greyColor,
                            fontSize: width * .031,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: widget.ontap,
            //   child: Container(
            //     height: width * .11,
            //     margin: EdgeInsets.only(
            //       top: height * .025,
            //       bottom: height * .025,
            //     ),
            //     decoration: BoxDecoration(
            //       color: lightGreenColor,
            //       borderRadius: BorderRadius.all(Radius.circular(width * .02)),
            //     ),
            //     alignment: Alignment.center,
            //     child: Text(
            //       "Skip and go to dashboard",
            //       style: poppinsRegular.copyWith(
            //         color: whiteColor,
            //         fontSize: width * .036,
            //         fontWeight: FontWeight.w500,
            //         letterSpacing: 0.5,
            //       ),
            //     ),
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: width * .1, right: width * .1),
            //   child: Text(
            //     "By registering, you agree to the Terms & Conditions set by Bursa.",
            //     style: poppinsRegular.copyWith(
            //       fontSize: width * .031,
            //       color: whiteColor,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // this code is term and condition and privacy policy
            Container(
              margin: EdgeInsets.only(
                top: width * .118,
                left: width * .065,
                right: width * .065,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        "By completing your registration, you agree to the Terms & Conditions set by Bursa.",
                    style: poppinsRegular.copyWith(
                      fontSize: width * .032,
                      color: whiteColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        termcondition();
                      }),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: height * .008,
                left: width * .065,
                right: width * .065,
              ),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text:
                        "For more information on how we handle your personal data, please refer to our Privacy Policy.",
                    style: poppinsRegular.copyWith(
                      fontSize: width * .032,
                      color: whiteColor,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        privacypolicy();
                      }),
              ),
            ),
          ],
        ),
        isLoading
            ? Container(
                height: height,
                width: width,
                color: transparentColor,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          top: height * .015,
                          bottom: height * .015,
                          left: width * .03,
                          right: width * .03),
                      margin: EdgeInsets.only(
                        bottom: height * .01,
                      ),
                      decoration: BoxDecoration(
                          color: lightGreenColor,
                          borderRadius: BorderRadius.all(Radius.circular(
                            width * .01,
                          ))),
                      child: CircularProgressIndicator(
                        color: whiteColor,
                        // value: double.parse(progressValue),
                        // valueColor: AlwaysStoppedAnimation<Color>(blueColor),
                      ),
                    ),
                    Text(
                      _status.toString(),
                      style: poppinsRegular.copyWith(
                        fontSize: width * .05,
                        color: lightGreenColor,
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
      ],
    );
  }

  void privacypolicy() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * .02),
            topRight: Radius.circular(width * .02),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: height * .8,
            margin: EdgeInsets.only(
              top: height * .01,
              left: width * .06,
              right: width * .06,
            ),
            child: Column(
              children: [
                Container(
                  width: width * .3,
                  height: height * .002,
                  color: lightGreyColor,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .025,
                    bottom: height * .025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        "Privacy Policy",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .058,
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/closeicon.png",
                          height: width * .04,
                          width: width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1. FOREWORD",
                            style: poppinsRegular.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: width * .04),
                          ),
                          Text(
                            privacy1Policy[0]["text1"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "2. SCOPE AND PURPOSE OF THIS PRIVACY POLICY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text2"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "3. CATEGORIES OF PERSONAL DATA PROCESSED AND PURPOSES OF PROCESSING",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text3"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "4. DATA RECIPIENTS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text4"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "5. TRANSFERS OUTSIDE THE EUROPEAN ECONOMIC AREA",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text5"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "6. DATA RETENTION PERIODS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text6"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "7. YOUR RIGHTS AND OBLIGATIONS AS DATA SUBJECT",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text7"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "8. CONTACT DETAILS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            privacy1Policy[0]["text8"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          );
        });
  }

  /// this is use for term and condition
  void termcondition() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        backgroundColor: whiteColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * .02),
            topRight: Radius.circular(width * .02),
          ),
        ),
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: height * .8,
            margin: EdgeInsets.only(
              top: height * .01,
              left: width * .06,
              right: width * .06,
            ),
            child: Column(
              children: [
                Container(
                  width: width * .3,
                  height: height * .002,
                  color: lightGreyColor,
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .025,
                    bottom: height * .025,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Text(
                        "Terms & Conditions",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .058,
                          fontWeight: FontWeight.w600,
                          color: greenColor,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          "assets/icons/closeicon.png",
                          height: width * .04,
                          width: width * .04,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "1. INTRODUCTION",
                            style: poppinsRegular.copyWith(
                                color: AppColors.blackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: width * .04),
                          ),
                          Text(
                            terms1Condition[0]["text1"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "2. GENERAL SECURITIES LAW",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text2"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "3. USER OBLIGATIONS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text3"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "4. PRIVACY AND PROTECTION POLICY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text4"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "5. OWNERSHIP OF PLATFORM, SERVICES & CONTENT, INVESTOR QUESTIONNAIRE, SUBSCRIBTION AGREEMENTS AND ALLOCATION FORMS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text5"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "6. RESERVATION OF COMPANY RIGHTS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text6"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "7. SCOPE OF BURSA’S OBLIGATIONS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text7"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "8. TERM & TERMINATION",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text8"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "9. DISCLAIMERS, LIMITATIONS, WAIVERS OF LIABILITY",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text9"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "10. INDEMNIFICATION",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text10"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "11. MICELLENOUS",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text11"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: height * .04),
                              child: Text(
                                "12. DEFINITIONS, LISCENSE GRANT",
                                style: poppinsRegular.copyWith(
                                    color: AppColors.blackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: width * .04),
                              )),
                          Text(
                            terms1Condition[0]["text12"],
                            style: poppinsRegular.copyWith(
                              color: lightBlueColor,
                              fontSize: width * .035,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ]),
                  ),
                )
              ],
            ),
          );
        });
  }
}
