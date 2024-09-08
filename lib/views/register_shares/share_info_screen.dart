import 'dart:developer';
import 'dart:io';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:bursa_flutter/models/register_share_model.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../consts/color_const.dart';
import '../../consts/textstyle_const.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:http/http.dart' as http;

import '../../widgets/custom_button.dart';
import '../../widgets/custom_cached__neywork_image.dart';
import '../../widgets/register_share_row_text.dart';

class ShareInfoView extends StatefulWidget {
  ShareInfoView({Key? key, this.shareInfoData}) : super(key: key);

  RegisterShareInfo? shareInfoData;

  @override
  State<ShareInfoView> createState() => _ShareInfoViewState();
}

class _ShareInfoViewState extends State<ShareInfoView> {
  PDFDocument? ownershipDoc;
  File? companyInfoDoc;

  // PDFPage? ownershipPage;
  // PDFPage? companyInfoPage;
  bool isOwnershipDocLoading = true;
  bool isCompanyInfoDocLoading = true;
  bool veiwCertificate = false;

  void setVeiwCertificate(bool value) {
    veiwCertificate = value;
    setState(() {});
  }

  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  bool pdfReady1 = false;
  late PDFViewController _pdfViewController;

  bool isDownloading = false;
  Directory? directory;
  String urlPDFPath = "";

  bool isDownloading1 = false;
  Directory? directory1;
  String urlComapny = "";

  @override
  void initState() {
    super.initState();
    if (widget.shareInfoData!.shareOwnerShipDocument != null) {
      getFileFromUrl(widget.shareInfoData!.shareOwnerShipDocument.toString())
          .then((f) {
        setState(() {
          urlPDFPath = f.path;
          log("urlPDFPath" + urlPDFPath);
        });
      });
    }
    if (widget.shareInfoData!.companyInformationDocument != null) {
      getCompanyDocument(
              widget.shareInfoData!.companyInformationDocument.toString())
          .then((f) {
        setState(() {
          urlComapny = f.path;
          log("urlPDFPath" + urlComapny);
        });
      });
    }

    log("data ---- " + widget.shareInfoData!.toJson().toString());
  }

