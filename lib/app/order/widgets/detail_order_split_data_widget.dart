import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class DetailOrderSplitDataWidget extends StatelessWidget {
  final String title;
  final String data;
  final Widget? customWidget;
  final TextStyle? customDataStyle;
  const DetailOrderSplitDataWidget(
      {super.key,
      required this.title,
      required this.data,
      this.customWidget,
      this.customDataStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 4,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: mainBody5,
            ),
          ),
        ),
        SizedBox(
          width: margin4,
        ),
        Flexible(
          flex: 6,
          child: SizedBox(
            width: double.infinity,
            child: customWidget ??
                Text(
                  data,
                  style: customDataStyle ??
                      mainBody5.copyWith(fontWeight: FontWeight.bold),
                ),
          ),
        )
      ],
    );
  }
}
