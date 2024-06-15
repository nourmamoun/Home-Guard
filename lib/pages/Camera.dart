import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_home/constants.dart';
import 'package:smart_home/pages/AddMember.dart';
import 'package:smart_home/widgets/ContainerCamer.dart';
import 'package:smart_home/widgets/buttons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CameraPage extends StatelessWidget {
   CameraPage({super.key}){
    _stream = _reference.orderBy('uploaded_at',descending:true).snapshots();
   }

final CollectionReference _reference = FirebaseFirestore.instance.collection('images');
  
  late Stream<QuerySnapshot> _stream;


  Future<void> _deleteImage(Timestamp uploadedAt, String imageUrl) async {
    try {
      // Find the document by uploaded_at
      QuerySnapshot querySnapshot = await _reference.where('uploaded_at', isEqualTo: uploadedAt).get();
      if (querySnapshot.docs.isNotEmpty) {
        // Delete image from Firebase Storage
        await FirebaseStorage.instance.refFromURL(imageUrl).delete();
        // Delete document from Firestore
        await _reference.doc(querySnapshot.docs.first.id).delete();
      }
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  
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
                    Timestamp uploadedAt = thisItem['uploaded_at'];
                     String imageUrl = thisItem['image'];
                    return Slidable(
                        key: ValueKey(uploadedAt),
                        startActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) => _deleteImage(uploadedAt, imageUrl),
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              icon: Icons.delete,
                              label: 'Delete',
                            )
                          ],
                        ),
                        child: CameraContainer(
                          height: height,
                          width: width,
                          image: imageUrl,
                        ),
                      );
                    },
                  );
                }
                return Text("No data");
              },
              
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
