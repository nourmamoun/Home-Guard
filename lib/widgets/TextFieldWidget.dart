import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
   TextFieldWidget({super.key,this.hintText});
final hintText;
//final controller;
//TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration:  InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(
                    color: Color(0xffECEFF8),
                    width: 2,

                  )  
                  )
                 ,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                ),
    );
  }
}