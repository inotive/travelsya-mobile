import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class SplitRowWidget extends StatelessWidget {
  final String title;
  final String data;
  final Widget? dataCustom;
  const SplitRowWidget(
      {super.key, required this.title, required this.data, this.dataCustom});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 4,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: mainBody4.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(width: margin8),
        Flexible(
          flex: 6,
          child: SizedBox(
            width: double.infinity,
            child: dataCustom ??
                Text(
                  data,
                  style: mainBody4.copyWith(
                    color: Colors.black54,
                  ),
                ),
          ),
        ),
      ],
    );
  }
}
