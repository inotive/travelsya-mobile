import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

AppBar appbarBasicWidget(BuildContext context, {required String title}) {
  return AppBar(
    elevation: 1,
    backgroundColor: Theme.of(context).primaryColor,
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    title: Container(
        padding: EdgeInsets.symmetric(horizontal: margin16),
        child: Text(
          title,
          style: mainBody4.copyWith(
              color: Colors.white, fontWeight: FontWeight.bold),
        )),
  );
}

AppBar appbarWidget(BuildContext context,
    {required String title,
    Widget? suffixWidget,
    Color? customColor,
    Color? customForeground}) {
  return AppBar(
    elevation: 1,
    backgroundColor: customColor ?? Colors.white,
    titleSpacing: 0,
    automaticallyImplyLeading: false,
    title: Container(
      padding: EdgeInsets.symmetric(horizontal: margin16),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: customForeground ?? Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            width: margin24 / 2,
          ),
          Expanded(
              child: Text(
            title,
            style: mainBody4.copyWith(
                color: customForeground ?? Colors.black87,
                fontWeight: FontWeight.bold),
          )),
          suffixWidget ?? const SizedBox()
        ],
      ),
    ),
  );
}
