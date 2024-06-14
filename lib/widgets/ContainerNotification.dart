import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_home/constants.dart';
import 'dart:convert';
import 'dart:typed_data';

class ContainerNotifications extends StatelessWidget {
   ContainerNotifications({super.key, this.width,this.height,this.text1,this.text2,required this.image,this.DateTime});
final width;
final height;
final text1;
final text2;
final Uint8List image;
final DateTime;
  @override
  Widget build(BuildContext context) {
        

    return Container(
             
              height: height /6,
              decoration:const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5))
              ),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:8.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                         width: width/4,
                        height: height/11,
                        decoration: const BoxDecoration(
                            color: Colors.transparent, shape: BoxShape.circle),

                          child: Image.memory(image), 
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0,bottom: 8),
                          child: RichText(
                            text: TextSpan(
                             text: text1,
                              style: TextStyle(
                                fontSize: width/29,
                                fontWeight: FontWeight.w400,
                                fontFamily: kFontFamily,
                                color:const Color(0xff636B7E)
                              ),
                              children: [
                                TextSpan(
                                  text: text2,style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: kFontFamily,
                                    fontWeight: FontWeight.w500,
                                    fontSize: width/29
                                  )
                                )
                              ]
                            ),
                          ),
                          
                        ),
                        Text(DateTime.toString(), style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          fontFamily: kFontFamily,
                          color: Color(0xff636B7E)
                        ),),
                        
                        ]))
                  
                  
                  ])
          );
  }
}