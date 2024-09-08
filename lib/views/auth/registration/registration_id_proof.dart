// ignore_for_file: prefer_function_declarations_over_variables

import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;
import 'dart:typed_data';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/authcontroller.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_reader_api/document_reader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class IdProofScanScreen extends StatefulWidget {
  IdProofScanScreen({Key? key, required this.ontap}) : super(key: key);
  VoidCallback ontap;

  @override
  State<IdProofScanScreen> createState() => _IdProofScanScreenState();
}

class _IdProofScanScreenState extends State<IdProofScanScreen> {
  final ImagePicker _picker = ImagePicker();
  // File? _frontImage;
  // File? _backImage;
  late final ImageProvider img;

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
  var printError =
      (Object error) => log((error as PlatformException).message.toString());

  @override
  void initState() {
    AuthController _authController =
        Provider.of<AuthController>(context, listen: false);
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
    // _authController.firstNameController.text = results.getTextFieldValueByType(
    //         eVisualFieldType.FT_SURNAME_AND_GIVEN_NAMES) ??
    //     "";

    // log("results.getTextFieldValueByType(eVisualFieldType.FT_IDENTITY_CARD_NUMBER) ---- " +
    //     results
    //         .getTextFieldValueByType(eVisualFieldType.FT_IDENTITY_CARD_NUMBER)
    //         .toString());
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

    // if (results.textResult!.fields.isNotEmpty) {
    //   for (var textField in results.textResult!.fields) {
    //     for (var value in textField!.values) {
    //       log(textField.fieldName! +
    //           ', value: ' +
    //           value!.value! +
    //           ', source: ' +
    //           value.sourceType.toString());
    //     }
    //   }
    if (results
            .getGraphicFieldImageByType(eGraphicFieldType.GF_DOCUMENT_IMAGE) !=
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

      _authController.setBackImage(file);
      // showConfirmDialog(_authController);
    } else {
      // showFailedDialog(_authController);
    }
    // } else {
    //   // showFailedDialog(_authController);
    // }

    // });
    setState(() {});
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

  @override
  void dispose() {
    super.dispose();
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
            top: height * .02,
            bottom: height * .02,
            left: width * .05,
            right: width * .05),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: height * .015,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Front Side",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .042,
                          color: lightBlueColor,
                        ),
                      ),
                      _authController.frontImage != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  // _frontImage = null;
                                  //  _authController.setFrountImage(null);
                                  // _authController.setDocimg;
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: height * .007,
                                  bottom: height * .007,
                                  left: width * .04,
                                  right: width * .04,
                                ),
                                decoration: BoxDecoration(
                                  color: redColorWithOpacity10,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(width * .05),
                                  ),
                                ),
                                child: Text(
                                  "Delete",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .03,
                                    color: redColor,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await _picker
                        .pickImage(source: ImageSource.camera)
                        .then((value) {
                      if (value != null) {
                        setState(() {
                          // _frontImage = File(value.path);
                          _authController.setFrountImage(io.File(value.path));
                        });
                      }
                    });
                  },
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .02,
                            ),
                          ),
                          color: lightGreyColor2,
                        ),
                        child: _authController.frontImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    width * .02,
                                  ),
                                ),
                                child: Image.file(
                                  _authController.frontImage!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Center(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: width * .09,
                                  color: greenColor,
                                ),
                              )),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: height * .018,
                    bottom: height * .008,
                  ),
                  child: Divider(
                    color: greyColor,
                    thickness: width * .0005,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    bottom: height * .015,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Back Side",
                        style: poppinsRegular.copyWith(
                          fontSize: width * .042,
                          color: lightBlueColor,
                        ),
                      ),
                      _authController.backImage != null
                          ? GestureDetector(
                              onTap: () {
                                setState(() {
                                  _authController.setBackImage(null);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: height * .007,
                                  bottom: height * .007,
                                  left: width * .04,
                                  right: width * .04,
                                ),
                                decoration: BoxDecoration(
                                  color: redColorWithOpacity10,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(width * .05),
                                  ),
                                ),
                                child: Text(
                                  "Delete",
                                  style: poppinsRegular.copyWith(
                                    fontSize: width * .03,
                                    color: redColor,
                                  ),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // await _picker
                    //     .pickImage(source: ImageSource.camera)
                    //     .then((value) {
                    //   if (value != null) {
                    //     setState(() {
                    //       // _backImage = File(value.path);
                    //       _authController.setBackImage(File(value.path));
                    //     });
                    //   }
                    // });

                    DocumentReader.setConfig({
                      "processParams": {"scenario": _selectedScenario}
                    });
                    DocumentReader.showScanner();
                  },
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              width * .02,
                            ),
                          ),
                          color: lightGreyColor2,
                        ),
                        child: _authController.backImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    width * .02,
                                  ),
                                ),
                                child: Image.file(
                                  _authController.backImage!,
                                  fit: BoxFit.fill,
                                ),
                              )
                            : Center(
                                child: Icon(
                                  Icons.camera_alt_rounded,
                                  size: width * .09,
                                  color: greenColor,
                                ),
                              )),
                  ),
                ),
              ],
            ),
            GestureDetector(
              // onTap: widget.ontap,
              onTap: () async {
                if (_authController.frontImage != null &&
                    _authController.backImage != null) {
                  // showConfirmDialog();
                  widget.ontap();
                  log("Tapped");

                  // var result = base64Encode(
                  //     _authController.frontImage!.readAsBytesSync());
                  // // setState(() {});
                  // try {
                  //   await docReader.DocumentReader.recognizeImages(result)
                  //       .then((value) {
                  //     log(value.toString());
                  //     log("Done --- ");
                  //   }).onError((error, stackTrace) {
                  //     log(error.toString());
                  //   });
                  // } catch (e) {
                  //
                  //   log(e.toString());
                  // }
                } else {
                  Fluttertoast.showToast(
                    msg: "Please select images first",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: whiteColor,
                    textColor: greenColor,
                    fontSize: width * .035,
                  );
                }
              },
              child: Container(
                height: width * .11,
                margin: EdgeInsets.only(
                  top: height * .023,
                ),
                decoration: BoxDecoration(
                  color: greenColor,
                  borderRadius: BorderRadius.all(Radius.circular(width * .02)),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Submit",
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
    );
  }
}
