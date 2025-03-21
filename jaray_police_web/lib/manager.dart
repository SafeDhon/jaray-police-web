import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jaray_police_web/class.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/form_class.dart';
import 'package:jaray_police_web/object.dart';
import 'package:jaray_police_web/pdf_service.dart';

class ManagerPage extends StatefulWidget {
  const ManagerPage({super.key});

  @override
  State<ManagerPage> createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  void _initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await Firebase.initializeApp(
        options: FirebaseOptions(
          apiKey: "AIzaSyAvtbZH3ve_LIIedbuHDGlbH4fjBf4Lsag",
          authDomain: "jaray-police-web.firebaseapp.com",
          projectId: "jaray-police-web",
          storageBucket: "jaray-police-web.appspot.com",
          messagingSenderId: "142290228885",
          appId: "1:142290228885:web:2b0096b2f73c759fb26d9c",
        ),
      );
    } catch (e) {
      print(
          "////////////////////////////////////////////////////////////////////");
      print(e.toString());
    }
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    final _fileStream =
        FirebaseFirestore.instance.collection('datas').snapshots();

    return Scaffold(
      appBar: myAppbar(2, context,"ประวัติการตรวจสอบ"),
      body: Padding(
        padding: EdgeInsets.all(singlechildPadding),
        child: Center(
          child: Container(
            decoration: simpleBoxDecoration,
            width: tabletWidth,
            padding: EdgeInsets.all(12),
            alignment: Alignment.topCenter,
            child: StreamBuilder(
              stream: _fileStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("Connection Error");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading...");
                }
                var docs = snapshot.data!.docs;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("ตรวจ ${docs[index]['infor_01']}"),
                      subtitle: Text("วันที่ ${docs[index]['infor_04']}"),
                      trailing: IconButton(
                        onPressed: () async {
                          List<dynamic> data = await getData(docs[index]);
                          Infor infor = await getInfor(docs[index]);
                          PdfService().downloadPdf(data, infor);
                        },
                        icon: Icon(
                          Icons.download_rounded,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Infor getInfor(dynamic doc) {
    return Infor(
      infor_1: doc['infor_01'],
      infor_4: doc['infor_04'],
    );
  }

  List<dynamic> getData(dynamic doc) {
    List<Form_> forms = form_list;
    forms[0].choosed = doc['data_01'];
    forms[1].choosed = doc['data_02'];
    forms[2].choosed = doc['data_03'];
    forms[3].choosed = doc['data_04'];
    forms[4].choosed = doc['data_05'];
    forms[5].choosed = doc['data_06'];
    forms[6].choosed = doc['data_07'];
    forms[7].choosed = doc['data_08'];
    forms[8].choosed = doc['data_09'];
    forms[9].choosed = doc['data_10'];
    forms[10].choosed = doc['data_11'];
    forms[11].choosed = doc['data_12'];
    forms[12].choosed = doc['data_13'];
    forms[13].choosed = doc['data_14'];
    forms[14].comment_1 = doc['data_15'];
    forms[14].comment_2 = doc['data_16'];
    forms[14].comment_3 = doc['data_17'];
    return forms;
  }

  // StreamBuilder buildList = StreamBuilder(
  //   stream: FirebaseFirestore.instance.collection('datas').snapshots(),
  //   builder: (context, snapshot) {
  //     if (snapshot.hasError) {
  //       return const Text("Connection Error");
  //     }
  //     if (snapshot.connectionState == ConnectionState.waiting) {
  //       return const Text("Loading...");
  //     }
  //     var docs = snapshot.data!.docs;
  //     return ListView.builder(
  //         itemCount: docs.length,
  //         itemBuilder: (context, index) {
  //           return ListTile(
  //             title: Text("ตรวจ ${docs[index]['infor_01']}"),
  //             subtitle: Text("วันที่ ${docs[index]['infor_04']}"),
  //           );
  //         });
  //   },
  // );
}
