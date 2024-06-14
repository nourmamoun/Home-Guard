//import 'dart:html';

import 'package:flutter/cupertino.dart';

class CameraContainer extends StatelessWidget {
  const CameraContainer({super.key, this.height,this.width,this.image});
final height;
final width;
final image;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color:const Color(0xffF0EBEB)
          ),
          
          height:height/3.5,
          width: width,
          child: Image.network(image), 
        ),
      );
  }
}