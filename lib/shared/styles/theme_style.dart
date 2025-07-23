import 'package:flutter/material.dart';

Color primaryColor = const Color(0xffC02425);
Color primarySufaceColor = const Color(0xffF3FFF9);

Color primaryBorderColor = const Color(0xffA4DDC3);

Color secondaryColor = const Color(0xffFB7A48);
Color disableSecondaryColor = const Color(0xffffcab9);

Color successColor = const Color(0xff06C270);
Color warningColor = const Color(0xffFFCC00);
Color infoColor = const Color(0xff0063F7);
Color errorColor = const Color(0xffFF3B3B);

Color neutral10 = const Color(0xffFFFFFF);
Color neutral10Stroke = const Color(0xffD9D9D9);
Color neutral20 = const Color(0xffF9F9F9);
Color neutral30 = const Color(0xffA5A5A5);
// Color neutral30 = const Color(0xffECECEC);
Color neutral40 = const Color(0xffD8D8D8);
Color neutral50 = const Color(0xffBABABA);
Color neutral60 = const Color(0xff989898);
Color neutral70 = const Color(0xff717171);
Color neutral80 = const Color(0xff5D5D5D);
Color neutral90 = const Color(0xff3D3D3D);
Color neutral100 = const Color(0xff0A0A0A);

ThemeData mainTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: neutral10,
    cardColor: Colors.white,
    cardTheme: const CardTheme(color: Colors.white),
    dividerColor: Colors.transparent);
