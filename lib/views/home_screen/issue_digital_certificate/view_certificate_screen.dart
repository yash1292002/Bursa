import 'dart:developer';
import 'dart:io';

import 'package:bursa_flutter/consts/color_const.dart';
import 'package:bursa_flutter/controllers/issue_digital_controller.dart';
import 'package:bursa_flutter/models/getallIssues_share.dart';
import 'package:bursa_flutter/models/register_share_model.dart';
import 'package:bursa_flutter/views/home_screen/home_screen.dart';
import 'package:bursa_flutter/views/home_screen/issue_digital_certificate/register_certificate/register_certificate_screen.dart';
import 'package:bursa_flutter/widgets/custom_button.dart';
import 'package:bursa_flutter/widgets/small_chip_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../consts/app_images.dart';
import '../../../consts/textstyle_const.dart';
import 'components/card_texts_widget.dart';

class ViewCertificateScreen extends StatefulWidget {
  ViewCertificateScreen({Key? key, this.shareInfosData, this.registerInfoData})
      : super(key: key);
  IssueShareInfo? shareInfosData;
  RegisterShareInfo? registerInfoData;

  @override
  State<ViewCertificateScreen> createState() => _ViewCertificateScreenState();
}

class _ViewCertificateScreenState extends State<ViewCertificateScreen> {
  bool isDownloading = false;
  Directory? directory;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // RegisterShareController _controller=Provider.of<RegisterShareController>(context,listen: true);
    IssueDigitalCertiController _controller =
        Provider.of<IssueDigitalCertiController>(context, listen: true);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.blueColor,
            AppColors.greenColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: AppColors.transparentColor,

        /// Appbar
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leadingWidth: 60.0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image.asset('assets/icons/back_button.png'),
            ),
          ),
          centerTitle: true,
          title: Text(
            "View Certificate",
            style: poppinsRegular.copyWith(
              color: AppColors.white1,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
            ),
          ),
        ),

        /// body
        ///

        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 24.0),
              Container(
                width: width,
                padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 64.0),
                margin: const EdgeInsets.symmetric(horizontal: 24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: AppColors.white1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// logo image
                    Container(
                      margin: EdgeInsets.only(
                        top: height * .02,
                        // left: width * .3,
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
                          child: Image.network(
                            widget.registerInfoData!.businessLogo.toString(),
                            errorBuilder: (context, error, stackTrace) {
                              return SvgPicture.asset(AppImages.blankImg);
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    /// company name
                    Text(
                      widget.registerInfoData!.companyName!,
                      style: GoogleFonts.poppins().copyWith(
                        fontSize: 16.0,
                        color: AppColors.lightBlueColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    /// chip row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SmallChip(
                            onTap: () {},
                            chipText: widget.registerInfoData!.verficationStatus
                                .toString()),
                        const SizedBox(width: 4.0),
                        SmallChip(
                          onTap: () {},
                          chipText: 'Non-Certified',
                          chipColor: AppColors.lightBlue1,
                        ),
                      ],
                    ),

                    SizedBox(height: height * 0.06),

                    /// name and date of birth row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CardTextsWidget(
                              titleText: 'Name',
                              descText:
                                  widget.shareInfosData!.firstName!.isEmpty
                                      ? " -"
                                      : (widget.shareInfosData!.firstName!),
                            ),
                          ),
                          const SizedBox(width: 24.0),
                          Expanded(
                            child: CardTextsWidget(
                                titleText: 'Date of Grant',
                                descText: widget.registerInfoData!.dateOfGrant
                                    .toString()),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.032),

                    /// company and share name row
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: CardTextsWidget(
                              titleText: 'Company Name',
                              descText: widget.shareInfosData!.companyName,
                            ),
                          ),
                          const SizedBox(width: 24.0),
                          Expanded(
                            child: CardTextsWidget(
                              titleText: 'Number of Share',
                              descText: widget.shareInfosData!.numberOfShares
                                  .toString(),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: height * 0.068),

                    CustomButton(
                      onTap: () {
                        Get.dialog(
                          Material(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                        style: GoogleFonts.poppins().copyWith(
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
                                          8.0, 15.0, 8.0, 20.0),
                                      // margin: const EdgeInsets.symmetric(
                                      //     horizontal: 5.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(11.0),
                                        // color: redColor
                                        // image: const DecorationImage(
                                        //   image: Svg(AppImages.certificateBack),
                                        //   fit: BoxFit.fill,
                                        // ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(11.0),
                                        child: Image.network(widget
                                            .shareInfosData!.certificateUrl!),
                                      ),
                                    ),

                                    /// your certificate key text
                                    Center(
                                      child: Text(
                                        'Your Certificate Key',
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins().copyWith(
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
                                          widget
                                              .shareInfosData!.certificateKey!,
                                          style: GoogleFonts.poppins().copyWith(
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
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          PageTransition(
                                            duration: const Duration(
                                                milliseconds: 300),
                                            reverseDuration: const Duration(
                                                milliseconds: 300),
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: const RegisterCertificateScreen(
                                                // shareInfosData: _controller
                                                //     .issueShareList![index],
                                                // registerInfoData: shareDetail,
                                                ),
                                          ),
                                        );
                                      },
                                      btnText: 'Issue Additional Certificates',
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
                                                  widget.shareInfosData!
                                                      .certificateUrl!,
                                                  (widget.shareInfosData!
                                                          .companyName! +
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
                                    // DownloandPdf(
                                    //   isUseIcon: true,
                                    //   pdfUrl:
                                    //       'https://www.panthercountry.org/userfiles/358/Classes/4914/NOUN%20Clause%20Practice.pdf',
                                    //   fileNames: 'TestDownload.pdf',
                                    //   color: Colors.black,
                                    // ),

                                    /// go to dashboard
                                    SizedBox(height: height * 0.016),
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   PageTransition(
                                          //     duration: Duration(milliseconds: 300),
                                          //     reverseDuration:
                                          //         Duration(milliseconds: 300),
                                          //     type: PageTransitionType.rightToLeft,
                                          //     child: HomeScreen(),
                                          //   ),
                                          // );
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              PageTransition(
                                                duration: const Duration(
                                                    milliseconds: 300),
                                                reverseDuration: const Duration(
                                                    milliseconds: 300),
                                                type: PageTransitionType
                                                    .rightToLeft,
                                                child: const HomeScreen(),
                                              ),
                                              (route) => false);
                                        },
                                        child: Text(
                                          'Go to dashboard',
                                          style: GoogleFonts.poppins().copyWith(
                                            color: AppColors.darkblue1,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      btnText: 'View Certificate',
                      margin: const EdgeInsets.all(0.0),
                    ),
                  ],
                ),
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
