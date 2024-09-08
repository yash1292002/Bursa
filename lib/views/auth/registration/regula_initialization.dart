import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/views/auth/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';

class RegulaInitializationScreen extends StatefulWidget {
  const RegulaInitializationScreen({Key? key}) : super(key: key);

  @override
  State<RegulaInitializationScreen> createState() =>
      _RegulaInitializationScreenState();
}

class _RegulaInitializationScreenState
    extends State<RegulaInitializationScreen> {
  Object setStatus(String s) => {setState(() => _status = s)};
  String _status = "Loading... Please wait \nYou are almost there....";
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
  var printError =
      (Object error) => print((error as PlatformException).message);

  @override
  void initState() {
    // _authController.resetFrontImage();
    super.initState();
    initPlatformState();
    const EventChannel('flutter_document_reader_api/event/completion')
        .receiveBroadcastStream()
        .listen((jsonString) => handleCompletion(
            DocumentReaderCompletion.fromJson(json.decode(jsonString))!));
    const EventChannel('flutter_document_reader_api/event/database_progress')
        .receiveBroadcastStream()
        .listen((progress) {
      setStatus(
          "Loading... Please wait \nYou are almost there...." + progress + "%");

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
    print(await DocumentReader.prepareDatabase("Full"));
    setStatus("Loading... Please wait \nYou are almost there....");
    ByteData byteData = await rootBundle.load("assets/regula.license");
    print(await DocumentReader.initializeReader(base64.encode(byteData.buffer
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
    // setState(() {
    // _authController.fullNameController.text = results.getTextFieldValueByType(
    //             eVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES) !=
    //         null
    //     ? results
    //         .getTextFieldValueByType(
    //             eVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES)
    //         .toString()
    //         .replaceAll("\n", " ")
    //     : "";

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
    // _authController.setEmiratedId(results
    //     .getTextFieldValueByType(eVisualFieldType.FT_IDENTITY_CARD_NUMBER)
    //     .toString());

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
      //   if (results.getTextFieldValueByType(
      //           eVisualFieldType.FT_IDENTITY_CARD_NUMBER) !=
      //       null) {
      //     Uint8List imageInUnit8List = Uri.parse("data:image/png;base64," +
      //             results
      //                 .getGraphicFieldImageByType(
      //                     eGraphicFieldType.GF_DOCUMENT_IMAGE)!
      //                 .replaceAll('\n', ''))
      //         .data!
      //         .contentAsBytes(); // store unit8List image here ;
      //     final tempDir = await getTemporaryDirectory();
      //     io.File file =
      //         await io.File('${tempDir.path}/${DateTime.now()}.png').create();
      //     file.writeAsBytesSync(imageInUnit8List);

      //     _authController.setFrountImage(file);

      //     log("file ---- " + file.path);
      //     showConfirmDialog(_authController);
      //     // } else {
      //     //   showFailedDialog(_authController);
      //   }
      // } else {
      //   showFailedDialog(_authController);
      // }

      // // });
      // setState(() {});
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return isLoading
        ? Container(
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
              body: SafeArea(
                  child: Container(
                margin: EdgeInsets.only(left: width * .04, right: width * .04),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: width * .05,
                        ),
                        child: Image.asset("assets/images/logo.png",
                            width: width * 0.53),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // CircularProgressIndicator(),
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
                                // color: lightGreenColor,
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
                              color: whiteColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )),
            ),
          )
        : const RegistrationScreen();
  }
}
