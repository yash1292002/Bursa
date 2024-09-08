import 'package:bursa_flutter/consts/color_const.dart';
import 'package:flutter/material.dart';

import '../../../../consts/textstyle_const.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final FocusNode? focusNode;

  const CustomField(
      {Key? key,
      required this.controller,
      this.hintText = 'Hint Text',
      this.keyboardType,
      this.focusNode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: width * .0),
      child: Column(
        children: [
          TextFormField(
            enabled: false,
            style: poppinsRegular.copyWith(
              color: blackColor,
              fontSize: width * .036,
              fontWeight: FontWeight.w500,
            ),
            controller: controller,
            focusNode: focusNode,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              border: InputBorder.none,
              disabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: lightBlueColorWithopacity30,
                ),
              ),
              hintStyle: poppinsRegular.copyWith(
                color: lightBlueColorWithopacity40,
                fontSize: width * .036,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(height: 1, color: lightBlueColorWithopacity30)
        ],
      ),
    );
  }
}
