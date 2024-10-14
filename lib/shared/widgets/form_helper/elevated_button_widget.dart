import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final bool enabled;
  final Function() onTap;
  final bool isLoading;
  final String title;
  final double? customTextSize;
  final EdgeInsetsGeometry? customPadding;

  const ElevatedButtonWidget(
      {super.key,
      this.enabled = true,
      required this.onTap,
      this.isLoading = false,
      this.title = '',
      this.customTextSize,
      this.customPadding});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            foregroundColor: Colors.white,
            backgroundColor:
                isLoading ? Colors.grey : Theme.of(context).primaryColor),
        onPressed: enabled ? onTap : null,
        child: Container(
          width: double.infinity,
          padding:
              customPadding ?? EdgeInsets.symmetric(vertical: margin24 / 2),
          child: Center(
            heightFactor: 1,
            child: Text(title,
                style: mainBody4.copyWith(
                    fontSize: customTextSize ?? 14,
                    fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
