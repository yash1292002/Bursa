import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:bursa_flutter/consts/app_images.dart';
import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/models/getallIssues_share.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:bursa_flutter/widgets/loading_progress_widget.dart';
import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:io' as io;

class StepFourScreen extends StatefulWidget {
  StepFourScreen({Key? key, required this.onTap, this.shareInfosData})
      : super(key: key);
  VoidCallback onTap;
  IssueShareInfo? shareInfosData;

  @override
  State<StepFourScreen> createState() => _StepFourScreenState();
}

class _StepFourScreenState extends State<StepFourScreen> {
  bool isLoading = false;
  final GlobalKey<SfSignaturePadState> signatureGlobalKey = GlobalKey();
  void handleClearButtonPressed() {
    signatureGlobalKey.currentState!.clear();
    setState(() {
      _isSigned = false;
    });
  }

/*  void handleSaveButtonPressed() async {
    final data =
    await signatureGlobalKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Container(
                color: Colors.grey[300],
                child: Image.memory(bytes!.buffer.asUint8List()),
              ),
            ),
          );
        },
      ),
    );
  }*/

  bool _isSigned = false;
  bool _handleOnDrawStart() {
    setState(() {
      _isSigned = true;
    });
    return false;
  }

  @override
  void initState() {
    super.initState();
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(context, listen: false);
    _controller.getAllIssueshareCertificate().then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    IssueDigitalCertiController _issueDigitalCertiController =
        Provider.of<IssueDigitalCertiController>(context, listen: true);
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        color: AppColors.white1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: height * 0.05),
          Center(
            child: Text(
              'Please sign in the box',
              style: GoogleFonts.poppins().copyWith(
                color: AppColors.lightBlueColor,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              ),
            ),
          ),
          SizedBox(height: height * 0.02),
          Container(
            width: width,
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
            decoration: const BoxDecoration(
              color: AppColors.bluePadColor,
            ),
            child: SizedBox(
              height: height * 0.25,
              width: width,
              child: DottedBorder(
                strokeWidth: 0.5,
                color: AppColors.greyColor,
                borderType: BorderType.RRect,
                radius: const Radius.circular(11.0),
                dashPattern: const [4, 2],
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(11.0),
                  child: SfSignaturePad(
                      key: signatureGlobalKey,
                      backgroundColor: Colors.white,
                      strokeColor: Colors.black,
                      onDrawStart: _handleOnDrawStart,
                      minimumStrokeWidth: 1.0,
                      maximumStrokeWidth: 4.0),
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.016),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomButton(
                  btnWidth: 75.0,
                  btnHeight: 32.0,
                  btnColor: AppColors.white1,
                  btnText: 'Clear',
                  btnTextColor: AppColors.greyColor,
                  borderColor: AppColors.greyColor,
                  onTap: handleClearButtonPressed,
                ),
                // const Spacer(),
                // CustomButton(
                //   btnWidth: 75.0,
                //   btnHeight: 32.0,
                //   btnColor:
                //       _isSigned ? AppColors.darkblue1 : AppColors.greyColor,
                //   btnText: 'Save',
                //   btnTextColor: AppColors.white1,
                //   borderColor:
                //       _isSigned ? AppColors.darkblue1 : AppColors.greyColor,
                //   //onTap: handleSaveButtonPressed,
                //   onTap: _isSigned
                //       ? () async {
                //           ui.Image image =
                //               await signatureGlobalKey.currentState!.toImage();

                //           var pngByte = await image.toByteData(
                //               format: ui.ImageByteFormat.png);

                //           final tempDir = await getTemporaryDirectory();
                //           io.File file = await io.File(
                //                   '${tempDir.path}/${DateTime.now()}.png')
                //               .create();
                //           file.writeAsBytesSync(pngByte!.buffer.asInt8List());

                //           log(file.path.toString());
                //         }
                //       : null,
                // ),
              ],
            ),
          ),

          const Spacer(),

          /// Next Button with certificate dialog
          GestureDetector(
            onTap: isLoading
                ? null
                : () async {
                    setState(() {
                      isLoading = true;
                    });
                    final data = await signatureGlobalKey.currentState!
                        .toImage(pixelRatio: 3.0);
                    final bytes =
                        await data.toByteData(format: ui.ImageByteFormat.png);
                    // _isSigned?() async {
                    if (_isSigned) {
                      ui.Image image =
                          await signatureGlobalKey.currentState!.toImage();

                      var pngByte = await image.toByteData(
                          format: ui.ImageByteFormat.png);

                      final tempDir = await getTemporaryDirectory();
                      io.File file =
                          await io.File('${tempDir.path}/${DateTime.now()}.png')
                              .create();
                      file.writeAsBytesSync(pngByte!.buffer.asInt8List());

                      log(file.path.toString());
                      // } :null;
                      await _issueDigitalCertiController
                          .issueDigitalCertificate(file)
                          .then((value) {
                        print(value);
                        if (value) {
                          setState(() {
                            isLoading = false;
                          });
                          print({
                            _issueDigitalCertiController
                                .firstNameController.text,
                            // _issueDigitalCertiController.lastNameController.text,
                            _issueDigitalCertiController
                                .middleNameController.text,
                            _issueDigitalCertiController
                                .companyNameController.text,
                            _issueDigitalCertiController
                                .dateOfEmploymentController.text,
                            _issueDigitalCertiController
                                .shareNumberController.text,
                            _issueDigitalCertiController.certified.toString(),
                          });

                          Get.dialog(
                            WillPopScope(
                              onWillPop: () async {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    PageTransition(
                                      duration:
                                          const Duration(milliseconds: 300),
                                      reverseDuration:
                                          const Duration(milliseconds: 300),
                                      type: PageTransitionType.rightToLeft,
                                      child: const HomeScreen(),
                                    ),
                                    (route) => false);
                                return false;
                              },
                              child: Material(
                                borderRadius: BorderRadius.circular(11.0),
                                color: Colors.transparent,
                                child: Container(
                                  width: width,
                                  height: height,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(11.0),
                                    color: AppColors.white1,
                                  ),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: height * 0.036),

                                        /// celebrate image
                                        Center(
                                          child: Image.asset(
                                            AppImages.celebrateImage,
                                            height: width * .25,
                                          ),
                                          // child: Image.network(_issueDigitalCertiController.issueShareList),
                                        ),
                                        SizedBox(height: height * 0.012),

                                        /// congrats texts
                                        Center(
                                          child: Text(
                                            'Congrats, your certificate '
                                            '\nis ready !',
                                            textAlign: TextAlign.center,
                                            style:
                                                GoogleFonts.poppins().copyWith(
                                              fontSize: 16.0,
                                              color: AppColors.lightBlueColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: height * 0.016),

                                        /// certificate all details with signature
                                        Container(
                                          width: width,
                                          padding: const EdgeInsets.fromLTRB(
                                              8.0, 24.0, 8.0, 32.0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(11.0),
                                            // image: const DecorationImage(
                                            //   image: Svg(AppImages.certificateBack),
                                            //   fit: BoxFit.fill,
                                            // ),
                                          ),
                                          child: Column(
                                            children: [
                                              SizedBox(height: height * 0.03),
                                              Image.network(
                                                  _issueDigitalCertiController
                                                      .issueCertificate!
                                                      .returnData!
                                                      .certificateImageUrl!),
                                              SizedBox(height: height * 0.01),
                                            ],
                                          ),
                                        ),

                                        /// your certificate key text
                                        Center(
                                          child: Text(
                                            'Your Certificate Key',
                                            textAlign: TextAlign.center,
                                            style:
                                                GoogleFonts.poppins().copyWith(
                                              fontSize: 12.0,
                                              color: AppColors.lightBlueColor,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),

                                        SizedBox(height: height * 0.022),
                                        Container(
                                          height: 50.0,
                                          width: width,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                            color: AppColors.greenColor
                                                .withOpacity(0.1),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "0x078A2E8d4115d12795c4171142719Ed67589016C",
                                              style: GoogleFonts.poppins()
                                                  .copyWith(
                                                color: AppColors.greenColor,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ),
                                        ),

                                        /// issue additional certificate button
                                        SizedBox(height: height * 0.016),
                                        CustomButton(
                                          onTap: () {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                PageTransition(
                                                  duration: const Duration(
                                                      milliseconds: 300),
                                                  reverseDuration:
                                                      const Duration(
                                                          milliseconds: 300),
                                                  type: PageTransitionType
                                                      .rightToLeft,
                                                  child: const HomeScreen(),
                                                ),
                                                (route) => false);
                                          },
                                          btnText: 'Back to Home',
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                        ),

                                        /// download certificate button
                                        SizedBox(height: height * 0.016),
                                        CustomButton(
                                          onTap: isDownloading
                                              ? null
                                              : () async {
                                                  // setState(() {
                                                  //   isDownloading = true;
                                                  // });

                                                  await savePdf(
                                                      _issueDigitalCertiController
                                                          .issueCertificate!
                                                          .returnData!
                                                          .certificateImageUrl!,
                                                      (_issueDigitalCertiController
                                                              .issueCertificate!
                                                              .returnData!
                                                              .certificateKey! +
                                                          "Certificate.png"));

                                                  // Directory dir =
                                                  //     await getApplicationDocumentsDirectory();

                                                  // final taskId =
                                                  //     await FlutterDownloader.enqueue(
                                                  //   url: widget
                                                  //       .shareInfosData!.certificateUrl!,
                                                  //   savedDir: dir.path,
                                                  //   showNotification:
                                                  //       true, // show download progress in status bar (for Android)
                                                  //   openFileFromNotification:
                                                  //       true, // click on notification to open downloaded file (for Android)
                                                  // );
                                                },
                                          btnText: 'Download PDF',
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          borderColor: AppColors.greenColor,
                                          btnTextColor: AppColors.greenColor,
                                          btnColor: AppColors.white1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          log("alredy issue");
                        }
                        setState(() {
                          isLoading = false;
                        });
                      });
                    }
                    // : Fluttertoast.showToast(
                    //     msg: "Please Write your sign in the box",
                    //     toastLength: Toast.LENGTH_SHORT,
                    //     gravity: ToastGravity.BOTTOM,
                    //     timeInSecForIosWeb: 1,
                    //     backgroundColor: whiteColor,
                    //     textColor: greenColor,
                    //     fontSize: 15,
                    //   );
                  },
            // btnColor: _isSigned ? AppColors.greenColor : AppColors.greyColor2,
            // borderColor: _isSigned ? AppColors.greenColor : AppColors.greyColor2,
            // btnText: 'Next',
            // margin: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              height: width * .12,
              width: width * .8,
              margin: EdgeInsets.only(top: height * .14, left: width * 0.04),
              decoration: BoxDecoration(
                color: _isSigned ? AppColors.greenColor : AppColors.greyColor2,
                borderRadius: BorderRadius.all(Radius.circular(width * .02)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isLoading
                      ? Consumer<IssueDigitalCertiController>(
                          builder: (_, a, child) {
                            return Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Sending your request: ${a.fileUploadProgress}/100",
                                  style: poppinsRegular.copyWith(
                                    color: whiteColor,
                                    fontSize: width * .027,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 1,
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.all(5.0),
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 1,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          },
                          child: const LoadingProgressWidget(),
                        )
                      : Text(
                          "Next",
                          style: poppinsRegular.copyWith(
                            color: whiteColor,
                            fontSize: width * .04,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isDownloading = false;
  Directory? directory;
  Future<bool> savePdf(String url, String fileName) async {
    Dio dio = Dio();
    try {
      setState(() {
        isDownloading = true;
      });
      if (io.Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";
          print(directory);
          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath + "/Download";
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.storage)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory!.exists()) {
        await directory!.create(recursive: true);
      }
      if (await directory!.exists()) {
        File saveFile = File(directory!.path + "/$fileName");
        await dio.download(
          url,
          saveFile.path,
          onReceiveProgress: (value1, value2) {
            log('Receve: ${value1.toStringAsFixed(0)}');
            log('Total: ${value2.toStringAsFixed(0)}');
          },
          options: Options(
            contentType: 'Content-Type',
          ),
        );
        if (Platform.isIOS) {}
        return true;
      }
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isDownloading = false;
      });
      OpenFile.open(directory!.path + "/$fileName");
    }
    return false;
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }
}
