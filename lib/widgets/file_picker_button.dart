import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';
import '../consts/textstyle_const.dart';

class FilePickerButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isFileAdded;
  final String description;
  final String fileAddedText;

  const FilePickerButton(
      {Key? key,
      required this.onTap,
      this.isFileAdded = false,
      this.description = "Upload Logo File.",
      this.fileAddedText = "Logo Added"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;
    var height = Get.height;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(
          top: height * .01,
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
            // height: height * .08,
            padding: EdgeInsets.only(
              top: height * .015,
              left: width * .03,
              right: width * .03,
              bottom: height * .015,
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/icons/cloud.png",
                      width: width * .1,
                      height: width * .1,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: width * .04),
                                child: Text("Browse to upload",
                                    style: poppinsRegular.copyWith(
                                        color: lightBlueColor,
                                        fontSize: width * .03,
                                        fontWeight: FontWeight.w600)),
                              ),
                            ],
                          ),
                          isFileAdded
                              ? Container(
                                  margin: EdgeInsets.only(
                                    left: width * .04,
                                  ),
                                  child: Text(fileAddedText,
                                      style: poppinsRegular.copyWith(
                                          color: greyColor,
                                          fontSize: width * .03,
                                          fontWeight: FontWeight.w500)),
                                )
                              : Container(
                                  margin: EdgeInsets.only(
                                    left: width * .04,
                                  ),
                                  child: Text(description,
                                      style: poppinsRegular.copyWith(
                                          color: greyColor,
                                          fontSize: width * .03,
                                          fontWeight: FontWeight.w500)),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
