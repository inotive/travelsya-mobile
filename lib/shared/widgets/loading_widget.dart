import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), color: neutral10),
        alignment: Alignment.center,
        child: SizedBox(
            width: 100,
            height: 100,
            child: Lottie.asset(ConstHelper.loadingAsset)),
      ),
    );
  }
}
