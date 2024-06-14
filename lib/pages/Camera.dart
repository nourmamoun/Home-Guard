import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/pages/AddMember.dart';
import 'package:smart_home/widgets/ContainerCamer.dart';
import 'package:smart_home/widgets/buttons.dart';

class CameraPage extends StatelessWidget {
   CameraPage({super.key}){
    _stream = _reference.orderBy('uploaded_at',descending:true).snapshots();
   }

CollectionReference _reference = FirebaseFirestore.instance.collection('images');
  
  late Stream<QuerySnapshot> _stream;
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
            'Camera',
            style: TextStyle(
              fontSize: 18,
              fontFamily: kFontFamily,
              fontWeight: FontWeight.w600,
              color: Color(kBlueButton),
            ),
          ),
          toolbarHeight: height / 8,
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Your Members:",
              style: TextStyle(
                  fontFamily: kFontFamily,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _stream,
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if(snapshot.hasError){
                  return Center(child: Text('error occured ${snapshot.error}'),);
                }
             else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Color(kBlueButton),),
                );
              }
              else if(snapshot.hasData){
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> documents = querySnapshot.docs;

                  List<Map> items = documents.map((e) => e.data()as Map).toList();
              
              
               return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: items.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, index) {
                    Map thisItem = items[index];
                    return CameraContainer(
                      height: height,
                      width: width,
                      image: thisItem['image'],
                    );
                  });
               
               
                }
                return Text("hi");

              }
              
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ButtonWidgets(
              width: width,
              text1: "Add Member",
              color: const Color(kBlueButton),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>  AddMemberPage()));
              },
              textColor: const Color(kWhiteButton),
            ),
          )
        ]));
  }
}
