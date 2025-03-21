import 'package:flutter/material.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/form_class.dart';
import 'package:jaray_police_web/object.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormPage extends StatefulWidget {
  final int task;
  FormPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  int page = 0;
  // List<dynamic> forms = formLists;
  List<dynamic> forms = [];

  @override
  void initState() {
    super.initState();
    // forms = form_list;
    widget.task == 1
        ? forms = form_1
        : widget.task == 2
            ? forms = form_2
            : forms = form_3;
    print("initial state");
    print(forms[0].choosed.txt.toString());
  }

  Future<Null> saveScore(double score) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setDouble(
      widget.task == 1
          ? 'score_1'
          : widget.task == 2
              ? 'score_2'
              : 'score_3',
      score,
    );
  }

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;
    // double heightUI = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: myAppbar(3, context, "กิจกรรมที่ ${widget.task.toString()}"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(singlechildPadding),
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                // height: heightUI*0.8,
                decoration: simpleBoxDecoration,
                width: tabletWidth,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    // page != forms.length - 1
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          forms[page].header,
                          SizedBox(height: boxPadding),
                          formBox(forms[page].widgets_1),
                          SizedBox(height: boxPadding),
                          radioBox([
                            Padding(
                              padding: EdgeInsets.only(left: boxPadding),
                              child: Column(
                                children: forms[page].widgets_2,
                              ),
                            ),
                            SizedBox(height: boxPadding),
                            radioList(forms[page]),
                          ]),
                        ]),
                    SizedBox(height: boxPadding),
                    listBar(widthUI),
                    SizedBox(height: boxPadding / 2),
                  ],
                ),
              ),
              SizedBox(height: boxPadding),
              page == forms.length - 1
                  ? iconButton(Icons.save_as_rounded, () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => InformationPage(
                      //               data: forms,
                      //             )));
                      var scores = [];
                      for (var score in forms) {
                        if (score.choosed.score == 10) {
                          scores.add(0);
                        } else {
                          scores.add(score.choosed.score);
                        }
                      }

                      var sum =
                          scores.reduce((value, element) => value + element);

                      saveScore(sum);
                      Navigator.pop(context);
                    }, "บันทึก", widthUI)
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Column listBar(double widthUI) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: listButton(() {
                if (page > 0) {
                  setState(() {
                    page = page - 1;
                  });
                }
              }, "<", widthUI),
            ),
            SizedBox(width: mobile.padding * 10),
            Expanded(
              child: listButton(() {
                if (page < forms.length - 1) {
                  setState(() {
                    page = page + 1;
                  });
                }
              }, ">", widthUI),
            ),
          ],
        ),
        SizedBox(height: mobile.padding),
        Wrap(
          spacing: 12,
          // runSpacing: 1000,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          direction: Axis.horizontal,
          children: List.generate(forms.length, (index) {
            double dotSize = widthUI <= mobileWidth
                ? page == index
                    ? 20
                    : 14
                : page == index
                    ? 24
                    : 18;

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: SizedBox(
                width: dotSize,
                height: dotSize,
                child: FloatingActionButton(
                    backgroundColor: forms[index].choosed.txt == ""
                        ? Colors.transparent
                        : greyColor,
                    elevation: 0,
                    shape: CircleBorder(
                        side: BorderSide(
                          strokeAlign: BorderSide.strokeAlignCenter,
                          width: page == index ? 4 : 2,
                          color: page == index ? primaryColor : greyColor,
                        ),
                        eccentricity: 0.0),
                    onPressed: () {
                      setState(() {
                        page = index;
                      });
                    }),
              ),
            );
          }),
        ),
      ],
    );
  }

  Container formBox(List<Widget> widgets) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(boxPadding),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(boxRadius),
          border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  Container radioBox(List<Widget> widgets) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: 4,
        right: boxPadding,
        top: boxPadding,
        bottom: boxPadding,
      ),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(boxRadius),
          border: Border.all()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgets,
      ),
    );
  }

  SizedBox listButton(
    Function()? onPressed,
    String text,
    double widthUI,
  ) {
    return SizedBox(
      // width: 50,
      child: ElevatedButton(
        iconAlignment: IconAlignment.start,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 12,
          ),
          backgroundColor: color2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: text == "<"
              ? [
                  Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  Text(
                    "ก่อนหน้า",
                    style: TextStyle(color: Colors.white),
                  )
                ]
              : [
                  Text(
                    "ถัดไป",
                    style: TextStyle(color: Colors.white),
                  ),
                  Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                  ),
                ],
        ),
      ),
    );
  }

  Wrap radioList(dynamic form) {
    return Wrap(
      children: List.generate(form.choice.length, (index) {
        return Row(
          children: [
            Radio(
                value: form.choice[index].score,
                groupValue: forms[page].choosed.score,
                onChanged: (value) {
                  setState(() {
                    forms[page].choosed.score = value;
                    forms[page].choosed.txt = form.choice[index].txt;
                  });
                }),
            SizedBox(width: 4),
            Expanded(child: Text(form.choice[index].txt))
          ],
        );
      }),
    );
  }
}
