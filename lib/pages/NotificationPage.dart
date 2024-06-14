import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:smart_home/constants.dart';
import 'package:smart_home/pages/settings.dart';
import 'package:smart_home/widgets/ContainerNotification.dart';
import 'package:smart_home/widgets/buttons.dart';

class NotificationsPage extends StatelessWidget {
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
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontFamily: kFontFamily,
            fontWeight: FontWeight.w600,
            color: Color(kBlueButton),
          ),
        ),
        toolbarHeight: height / 8,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () async {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage()));
               
              },
              icon: const Icon(Icons.settings,
                  color: Color(kBlueButton), size: 26),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
        StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('signalData').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 8),
                  child: Container(
                    color: const Color(0xffE9F1FF),
                    height: height / 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              width: width / 4,
                              height: height / 10,
                              child: Image.asset("lib/assets/images/lock.png")),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 16.0, bottom: 8),
                                child: RichText(
                                  text: TextSpan(
                                    text:
                                        "There is someone who is not recognized\ntrying to enter the house.\n",
                                    style: TextStyle(
                                      fontSize: width / 29,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: kFontFamily,
                                      color: const Color(0xff636B7E),
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Do you agree to open the door?",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: kFontFamily,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width / 29,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ButtonWidgets(
                                    width: width / 3,
                                    color: const Color(0xffE9F1FF),
                                    text1: 'NO',
                                    onTap: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) => customDialog1(),
                                      );
                                      //await _sendControlSignal('no');
                                      // await _clearSignalData();
                                    },
                                    textColor: const Color(kBlueButton),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0, right: 2),
                                    child: ButtonWidgets(
                                      width: width / 3,
                                      color: const Color(kBlueButton),
                                      text1: 'YES',
                                      onTap: () async {
                                        showDialog(
                                          context: context,
                                          builder: (context) => customDialog(),
                                        );
                                       // await _sendControlSignal('yes');
                                      //  await _clearSignalData();
                                      },
                                      textColor: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },),
          
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('faceData')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('No notifications found'));
                }

                final logs = snapshot.data!.docs;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    var log = logs[index].data() as Map<String, dynamic>;
                    var image = base64Decode(log['image']);
                    var dateTime = DateTime.parse(log['timestamp']);
                    var text1 = log['textInfo1'];
                    var text2 = log['textinfo2'];

                    return ContainerNotifications(
                      width: width,
                      height: height,
                      image: image,
                      DateTime: dateTime,
                      text1: text1,
                      text2: text2,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
Future<void> _clearSignalData() async {
      final collectionRef = FirebaseFirestore.instance.collection('signalData');
      final snapshot = await collectionRef.get();
      for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

class customDialog extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _sendControlSignal(String signal) async {
    DateTime now = DateTime.now();
    await _firestore.collection('control').add({'signal': signal, 'date': now});
  }

  customDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        height: height / 2.4,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Image.asset(
              'lib/assets/images/door_unlock.png',
              width: width / 4,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Are You Sure to open the \n door?",
                style: TextStyle(
                  fontFamily: kFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            const Text("The door will be opened immediatly",
                style: TextStyle(
                    fontFamily: kFontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xff8B93A7)),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidgets(
                  width: width / 3,
                  color: Colors.white,
                  text1: 'NO',
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                ButtonWidgets(
                  width: width / 3,
                  color: const Color(kBlueButton),
                  textColor: Colors.white,
                  text1: 'YES',
                  onTap: () async {
                    _sendControlSignal('yes');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Door is opened. Have a Good Time."),
                      backgroundColor: Color(kBlueButton),
                    ));
                    Navigator.of(context).pop();
                      await _clearSignalData();

                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class customDialog1 extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _sendControlSignal(String signal) async {
    DateTime now = DateTime.now();
    await _firestore.collection('control').add({'signal': signal, 'date': now});
  }

  customDialog1({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Container(
        height: height / 2.4,
        width: width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Image.asset(
              'lib/assets/images/door_unlock.png',
              width: width / 4,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text("Are You Sure you dont want to open the door?",
                style: TextStyle(
                  fontFamily: kFontFamily,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            const Text("The door will be opened immediatly",
                style: TextStyle(
                    fontFamily: kFontFamily,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xff8B93A7)),
                textAlign: TextAlign.center),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ButtonWidgets(
                  width: width / 3,
                  color: Colors.white,
                  text1: 'NO',
                  onTap: () async {
                    Navigator.of(context).pop();
                  },
                ),
                ButtonWidgets(
                  width: width / 3,
                  color: const Color(kBlueButton),
                  textColor: Colors.white,
                  text1: 'YES',
                  onTap: () async {
                    _sendControlSignal('no');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Door Didn't open, Your House was Safe!"),
                      backgroundColor: Color(kBlueButton),
                    ));
                    Navigator.of(context).pop();
                      await _clearSignalData();

                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
