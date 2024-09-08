import 'dart:developer';
import 'dart:io';
import 'package:bursa_flutter/consts/textstyle_const.dart';
import 'package:bursa_flutter/controllers/register_share_Controller.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../consts/color_const.dart';
import '../../widgets/custom_input_field.dart';
import '../../widgets/custom_next_button.dart';
import '../../widgets/file_picker_button.dart';

class RegisterGrantFirst extends StatefulWidget {
  RegisterGrantFirst({Key? key, required this.onTap}) : super(key: key);
  VoidCallback onTap;

  @override
  State<RegisterGrantFirst> createState() => _RegisterGrantFirstState();
}

class _RegisterGrantFirstState extends State<RegisterGrantFirst> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    RegisterShareController _registerShareController =
        Provider.of<RegisterShareController>(context, listen: true);
    return Container(
      margin: EdgeInsets.only(bottom: height * .15),
      child: Container(
        margin: EdgeInsets.only(bottom: width * .03, top: width * .02),
        // height: height * .68,
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
          //bottom: height * .0,
          left: width * .05,
          right: width * .05,
        ),
        // alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height * .02),
                    child: Text(
                      // "If the company is not on the list, please enter name",
                      "Please Enter Company Name",
                      style: poppinsRegular.copyWith(
                          color: lightBlueColor,
                          fontSize: width * .036,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  CustomInputField(
                    isEnabled: true,
                    editingController:
                        _registerShareController.comapnyNameController,
                    hintText: "ABC Limited",
                    onTextChange: (String s) {
                      log("Empty");
                      setState(() {});
                    },
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          top: height * .022, bottom: width * .02),
                      child: Text(
                        "Upload Business Logo",
                        style: poppinsRegular.copyWith(
                            color: lightBlueColor,
                            fontSize: width * .036,
                            fontWeight: FontWeight.w700),
                      )),
                  FilePickerButton(
                    isFileAdded: _registerShareController.pdffile != null,
                    onTap: () async {
                      if (_registerShareController.selectedConpanies != null &&
                          _registerShareController
                              .comapnyNameController.text.isNotEmpty) {
                        final result = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (result != null) {
                          final path = result.path;

                          _registerShareController.setPdfFile(File(path));
                          //log
                          log(_registerShareController.pdffile.toString());
                        }
                      } else if (_registerShareController
                              .comapnyNameController.text.isNotEmpty &&
                          _registerShareController.selectedConpanies == null) {
                        final result = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        // type: FileType.custom,
                        //allowedExtensions: ['jpg', 'png'],

                        if (result != null) {
                          final path = result.path;

                          _registerShareController.setPdfFile(File(path));
                          //log
                          log(_registerShareController.pdffile.toString());
                        }
                      } else {
                        debugPrint("NO");
                      }
                    },
                  ),
                  /*Container(
                    margin: EdgeInsets.only(top: height * .03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Note:",
                          style: poppinsRegular.copyWith(
                              color: lightBlueColor, fontSize: width * .038),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: width * .0),
                          child: Text(
                            "Companies not on the list might require additional time to verify your share holdings.",
                            style: poppinsRegular.copyWith(
                                color: greyColor,
                                fontSize: width * .032,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  )*/
                ],
              ),
              CustomNextButton(
                onTap:
                    //  _registerShareController.selectedConpanies != null
                    // ? widget.onTap
                    (_registerShareController
                            .comapnyNameController.text.isNotEmpty
                        // _registerShareController.pdffile != null
                        ? () {
                            widget.onTap();

                            FocusScope.of(context).requestFocus(FocusNode());
                          }
                        : null),
                btnColor:
                    //  _registerShareController.selectedConpanies != null
                    // ? greenColor
                    _registerShareController
                            .comapnyNameController.text.isNotEmpty
                        // _registerShareController.pdffile != null
                        ? greenColor
                        : grey1Color,
                text: "Next",
                marginBottom: height * .03,
                marginTop: height * .2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