  Future<File> getFileFromUrl(String url) async {
    try {
      final Uri url = Uri.parse(widget.shareInfoData!.shareOwnerShipDocument!);
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonline.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  Future<File> getCompanyDocument(String url) async {
    try {
      final Uri url =
          Uri.parse(widget.shareInfoData!.companyInformationDocument!);
      var data = await http.get(url);
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdfonlines.pdf");

      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      throw Exception("Error opening url file");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
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
              left: width * .02, right: width * .0, top: height * .05),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => HomeScreen()));
                        // setVeiwCertificate(true);
                        Navigator.pop(context);
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
              Column(
                children: [
                  Container(
                    width: width * .94,
                    margin: EdgeInsets.only(
                      top: height * .02,
                    ),
                    padding: EdgeInsets.only(
                      bottom: height * .025,
                    ),
                    //width: width * .4,
                    // height: height * .76,
                    //width: width*.,
                    decoration: BoxDecoration(
                        color: white1,
                        borderRadius: BorderRadius.circular(width * .04)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //RegisterShareCircularImage(businessLogo: widget.shareInfoData!.businessLogo!,),
                        Container(
                          margin: EdgeInsets.only(
                            top: height * .02,
                            left: width * .36,
                          ),
                          height: height * .09,
                          width: width * .18,
                          decoration: BoxDecoration(
                              color: white1,
                              borderRadius: BorderRadius.circular(width * .09)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(width * .02),
                            child: FittedBox(
                                fit: BoxFit.fill,
                                child: widget.shareInfoData!.businessLogo ==
                                        null
                                    ? SvgPicture.asset(
                                        "assets/svgs/blankimg.svg")
                                    : CustomCachedNetworkImage(
                                        imageUrl:
                                            widget.shareInfoData!.businessLogo!,
                                      )),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: height * .01),
                            child: Text(
                              widget.shareInfoData!.companyName!,
                              style: poppinsRegular.copyWith(
                                  color: lightBlueColor,
                                  letterSpacing: 1,
                                  fontSize: width * .04,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: height * .015, right: width * .02),
                            height: height * .04,
                            width: width * .26,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(width * .05),
                                //  color: greenColor
                                //       .withOpacity(.5),
                                color:
                                    widget.shareInfoData!.verficationStatus ==
                                            "Pending"
                                        ? AppColors.yellowAccentColor
                                        : greenColor),
                            child: Center(
                                child: Text(
                              widget.shareInfoData!.verficationStatus
                                  .toString(),
                              style: AppStyles.registerSharesStatusText,
                            )),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegisterShareRowText(
                                marginLeft: 8,
                                marginTop: height * .045,
                                heading_1: "Type of grant",
                                value_1: widget.shareInfoData!.grantType ?? "-",
                                heading_2: "Equity Rounds",
                                value_2:
                                    widget.shareInfoData!.equityRound ?? "-"),
                            RegisterShareRowText(
                                marginLeft: 8,
                                marginTop: height * .015,
                                heading_1: "Debt Rounds",
                                value_1: widget.shareInfoData!.debtRound ?? "-",
                                heading_2: "Share Granted",
                                value_2:
                                    (widget.shareInfoData!.numberOfShares ??
                                            "-")
                                        .toString()),
                            RegisterShareRowText(
                              marginLeft: 8,
                              marginTop: height * .015,
                              // isGreen: true,
                              heading_1: "Request Date",
                              value_1: widget.shareInfoData!.dateOfGrant ?? "-",
                              heading_2: "Last Valuation",
                              value_2:
                                  widget.shareInfoData!.lastValuation != null
                                      ? widget.shareInfoData!.lastValuation!
                                                  .trim() !=
                                              ""
                                          ? widget.shareInfoData!.lastValuation!
                                          : "-"
                                      : "-",
                            ),
                            RegisterShareRowText(
                              marginLeft: 8,
                              marginTop: height * .015,
                              heading_1: "Grant Valuation",
                              value_1: widget.shareInfoData!.grantValuation !=
                                      null
                                  ? widget.shareInfoData!.grantValuation!
                                              .trim() !=
                                          ""
                                      ? widget.shareInfoData!.grantValuation!
                                      : "-"
                                  : "-",
                              heading_2: "Firstname",
                              value_2: widget.shareInfoData!.firstName ?? "-",
                            ),
                            RegisterShareRowText(
                                marginLeft: 8,
                                marginTop: height * .015,
                                heading_1: "Lastname",
                                value_1: "-",
                                heading_2: "Email Address",
                                value_2: widget.shareInfoData!.email ?? "-"),
                            RegisterShareRowText(
                                marginLeft: 8,
                                marginTop: height * .015,
                                heading_1: "Contact Person",
                                value_1:
                                    widget.shareInfoData!.phoneNumber ?? "-",
                                heading_2: "Investment value",
                                value_2: widget.shareInfoData!.sharePrice
                                    .toString()),
                            GestureDetector(
                              onTap: urlPDFPath.isEmpty
                                  ? () {
                                      Fluttertoast.showToast(
                                        msg: "No Attachments found ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: whiteColor,
                                        textColor: greenColor,
                                        fontSize: 15,
                                      );
                                    }
                                  : () {
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             PdfViewPage(path: urlPDFPath)));

                                      Get.dialog(
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                          color: Colors.transparent,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 14.0,
                                                vertical: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                              color: AppColors.white1,
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                    child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: height * .04),
                                                  height: height * .64,
                                                  width: width * .88,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .signBackColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              width * .025)),
                                                )),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * .04,
                                                      right: width * .04,
                                                      bottom: height * .04),
                                                  child: Center(
                                                    child: Container(
                                                      height: height * .58,
                                                      width: width * .8,
                                                      child: PDFView(
                                                        filePath: urlPDFPath,
                                                        autoSpacing: true,
                                                        enableSwipe: true,
                                                        pageSnap: true,
                                                        swipeHorizontal: true,
                                                        nightMode: false,
                                                        // defaultPage: 1,
                                                        onError: (e) {
                                                          log(e);
                                                        },
                                                        onRender: (_pages) {
                                                          setState(() {
                                                            _totalPages =
                                                                _pages!;
                                                            pdfReady = true;
                                                          });
                                                        },
                                                        onViewCreated:
                                                            (PDFViewController
                                                                vc) {
                                                          _pdfViewController =
                                                              vc;
                                                        },
                                                        onPageError: (page, e) {
                                                          log("error____>" +
                                                              e.toString());
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // urlPDFPath.isEmpty
                                                //     ? const Center(
                                                //         child:
                                                //             CircularProgressIndicator(),
                                                //       )
                                                //     : Offstage(),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: height * .05),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          "Ownership Document",
                                                          // widget.shareInfoData!.shareOwnerShipDocument!.createPath(),
                                                          //   _registerShareController
                                                          // .padf1File!.path
                                                          // .split("/")
                                                          // .last,
                                                          style: poppinsRegular
                                                              .copyWith(
                                                                  color:
                                                                      lightBlueColor,
                                                                  fontSize:
                                                                      width *
                                                                          .05,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      height *
                                                                          .02),
                                                          child: Column(
                                                            children: [
                                                              CustomButton(
                                                                onTap: isDownloading
                                                                    ? null
                                                                    : () async {
                                                                        log("Tapped ---- ");
                                                                        setState(
                                                                            () {
                                                                          isDownloading =
                                                                              true;
                                                                        });

                                                                        await savePdf(
                                                                            widget
                                                                                .shareInfoData!.shareOwnerShipDocument!,
                                                                            (widget.shareInfoData!.companyName! +
                                                                                "Onwership.pdf"));
                                                                      },
                                                                btnText:
                                                                    'Download PDF',
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        24.0),
                                                                borderColor:
                                                                    AppColors
                                                                        .greenColor,
                                                                btnTextColor:
                                                                    AppColors
                                                                        .greenColor,
                                                                btnColor:
                                                                    AppColors
                                                                        .white1,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      margin: EdgeInsets.only(top: height * .02),
                                                                      child: Text(
                                                                        "Back",
                                                                        style: poppinsRegular.copyWith(
                                                                            color:
                                                                                greenColor),
                                                                      )))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: width * .06,
                                    top: height * .04,
                                    right: width * .04),
                                height: height * .06,
                                width: width * .8,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius:
                                        BorderRadius.circular(width * .02),
                                    border: Border.all(
                                        width: 1, color: greenColor)),
                                child: Center(
                                    child: Text(
                                  "View Ownership Documentation",
                                  style: poppinsRegular.copyWith(
                                      color: greenColor,
                                      fontSize: width * .034),
                                )),
                              ),
                            ),
                            GestureDetector(
                              // onTap: (){
                              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterNext()));
                              // },
                              onTap: urlPDFPath.isEmpty
                                  ? () {
                                      Fluttertoast.showToast(
                                        msg: "No Attachments found ",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: whiteColor,
                                        textColor: greenColor,
                                        fontSize: 15,
                                      );
                                    }
                                  : () {
                                      Get.dialog(
                                        Material(
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                          color: Colors.transparent,
                                          child: Container(
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 14.0,
                                                vertical: 20.0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(11.0),
                                              color: AppColors.white1,
                                            ),
                                            child: Stack(
                                              children: <Widget>[
                                                Center(
                                                    child: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: height * .04),
                                                  height: height * .64,
                                                  width: width * .88,
                                                  decoration: BoxDecoration(
                                                      color: AppColors
                                                          .signBackColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              width * .025)),
                                                )),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: width * .04,
                                                      right: width * .04,
                                                      bottom: height * .04),
                                                  child: Center(
                                                    child: Container(
                                                      height: height * .58,
                                                      width: width * .8,
                                                      child: PDFView(
                                                        filePath: urlComapny,
                                                        autoSpacing: true,
                                                        enableSwipe: true,
                                                        pageSnap: true,
                                                        swipeHorizontal: true,
                                                        nightMode: false,
                                                        // defaultPage: 1,
                                                        onError: (e) {
                                                          log(e);
                                                        },
                                                        onRender: (_pages) {
                                                          setState(() {
                                                            _totalPages =
                                                                _pages!;
                                                            pdfReady1 = true;
                                                          });
                                                        },
                                                        onViewCreated:
                                                            (PDFViewController
                                                                vc) {
                                                          _pdfViewController =
                                                              vc;
                                                        },
                                                        onPageError: (page, e) {
                                                          log("error____>" +
                                                              e.toString());
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // urlPDFPath.isEmpty
                                                //     ? const Center(
                                                //         child:
                                                //             CircularProgressIndicator(),
                                                //       )
                                                //     : Offstage(),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: height * .05),
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Text(
                                                            "Company Information Document",
                                                            // widget.shareInfoData!.shareOwnerShipDocument!.createPath(),
                                                            //   _registerShareController
                                                            // .padf1File!.path
                                                            // .split("/")
                                                            // .last,
                                                            style: poppinsRegular
                                                                .copyWith(
                                                                    color:
                                                                        lightBlueColor,
                                                                    fontSize:
                                                                        width *
                                                                            .05,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      height *
                                                                          .02),
                                                          child: Column(
                                                            children: [
                                                              CustomButton(
                                                                onTap: isDownloading
                                                                    ? null
                                                                    : () async {
                                                                        log("Tapped ---- ");
                                                                        setState(
                                                                            () {
                                                                          isDownloading =
                                                                              true;
                                                                        });

                                                                        await savePdf(
                                                                            widget
                                                                                .shareInfoData!.companyInformationDocument!,
                                                                            (widget.shareInfoData!.companyName! +
                                                                                "Company_info.pdf"));
                                                                      },
                                                                btnText:
                                                                    'Download PDF',
                                                                margin: const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        24.0),
                                                                borderColor:
                                                                    AppColors
                                                                        .greenColor,
                                                                btnTextColor:
                                                                    AppColors
                                                                        .greenColor,
                                                                btnColor:
                                                                    AppColors
                                                                        .white1,
                                                              ),
                                                              GestureDetector(
                                                                  onTap: () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Container(
                                                                      margin: EdgeInsets.only(top: height * .02),
                                                                      child: Text(
                                                                        "Back",
                                                                        style: poppinsRegular.copyWith(
                                                                            color:
                                                                                greenColor),
                                                                      )))
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: width * .06,
                                    top: height * .02,
                                    right: width * .04),
                                height: height * .06,
                                width: width * .8,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius:
                                        BorderRadius.circular(width * .02),
                                    border: Border.all(
                                        width: 1, color: greenColor)),
                                child: Center(
                                    child: Text(
                                  "View Company Information Document",
                                  style: poppinsRegular.copyWith(
                                      color: greenColor,
                                      fontSize: width * .034),
                                )),
                              ),
                            )
                          ],
                        ),
                      ],
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

  Future<bool> savePdf(String url, String fileName) async {
    Dio dio = Dio();
    try {
      setState(() {
        isDownloading = true;
      });
      if (Platform.isAndroid) {
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
      log(e.toString());
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
