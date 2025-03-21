import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:jaray_police_web/my_icons_icons.dart';

const double desktopFontsize = 20;
const double tabletFontsize = 16;
const double mobileFontsize = 12;

var primaryColor = Color(0xFF91191B);
var backgroudColor = Colors.red[100];
var greyColor = Color(0xFFCEC9C9);

// var color1 = Color(0xFF050505);
// var color2 = Color(0xFF610C27);
// var color3 = Color(0xFFAC9C8D);
// var color4 = Color(0xFFE3C1B4);
// var color5 = Color(0xFFDDD9CE);
// var color6 = Color(0xFFEFECE9);

var color1 = Color(0xFF2b0000);
var color2 = Color(0xFF4b0000);
var color3 = Color(0xFF8d0000);
var color4 = Color(0xFFff9191);
var color5 = Color(0xFFffdada);
var color6 = Color(0xFFffdada);

double labelPadding = 4;
double boxPadding = 16;
double singlechildPadding = 16;
double boxRadius = 12;

double tabletWidth = 1000;
double mobileWidth = 500;

class UIconst {
  double padding;
  UIconst({
    required this.padding,
  });
}

UIconst mobile = UIconst(
  padding: 12,
);

SizedBox inputBox(String label, String hint, Function(String) onChanged) {
  return SizedBox(
    // width: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(),
        ),
        SizedBox(height: labelPadding),
        TextField(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            border: OutlineInputBorder(),
            hintText: hint,
          ),
          onChanged: onChanged,
        ),
      ],
    ),
  );
}

SizedBox numberBox(TextEditingController controller) {
  controller.text = '0';
  int value;
  return SizedBox(
    width: 120,
    child: TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        // hintText: 'number',
        prefixIcon: InkWell(
            onTap: () {
              if (int.parse(controller.text) > 0) {
                value = int.parse(controller.text) - 1;
                controller.text = value.toString();
              }
            },
            child: const Icon(MyIcons.minus, size: 15)),
        suffixIcon: InkWell(
          onTap: () {
            value = int.parse(controller.text) + 1;
            controller.text = value.toString();
          },
          child: const Icon(MyIcons.plus, size: 15),
        ),
      ),
    ),
  );
}

BoxDecoration dropdownDeccoration = BoxDecoration(
    color: Colors.transparent,
    border: Border.all(color: Colors.black45),
    borderRadius: BorderRadius.circular(4));

SizedBox simpleButton(
  Function()? onPressed,
  String text,
  double widthUI,
) {
  return SizedBox(
    // width: 300,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(18),
        backgroundColor: color2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(boxRadius),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: widthUI >= tabletWidth ? desktopFontsize : tabletFontsize,
        ),
      ),
    ),
  );
}

Container iconButton(
  IconData icon,
  Function()? onPressed,
  String text,
  double widthUI,
) {
  return Container(
    // height: 30,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade500,
          blurRadius: 10,
          spreadRadius: 0.5,
          offset: const Offset(2, 2),
        ),
      ],
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.0, 1.5],
        colors: [color2, color3],
      ),
      // color: Colors.deepPurple.shade300,
      borderRadius: BorderRadius.circular(boxRadius),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 8,horizontal: 12),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(boxRadius),
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 30,
          ),
          SizedBox(width: boxPadding),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize:
                  widthUI >= tabletWidth ? desktopFontsize : tabletFontsize,
            ),
          ),
        ],
      ),
    ),
  );
}

BoxDecoration simpleBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.circular(boxRadius),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.shade500,
      blurRadius: 10,
      spreadRadius: 0.5,
      offset: const Offset(2, 2),
    )
  ],
);

Container zoneDropdown(String label, String hint, var value,
    Function(Object?) onChanged, List list) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: color2),
        ),
        SizedBox(height: labelPadding),
        Container(
          decoration: dropdownDeccoration,
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              padding: EdgeInsets.symmetric(horizontal: 12),
              hint: Text(hint),
              isExpanded: true,
              menuMaxHeight: 200,
              value: value,
              onChanged: onChanged,
              items: list.map((label) {
                return DropdownMenuItem(
                  child: new Text(label),
                  value: label,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

ThemeData datePickerTheme = ThemeData(
  primaryColor: color2,
  dialogBackgroundColor: Colors.white,
  textTheme: GoogleFonts.itimTextTheme(),
);

MaterialRoundedYearPickerStyle yearPickerStyle = MaterialRoundedYearPickerStyle(
  textStyleYearSelected:
      TextStyle(fontSize: 24, color: color3, fontWeight: FontWeight.bold),
);

MaterialRoundedDatePickerStyle datePickerStyle = MaterialRoundedDatePickerStyle(
  textStyleDayButton: TextStyle(fontSize: 32, color: Colors.white),
  textStyleYearButton: TextStyle(fontSize: 22, color: Colors.white),
  textStyleDayHeader: TextStyle(fontSize: 18, color: Colors.black54),
  textStyleCurrentDayOnCalendar:
      TextStyle(fontSize: 18, color: color3, fontWeight: FontWeight.bold),
  textStyleMonthYearHeader: TextStyle(fontSize: 24),
  textStyleButtonPositive: TextStyle(color: color2, fontSize: 18),
  textStyleButtonNegative:
      TextStyle(color: color2.withOpacity(0.8), fontSize: 18),
  decorationDateSelected: BoxDecoration(color: color4, shape: BoxShape.circle),
);
