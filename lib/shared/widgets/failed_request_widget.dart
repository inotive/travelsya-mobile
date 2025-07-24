import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class FailedRequestWidget extends StatelessWidget {
  final Function onRetry;
  const FailedRequestWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: margin16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: Image.asset(
              'assets/icons/logo.png',
            ),
          ),
          SizedBox(
            height: margin24 / 2,
          ),
          Text(
            'Gagal Memuat Data',
            style: mainBody3.copyWith(
                color: Colors.black87, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: margin4,
          ),
          Text(
            'Gagal memuat data, silahkan coba lagi',
            textAlign: TextAlign.center,
            style: mainBody4.copyWith(
              color: Colors.black54,
            ),
          ),
          SizedBox(
            height: margin16,
          ),
          FormHelper.borderButton(context, onTap: () {
            onRetry();
          }, title: 'Coba Lagi')
        ],
      ),
    );
  }
}
