import 'package:flutter/material.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/home.dart';
import 'package:jaray_police_web/manager.dart';
import 'package:jaray_police_web/object.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    double fontSize = 16;
    double linePadding = 4;
    return Scaffold(
        appBar: myAppbar(1, context,"การควบคุมและการจัดการจราจร"),
        body: Container(
          width: double.maxFinite,
          decoration: simpleBoxDecoration,
          margin: EdgeInsets.all(mobile.padding),
          padding: EdgeInsets.all(mobile.padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.jpg',
                height: 250,
              ),
              SizedBox(height: linePadding * 8),
              landingText("แบบตรวจราชการ ประจำปีงบประมาณ พ.ศ. 2568", fontSize),
              SizedBox(height: linePadding),
              landingText("4. การป้องกันแก้ไขอุบัติเหตุทางถนน", fontSize),
              SizedBox(height: linePadding),
              landingText("และการบริหารงานด้านการจราจร", fontSize),
              SizedBox(height: linePadding),
              landingText(
                  "(ใช้สำหรับการตรวจราชการหน่วยงานระดับ สน./สภ.)", fontSize),
              SizedBox(height: linePadding * 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManagerPage()));
                      },
                      child: Text("ค้นหา"),
                    ),
                  ),
                  SizedBox(
                    width: mobile.padding,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                      child: Text("เริ่ม"),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Text landingText(String text, double fontSize) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.black,
        fontSize: fontSize,
      ),
    );
  }
}
