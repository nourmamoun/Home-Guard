import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/widgets/settingsWidget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.zero,
              topLeft: Radius.zero,
              bottomLeft: Radius.elliptical(50, 30),
              bottomRight: Radius.elliptical(50, 30),
            ),
          ),
          backgroundColor: const Color(0xffF1F8FF),
          surfaceTintColor: const Color(0xffF1F8FF),
          centerTitle: true,
          title: const Text(
            'Settings',
            style: TextStyle(
              fontSize: 18,
              fontFamily: kFontFamily,
              fontWeight: FontWeight.w600,
              color: Color(kBlueButton),
            ),
          ),
          toolbarHeight: height / 8,
          leading: IconButton(onPressed: () {
            Navigator.of(context).pop();
          },icon: const Icon(Icons.arrow_back_ios,color: Color(kBlueButton),),),
        ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
             const SizedBox(height: 10,),

            Container(
              height: height/6,
              width: width/2,
              decoration: const BoxDecoration(
                color: Color(0xffF0EBEB),
                shape: BoxShape.circle
              ),
              child: Icon(Icons.person,size: height/7, color: Color.fromARGB(255, 99, 97, 97),)
            ),
            const SizedBox(height: 10,),
            const Text('Nour Mamoun', style: TextStyle(
              fontFamily: kFontFamily,
              fontWeight: FontWeight.w700,
              color: Color(kBlueButton),
              fontSize: 18
            ),),
            const SizedBox(height: 10,),

            Padding(
              padding:const EdgeInsets.only(top: 10,bottom: 3,left: 10,right: 10),
              child: SettingsWidget(text: 'Account', height: height, onTap: (){}, width: width)
            ),
             Padding(
              padding:const EdgeInsets.only(top: 2,bottom: 3,left: 10,right: 10),
              child: SettingsWidget(text: 'Language', height: height, onTap: (){}, width: width)
            ),
            Padding(
              padding:const EdgeInsets.only(top: 2,bottom: 3,left: 10,right: 10),
              child: SettingsWidget(text: 'Dark Mood', height: height, onTap: (){}, width: width)
            ),
           const SizedBox(height: 20,),
             Padding(
              padding:const EdgeInsets.only(top: 2,bottom: 3,left: 10,right: 10),
              child: SettingsWidget(text: 'FAQS', height: height, onTap: (){}, width: width)
            ),
             Padding(
              padding:const EdgeInsets.only(top: 2,bottom: 3,left: 10,right: 10),
              child: SettingsWidget(text: 'Contact Us', height: height, onTap: (){}, width: width)
            ),
           const SizedBox(height: 30,),

           const Center(
            child: Column(
              children: [
                Text('Home Guard', style: TextStyle(
                  color: Color(kBlueButton),
                  fontFamily: kFontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 30
                ),),
                Text('Copyright 2024 Home Guard @All Rights Reserved',style: TextStyle(
                  color: Colors.grey,
                  fontFamily: kFontFamily,
                  fontSize: 10
                ),),
                
              ],
            ),
           ),
              const SizedBox(height: 70,),

           
        
          ],
        ),
      ),
    );
  }
}