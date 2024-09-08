import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../consts/color_const.dart';
import '../consts/textstyle_const.dart';

class CustomInputField extends StatelessWidget {
  final bool isEnabled;
  final bool isBigText;
  final String hintText;
  final TextEditingController editingController;
  final onTextChange;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixWidget;
  final FocusNode? focusNode;
  final TextInputType inputType;

  const CustomInputField(
      {Key? key,
      required this.isEnabled,
      required this.editingController,
      required this.hintText,
      required this.onTextChange,
      this.inputFormatters,
      this.focusNode,
      this.prefixWidget,
      this.inputType = TextInputType.text,
      this.isBigText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = Get.width;

    return Container(
      margin: EdgeInsets.only(
        top: width * .005,
      ),
      child: TextFormField(
        style:
            isBigText ? AppStyles.bigInputTextStyle : AppStyles.inputTextStyle,
        onChanged: onTextChange,
        inputFormatters: inputFormatters,
        enabled: isEnabled,
        focusNode: focusNode,
        controller: editingController,
        keyboardType: inputType,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: prefixWidget,
          // border: InputBorder.none,
          enabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: lightBlueColorWithopacity30, width: 2.0),
          ),
          disabledBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: lightBlueColorWithopacity30, width: 2),
          ),
          hintStyle:
              isBigText ? AppStyles.bigHintTextStyle : AppStyles.hintTextStyle,
        ),
      ),
    );
  }
}
