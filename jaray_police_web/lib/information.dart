import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jaray_police_web/class.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/object.dart';
import 'package:jaray_police_web/pdf_service.dart';
import 'package:jaray_police_web/zone.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InformationPage extends StatefulWidget {
  final List<dynamic> data;
  InformationPage({Key? mykey, required this.data}) : super(key: mykey);

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  List<dynamic> states = [];
  List<dynamic> states2 = [];
  String? crountryId;
  String? stateId;
  String? stateId2;

  final toast = FToast();

  String pick_date = "";
  TextEditingController dateController = TextEditingController();

  TextEditingController number1 = TextEditingController();
  TextEditingController number2 = TextEditingController();
  TextEditingController number3 = TextEditingController();
  TextEditingController number4 = TextEditingController();
  TextEditingController number5 = TextEditingController();

  Infor _infor = Infor();

  // String _selectedCountry = "India";
  // List _countries = [];
  // CountryDependentDropDown() {
  //   country.forEach((key, value) {
  //     _countries.add(key);
  //   });
  // }

  // String _selectedState = "";
  // List _states = [];
  // StateDependentDropDown(countryShortName) {
  //   state.forEach((key, value) {
  //     if (countryShortName == value) {
  //       _states.add(key);
  //     }
  //   });
  //   _selectedState = _states[0];
  // }

  // String _selectedCity = "";
  // List _cities = [];
  // CityDependentDropDown(stateShortName) {
  //   city.forEach((key, value) {
  //     if (stateShortName == value) {
  //       _cities.add(key);
  //     }
  //   });
  //   _selectedCity = _cities[0];
  // }

  String _selectedRank1 = "ส.ต.ต.";
  String _selectedRank2 = "ส.ต.ต.";
  String _selectedRank3 = "ส.ต.ต.";
  List _ranks = [];
  RankDependentDropDown() {
    rank.forEach((key, value) {
      _ranks.add(key);
    });
  }

  double? score_1 = 0;
  double? score_2 = 0;
  double? score_3 = 0;

  @override
  void initState() {
    super.initState();
    // CountryDependentDropDown();
    RankDependentDropDown();
    toast.init(context);
    getScore();
  }

  Future<Null> getScore() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      score_1 = preferences.getDouble('score_1');
      score_2 = preferences.getDouble('score_2');
      score_3 = preferences.getDouble('score_3');
    });
  }

  @override
  Widget build(BuildContext context) {
    double widthUI = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: myAppbar(3, context, "กรอกข้อมูลการตรวจสอบ"),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(singlechildPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                decoration: simpleBoxDecoration,
                width: tabletWidth,
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    // zoneDropdown("หน่วยรับการตรวจ", 'สน.สภ.', _selectedCountry,
                    //     (newValue) {
                    //   setState(() {
                    //     _cities = [];
                    //     _states = [];
                    //     StateDependentDropDown(country[newValue]);
                    //     _selectedCountry = "$newValue";
                    //   });
                    // }, _countries),
                    // SizedBox(height: boxPadding),
                    // zoneDropdown("ในสังกัด", 'บก./ภ.จว.', _selectedState,
                    //     (newValue) {
                    //   setState(() {
                    //     _cities = [];
                    //     CityDependentDropDown(newValue);
                    //     _selectedState = "$newValue";
                    //   });
                    // }, _states),
                    // SizedBox(height: boxPadding),
                    // zoneDropdown("บช./ภ.", 'บช./ภ.', _selectedCity, (newValue) {
                    //   setState(() {
                    //     _selectedCity = "$newValue";
                    //   });
                    // }, _cities),
                    // SizedBox(height: boxPadding),
                    inputBox("หน่วยรับการตรวจ", "สน.สภ.", (value) {
                      setState(() {
                        _infor.infor_1 = value.toString();
                      });
                    }),
                    SizedBox(height: boxPadding),
                    inputBox("ในสังกัด", "บภ./ภ.จว.", (value) {
                      setState(() {
                        _infor.infor_2 = value.toString();
                      });
                    }),
                    SizedBox(height: boxPadding),
                    inputBox("บช./ภ.", "กรอก", (value) {
                      setState(() {
                        _infor.infor_3 = value.toString();
                      });
                    }),
                    SizedBox(height: boxPadding),
                    inputBox("ของ กต.", "กรอก", (value) {
                      setState(() {
                        _infor.infor_5 = value.toString();
                      });
                    }),
                    SizedBox(height: boxPadding),
                    mydatePicker(
                      context,
                      () async {
                        await showRoundedDatePicker(
                          // barrierDismissible: true,
                          // height: 100,
                          // fontFamily: 'Itim',
                          context: context,
                          locale: Locale("th", "TH"),
                          era: EraMode.BUDDHIST_YEAR,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 5),
                          borderRadius: 12,
                          styleDatePicker: datePickerStyle,
                          styleYearPicker: yearPickerStyle,
                          theme: datePickerTheme,
                        ).then((value) {
                          if (value != null) {
                            setState(() {
                              // pick_date = value.toString();
                              dateController.text =
                                  "${value.day.toString()}/${value.month.toString()}/${(value.year + 543).toString()}";

                              _infor.infor_4 =
                                  "${value.day.toString()}_${value.month.toString()}_${(value.year + 543).toString()}";
                            });
                          }
                        });
                      },
                      dateController,
                    ),
                  ],
                ),
              ),
              SizedBox(height: boxPadding),
              Container(
                decoration: simpleBoxDecoration,
                width: tabletWidth,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        rankDropdown(_selectedRank1, (newValue) {
                          setState(() {
                            _selectedRank1 = "$newValue";
                          });
                        }, _ranks, "ผู้ตรวจท่านที่ 1"),
                        SizedBox(
                          width: boxPadding,
                        ),
                        Expanded(
                            child: inputBox("", "กรอก", (value) {
                          setState(() {
                            _infor.infor_6 = _selectedRank1 + value.toString();
                          });
                        })),
                      ],
                    ),
                    SizedBox(height: boxPadding),
                    inputBox("โทรศัพท์", "กรอก", (value) {
                      setState(() {
                        _infor.infor_7 = value.toString();
                      });
                    }),
                    SizedBox(height: boxPadding),
                    Row(
                      children: [
                        rankDropdown(_selectedRank2, (newValue) {
                          setState(() {
                            _selectedRank2 = "$newValue";
                          });
                        }, _ranks, "ผู้ตรวจท่านที่ 2"),
                        SizedBox(
                          width: boxPadding,
                        ),
                        Expanded(
                            child: inputBox("", "กรอก", (value) {
                          setState(() {
                            _infor.infor_8 = _selectedRank2 + value.toString();
                          });
                        })),
                      ],
                    ),
                    SizedBox(height: boxPadding),
                    inputBox("โทรศัพท์", "กรอก", (value) {
                      setState(() {
                        _infor.infor_9 = value.toString();
                      });
                    }),
                  ],
                ),
              ),
              SizedBox(height: boxPadding),
              Container(
                decoration: simpleBoxDecoration,
                width: tabletWidth,
                padding: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Row(
                      children: [
                        rankDropdown(_selectedRank3, (newValue) {
                          setState(() {
                            _selectedRank3 = "$newValue";
                          });
                        }, _ranks, "หัวหน้างาน จร."),
                        SizedBox(
                          width: boxPadding,
                        ),
                        Expanded(
                            child: inputBox("", "กรอก", (value) {
                          setState(() {
                            _infor.infor_10 = _selectedRank3 + value.toString();
                          });
                        })),
                      ],
                    ),
                    SizedBox(height: boxPadding),
                    inputBox("โทรศัพท์", "กรอก", (value) {
                      setState(() {
                        _infor.infor_11 = value.toString();
                      });
                    }),
                    SizedBox(height: boxPadding),
                    numberLabel(number1, "มีผู้ปฏิบัติหน้าที่ จร.", (value) {}),
                    SizedBox(height: boxPadding),
                    numberLabel(number2, "ปฏิบัติหน้าที่จริง", (value) {}),
                  ],
                ),
              ),
              SizedBox(height: boxPadding),
              Container(
                decoration: simpleBoxDecoration,
                width: tabletWidth,
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    numberLabel(number3, "รถยนต์", (value) {}),
                    SizedBox(height: boxPadding),
                    numberLabel(number4, "จักรยานยนต์", (value) {}),
                    SizedBox(height: boxPadding),
                    numberLabel(number5, "รถยก", (value) {}),
                  ],
                ),
              ),
              SizedBox(height: boxPadding),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // iconButton(Icons.picture_as_pdf, () async {
                  //   //   // PdfService().printCustomersPdf();
                  //   //   PdfService().downloadPdf(widget.data, _infor);
                  //   // }, "PDF", widthUI),
                  //   // SizedBox(width: boxPadding),
                  // }, "บันทึกข้อมูล", widthUI),
                  iconButton(Icons.picture_as_pdf_rounded, () async {
                    // final Future<FirebaseApp> firebase =
                    //     Firebase.initializeApp();

                    // print(score_1.toString());
                    // print(score_2.toString());
                    // print(score_3.toString());

                    CollectionReference _dataCollection =
                        FirebaseFirestore.instance.collection("datas");
                    _infor.infor_12 = number1.text;
                    _infor.infor_13 = number2.text;
                    _infor.infor_14 = number3.text;
                    _infor.infor_15 = number4.text;
                    _infor.infor_16 = number5.text;

                    await _dataCollection.add({
                      "infor_01": _infor.infor_1,
                      "infor_02": _infor.infor_2,
                      "infor_03": _infor.infor_3,
                      "infor_04": _infor.infor_4,
                      "infor_05": _infor.infor_5,
                      "infor_06": _infor.infor_6,
                      "infor_07": _infor.infor_7,
                      "infor_08": _infor.infor_8,
                      "infor_09": _infor.infor_9,
                      "infor_10": _infor.infor_10,
                      "infor_11": _infor.infor_11,
                      "infor_12": _infor.infor_12,
                      "infor_13": _infor.infor_13,
                      "infor_14": _infor.infor_14,
                      "infor_15": _infor.infor_15,
                      "infor_16": _infor.infor_16,
                      "data_01": '',
                      "data_02": '',
                      "data_03": '',
                      "data_04": '',
                      "data_05": '',
                      "data_06": '',
                      "data_07": '',
                      "data_08": '',
                      "data_09": '',
                      "data_10": '',
                      "data_11": '',
                      "data_12": '',
                      "data_13": '',
                      "data_14": '',
                      "data_15": '',
                      "data_16": '',
                      "data_17": '',
                    }).then((value) {
                      showTopToast();
                      PdfService()
                          .downloadPdf(widget.data, _infor)
                          .then((val) async {
                        await Future.delayed(const Duration(milliseconds: 5000))
                            .then((val) {
                          Restart.restartApp();
                        });
                      });
                    }).catchError((e) {
                      print(e);
                    });
                  }, "บันทึกข้อมูลและสร้าง PDF", widthUI),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showTopToast() => toast.showToast(
        child: buildToast(),
        gravity: ToastGravity.TOP,
      );

  Widget buildToast() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 5,
              offset: Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check_circle_rounded,
              color: Colors.greenAccent,
              size: 32,
            ),
            SizedBox(width: 8),
            Text(
              "บันทักข้อมูลเรียบร้อยแล้ว",
              style: TextStyle(fontSize: 16),
            )
          ],
        ),
      );
}
