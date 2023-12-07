import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

showSnackbar(BuildContext context, {required String data, Color? colors}) {
  final snack = SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
    content: Text(
      data,
      style: mainBody4.copyWith(color: neutral10),
    ),
    backgroundColor: colors,
  );
  ScaffoldMessenger.of(context).showSnackBar(snack);
}
