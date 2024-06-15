import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/widgets/buttons.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddMemberPage extends StatefulWidget {
   AddMemberPage({super.key});

  @override
  State<AddMemberPage> createState() => _AddMemberPageState();
}

class _AddMemberPageState extends State<AddMemberPage> {
    final db = FirebaseFirestore.instance.collection('images');

    String imageUrl='';

    bool _isConditionMet = false;

  

  @override
  Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
         automaticallyImplyLeading: true,
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
          'Add New Member',
          style: TextStyle(
            fontSize: 18,
            fontFamily: kFontFamily,
            fontWeight: FontWeight.w600,
            color: Color(kBlueButton),
          ),
        ),
        toolbarHeight: height / 8,
        
                
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child:
        _isConditionMet
              ? Column(children: [
                  Image.network(imageUrl,height: height/3,),
                 const  SizedBox(height: 20,),
                   ButtonWidgets(
              width: width,
              text1: "Upload",
              textColor: const Color(kWhiteButton),
              color:const  Color(kBlueButton),
              onTap: () async {
                      DateTime now = DateTime.now();
                    if(imageUrl.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Upload an image')));
                    }else{
                        await db.add({
                      'image':imageUrl,
                      'uploaded_at':now,
                    });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Uploaded Successfully'), backgroundColor: Colors.green,));
                      setState(() {
                      _isConditionMet = !_isConditionMet;
                      imageUrl='';
                                 });
                    }                                                                
                        },
             
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                 setState(() {
                      _isConditionMet = !_isConditionMet;
                                 });
              },
              child: const Text("Cancel",style: TextStyle(
                fontFamily: kFontFamily,
                color: Color(kBlueButton),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline
              ),),
            )


              ],) 
              :
         Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: ()async{
                
                 ImagePicker imagePicker = ImagePicker();
                XFile? file= await imagePicker.pickImage(source: ImageSource.gallery);
                print('${file?.path}');
              
              if(file==null) return;

              Reference referenceRoot = FirebaseStorage.instance.ref();
              Reference referenceDirImages = referenceRoot.child('images');              
              Reference referenceImageToUpload = referenceDirImages.child('${file?.name}');
             
             try {
              //store the file

              //success: get the download url
              
            showDialog(context: context, builder: (context){
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(kBlueButton),
                  ),

                );
            });
                 await referenceImageToUpload.putFile(File(file!.path));


               imageUrl=await referenceImageToUpload.getDownloadURL();

              print(imageUrl);

                            Navigator.of(context).pop();
                            setState(() {
                          _isConditionMet = !_isConditionMet;
                        });
               
             } catch (e) {
               
             }
                        
              },
              child: Container(
                height: height/4,
                width: width,
                decoration:const BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(kBlueButton),
                      strokeAlign: BorderSide.strokeAlignInside
                    ),
                    top:BorderSide(
                      color: Color(kBlueButton),
                      strokeAlign: BorderSide.strokeAlignInside
                    ),
                    left: BorderSide(
                      color: Color(kBlueButton),
                      strokeAlign: BorderSide.strokeAlignInside
                    ),right: BorderSide(
                      color: Color(kBlueButton),
                      strokeAlign: BorderSide.strokeAlignInside
                    ), 
                  )
                ),
                child:  const Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:  [
                      Icon(Icons.cloud_upload_outlined,color: Color(kBlueButton),size: 48,),
                      
                      Text('Select You image here',style: TextStyle(
                        fontFamily: kFontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      
                      ),
                      Text('OR',style: TextStyle(
                        fontFamily: kFontFamily,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                      
                      ),
                      Text("Browse",style: TextStyle(
                        fontFamily: kFontFamily,
                        color: Color(kBlueButton),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline
                            ))
                  ],
                ),
              
              ),
            ),
       const SizedBox(
          height: 30,
        ),
            ButtonWidgets(
              width: width,
              text1: "Upload",
              textColor: const Color(kWhiteButton),
              color:const  Color(kBlueButton),
              onTap: () async {
                      
                    if(imageUrl.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Upload an image')));
                    }else{
                        await db.add({
                      'image':imageUrl
                    });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Image Uploaded Successfully'), backgroundColor: Colors.green,));
                      
                    }
                    
                      
                        
                    
                   
              },
             
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Cancel",style: TextStyle(
              fontFamily: kFontFamily,
              color: Color(kBlueButton),
              fontSize: 16,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline
            ),)
          ],
        ),
      ),

    );
  }
}