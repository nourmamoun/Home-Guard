import 'package:flutter/material.dart';
import 'package:smart_home/constants.dart';

class ButtonWidgets extends StatelessWidget {
  ButtonWidgets(
      {super.key,
      this.width,
      this.text1,
      this.color,
      this.textColor,
      this.onTap});
  final width;
  final text1;
  final color;
  final textColor;
  final onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: 54,
        decoration: BoxDecoration(
          border:const Border(
              top: BorderSide(color: Color(kBlueButton)),
              bottom: BorderSide(color: Color(kBlueButton)),
              left: BorderSide(color: Color(kBlueButton)),
              right: BorderSide(color: Color(kBlueButton))),
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            text1,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: "Poppins",
                color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
