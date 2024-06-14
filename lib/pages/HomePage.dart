import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/controllers/GnavController.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    
    BottomNavigationBarController controller = Get.put(BottomNavigationBarController());
    return Scaffold(
      

      bottomNavigationBar:  GNav(
        
        padding: const EdgeInsets.all(45),
        activeColor: const Color(kBlueButton),
        tabBackgroundColor:const Color(0xffF1F8FF),
        rippleColor:const Color(kBlueButton),
        color:const Color(0xffABB3C8),
        textSize: 16,
        iconSize: 25,
        textStyle:const TextStyle(
          fontFamily: kFontFamily,
          fontWeight: FontWeight.w400,
        
          color: Color(kBlueButton)
        ),
        curve: Curves.bounceIn,
        onTabChange: (index){
          
          controller.index.value = index;
        },
        
        gap: 8,
        tabs: const [
        GButton(icon: Icons.notifications,text: 'Notifications',),
        GButton(icon: Icons.photo_camera_front, text: 'Camera',),
      
      ]),
      body: Obx(() => controller.pages[controller.index.value]),
    );
  }
}
