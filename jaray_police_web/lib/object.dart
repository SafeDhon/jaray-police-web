import 'package:flutter/material.dart';
// import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:jaray_police_web/constant.dart';
import 'package:jaray_police_web/my_icons_icons.dart';

AppBar myAppbar(int path, BuildContext context, String txt) {
  return AppBar(
    flexibleSpace: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 2.0),
              blurRadius: 10.0,
              spreadRadius: 0.5)
        ],
        // gradient: LinearGradient(
        //     begin: Alignment.topLeft,
        //     end: Alignment.bottomRight,
        //     colors: <Color>[Colors.black, color3]),
      ),
    ),
    backgroundColor: color2,
    title: Text(
      txt,
      style:
          TextStyle(color: color1, fontWeight: FontWeight.w500, fontSize: 18),
    ),
    leading: Image.asset('assets/images/logo.jpg'),

    actions: [
      path == 1
          ? Container()
          : path == 2
              ? IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.home_rounded),
                )
              : path == 3
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.menu_rounded),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.menu_rounded),
                    )
    ],
    centerTitle: false,
    automaticallyImplyLeading: false,
    // centerTitle: true,
    // title: Text(
    //   'การควบคุมและการจัดการจราจร',
    //   style: TextStyle(color: color1, fontWeight: FontWeight.w500),
    // ),
    // leading: Image.asset('assets/images/logo.jpg'),
    // actions: [Image.asset('assets/images/logo.jpg')],
  );
}

SizedBox mydatePicker(BuildContext context, Function() function,
    TextEditingController controller) {
  return SizedBox(
    // width: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('เมื่อวันที่'),
        SizedBox(height: labelPadding),
        TextField(
            controller: controller,
            readOnly: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(12),
                border: OutlineInputBorder(),
                hintText: 'เลือกวันที่',
                suffixIcon: Icon(Icons.calendar_month)),
            showCursor: false,
            onTap: function),
      ],
    ),
  );
}

SizedBox numberLabel(TextEditingController controller, String label,
    Function(String) onChanged) {
  controller.text = '0';
  int value;

  return SizedBox(
    child: Row(
      children: [
        SizedBox(width: 150, child: Text(label)),
        SizedBox(
          width: 120,
          child: TextField(
            onChanged: onChanged,
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
        )
      ],
    ),
  );
}

Column rankDropdown(
    var value, Function(Object?) onChanged, List list, String label) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: TextStyle(),
      ),
      SizedBox(height: labelPadding),
      Container(
        width: 100,
        decoration: dropdownDeccoration,
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            padding: EdgeInsets.symmetric(horizontal: 12),
            hint: Text("ยศ"),
            isExpanded: true,
            // menuMaxHeight: 200,
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
  );
}

SizedBox commentBox(
    String label, String hint, TextEditingController controller) {
  return SizedBox(
    // width: 300,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(color: color2, fontSize: 16),
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        SizedBox(height: labelPadding),
        TextField(
          maxLines: 5,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(12),
            border: OutlineInputBorder(),
            hintText: hint,
          ),
          controller: controller,
        ),
      ],
    ),
  );
}
