import 'package:flutter/material.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  List<dynamic> comments = [];
  TextEditingController com1 = TextEditingController();
  TextEditingController com2 = TextEditingController();
  TextEditingController com3 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getComments();
    // comments = ["", "", ""];
    // com1.text = "11111";
    // com2 = TextEditingController();
    // com3 = TextEditingController();
  }

  Future<Null> getComments() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    try {
      var com = preferences.getStringList('comments');
      if (com == null) {
      } else {
        com1.text = com[0];
        com2.text = com[1];
        com3.text = com[2];
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Null> saveComments(List<String> comments) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setStringList('comments', comments);
  }

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: myAppbar(3, context, "ข้อเสนอแนะเพิ่มเติม"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(singlechildPadding),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: simpleBoxDecoration,
                padding: EdgeInsets.all(12),
                child: Column(children: [
                  Column(
                    children: [
                      commentBox(
                          "- ประสานสอบถามหน่วยงานที่ปฏิบัติงานร่วมกับตำรวจ ว่ามีปัญหาข้อขัดข้องหรือข้อเสนอแนะเกี่ยวกับการปฏิบัติหน้าที่ของตำรวจหรือไม่ อย่างไร",
                          "กรอก",
                          com1),
                      SizedBox(height: boxPadding),
                      commentBox(
                          "- มีการพัฒนาหน่วยงานด้านใดบ้าง/ข้อชมเชย/สามารถเป็นแบบอย่างได้เรื่องใด (มีหลักฐานประกอบ เช่น หนังสือชมเชย รางวัล จากหน่วยงานต่างๆ, คลิปประกอบ, ภาพถ่าย, โครงการ ฯลฯ)",
                          "กรอก",
                          com2),
                      SizedBox(height: boxPadding),
                      commentBox(
                          "- การดำเนินการด้านอื่นๆ ที่สำคัญ/น่าสนใจ/ตร.สั่งการ (ถ้ามี)",
                          "กรอก",
                          com3),
                    ],
                  ),
                ]),
              ),
              SizedBox(height: boxPadding),
              iconButton(Icons.save_as_rounded, () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => InformationPage(
                //               data: forms,
                //             )));

                saveComments([com1.text, com2.text, com3.text]);
                Navigator.pop(context);
              }, "บันทึก", widthUI),
            ],
          ),
        ),
      ),
    );
  }
}

// class CommentPage extends StatelessWidget {
//   List<String> comments = ["","",""];
//   CommentPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: myAppbar(3, context, "ข้อเสนอแนะเพิ่มเติม"),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(singlechildPadding),
//         child: Container(
//           alignment: Alignment.topCenter,
//           child: Column(
//             children: [
//               Container(
//                 decoration: simpleBoxDecoration,
//                 padding: EdgeInsets.all(12),
//                 child: Column(children: [
//                   Column(
//                     children: [
//                       commentBox(
//                         "- ประสานสอบถามหน่วยงานที่ปฏิบัติงานร่วมกับตำรวจ ว่ามีปัญหาข้อขัดข้องหรือข้อเสนอแนะเกี่ยวกับการปฏิบัติหน้าที่ของตำรวจหรือไม่ อย่างไร",
//                         "กรอก",
//                         (value) {
//                           forms[page].comment_1 = value.toString();
//                         },
//                       ),
//                       SizedBox(height: boxPadding),
//                       commentBox(
//                         "- มีการพัฒนาหน่วยงานด้านใดบ้าง/ข้อชมเชย/สามารถเป็นแบบอย่างได้เรื่องใด (มีหลักฐานประกอบ เช่น หนังสือชมเชย รางวัล จากหน่วยงานต่างๆ, คลิปประกอบ, ภาพถ่าย, โครงการ ฯลฯ)",
//                         "กรอก",
//                         (value) {
//                           // forms[page].comment_2 = value.toString();
//                         },
//                       ),
//                       SizedBox(height: boxPadding),
//                       commentBox(
//                         "- การดำเนินการด้านอื่นๆ ที่สำคัญ/น่าสนใจ/ตร.สั่งการ (ถ้ามี)",
//                         "กรอก",
//                         (value) {
//                           // forms[page].comment_3 = value.toString();
//                         },
//                       ),
//                     ],
//                   ),
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
