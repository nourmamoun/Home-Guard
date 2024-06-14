import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/controllers/GnavController.dart';
import 'package:smart_home/pages/HomePage.dart';
import 'package:smart_home/widgets/TextFieldWidget.dart';
import 'package:smart_home/widgets/buttons.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    var width1 = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
        BottomNavigationBarController controller = Get.put(BottomNavigationBarController());

    print(width1);
    print(height);
    return Scaffold(
      body: SafeArea(
        child: Column(
          
          
          children: [
            Padding(
              padding: const EdgeInsets.only(top:16.0),
              child: Image.asset(
                'lib/assets/images/lock.png',
                width: width1,
                height: height / 3.4
              ),
            ),

           const Padding(
             padding:  EdgeInsets.only(left: 20.0,bottom: 8,top: 16),
             child: Align(
              alignment: Alignment.centerLeft,
              child: Text("User Name", style: TextStyle(
                fontFamily: kFontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,

              ),),),
           ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16),
              child: TextFieldWidget(
                 hintText: "Enter Your User Name",
              ),
            ),

           const Padding(
             padding:  EdgeInsets.only(left: 20.0,bottom: 8,top: 10),
             child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Password", style: TextStyle(
                fontFamily: kFontFamily,
                fontSize: 14,
                fontWeight: FontWeight.w500,

              ),),),
           ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16),
              child: TextFieldWidget(
                 hintText: "Enter Your Password",
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 16.0,right: 16,bottom: 16,top:16),
              child: ButtonWidgets(
                width: width1,
                text1: "Login",
                color:const Color(kBlueButton),
                textColor: const Color(kWhiteButton),
                onTap: (){
                  controller.index=0.obs;
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const HomePage()));

                },
              )
            )

            
          ],
        ),
      ),
    );
  }
}
