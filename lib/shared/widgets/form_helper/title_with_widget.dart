import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class TitleWithWidget extends StatelessWidget {
  final double? customTitleSize;
  final double? customMargin;
  final bool withHelp;
  final String? validation;
  final bool isRequired;
  final String title;
  final Widget child;

  const TitleWithWidget(
      {super.key,
      this.customTitleSize,
      this.customMargin,
      this.withHelp = false,
      this.validation,
      this.isRequired = false,
      required this.title,
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(title,
                      style: mainFont.copyWith(
                        fontSize: customTitleSize ?? 14,
                      )),
                  isRequired
                      ? Text(
                          ' *',
                          style: mainFont.copyWith(
                            color: Colors.red,
                            fontSize: customTitleSize ?? 16,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: customMargin ?? margin8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            child,
            validation == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: margin4),
                    child: Text(
                      validation!,
                      style: mainBody5.copyWith(color: Colors.red),
                    ),
                  )
          ],
        )
      ],
    );
  }
}
