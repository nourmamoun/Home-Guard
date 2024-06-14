import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_home/constants.dart';

class SettingsWidget extends StatelessWidget {
  const SettingsWidget({super.key,required this.text,required this.height,required this.onTap,required this.width});
  final text;
  final onTap;
  final width;
  final height;

  @override
  Widget build(BuildContext context) {
    return Container(
              width: width,
              height: height/20,
              decoration:const BoxDecoration(
                color: Color(kBlueButton),
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(text, style:const TextStyle(
                      color: Color(kWhiteButton),
                      fontFamily: kFontFamily
                    ),),
                  ),

                  IconButton(onPressed: onTap, icon:const Icon(Icons.arrow_forward_ios,color: Color(kWhiteButton),))
                ],
              ),
            );
  }
}