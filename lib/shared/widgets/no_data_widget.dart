import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: margin16,
        ),
        SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/icons/logo.jpg',
          ),
        ),
        SizedBox(
          height: margin24 / 2,
        ),
        Text(
          'Data Kosong',
          style: mainBody3.copyWith(
              color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: margin4,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: margin32),
          child: Text(
            'Data Tidak Ditemukan',
            textAlign: TextAlign.center,
            style: mainBody4.copyWith(
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}
