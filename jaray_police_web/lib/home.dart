import 'package:flutter/material.dart';
import 'package:jaray_police_web/comment.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/form.dart';
import 'package:jaray_police_web/information.dart';
import 'package:jaray_police_web/object.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<Null> getScore() async {}

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: myAppbar(2, context, "การควบคุมและการจัดการจราจร"),
        body: Container(
          width: double.maxFinite,
          decoration: simpleBoxDecoration,
          padding: EdgeInsets.symmetric(vertical: mobile.padding),
          margin: EdgeInsets.all(mobile.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              homeButton(1, context),
              homeButton(2, context),
              homeButton(3, context),
              commentButton(context),
              SizedBox(height: boxPadding),
              iconButton(Icons.saved_search_sharp, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InformationPage(
                              data: [],
                            )));
              }, "ต่อไป", widthUI),
             
            ],
          ),
        ));
  }
}

Container homeButton(int task, BuildContext context) {
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.symmetric(
        horizontal: mobile.padding, vertical: mobile.padding * 0.25),
    child: OutlinedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FormPage(task: task)));
      },
      child: task == 1
          ? task_txt(task, "การป้องกัน อบถ. เพื่อความปลอดภัยด้านการจราจร", 29)
          : task == 2
              ? task_txt(task, "การอำนวยการจัดการจราจร และบังคับใช้กฎหมาย", 41)
              : task_txt(task,
                  "การบริหารการมีส่วนร่วมของประชาชน และการประชาสัมพันธ์", 30),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(mobile.padding),
        side: BorderSide(width: 2.0, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    ),
  );
}

Column task_txt(int task, String txt, int score) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Text.rich(
        TextSpan(
          text: "กิจกรรมที่ ${task}  ",
          style: TextStyle(
            fontSize: 20,
            // fontWeight: FontWeight.w700,
          ),
          children: <InlineSpan>[
            TextSpan(
              text: txt,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: Colors.black54),
            ),
          ],
        ),
      ),
      Text("(${score} คะแนน)")
    ],
  );
}

Container commentButton(BuildContext context) {
  return Container(
    width: double.maxFinite,
    margin: EdgeInsets.symmetric(
        horizontal: mobile.padding, vertical: mobile.padding * 0.25),
    child: OutlinedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CommentPage()));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "ข้อเสนอแนะเพิ่มเติม",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            Text("(ไม่มีคะแนน)"),
          ],
        ),
      ),
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.all(mobile.padding),
        side: BorderSide(width: 2.0, color: Colors.grey),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    ),
  );
}

