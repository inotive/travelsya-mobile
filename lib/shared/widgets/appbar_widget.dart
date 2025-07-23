import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

PreferredSizeWidget appbarBasicWidget(BuildContext context,
    {required String title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: AppBar(
      elevation: 1,
      backgroundColor: Theme.of(context).primaryColor,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Center(
        child: Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: mainBody3.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    ),
  );
}

PreferredSizeWidget appbarWidget(
  BuildContext context, {
  required String title,
  Widget? suffixIcon,
  Color? customColor,
  Color? customForeground,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: AppBar(
      elevation: 1,
      backgroundColor: customColor ?? Colors.white,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      title: Container(
        width: double.infinity,
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
            SizedBox(width: margin24 / 2),
            Expanded(
              child: Text(
                title,
                style: mainBody4.copyWith(
                  color: customForeground ?? Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            suffixIcon ?? const SizedBox(),
          ],
        ),
      ),
    ),
  );
}
