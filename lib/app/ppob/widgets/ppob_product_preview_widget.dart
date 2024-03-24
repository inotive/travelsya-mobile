import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class PPOBProductPreviewWidget extends StatelessWidget {
  final bool isActive;
  final String title;
  final String desc;
  final Function onTap;
  final double? customFractionWidth;
  const PPOBProductPreviewWidget(
      {Key? key,
      required this.isActive,
      required this.title,
      this.customFractionWidth,
      required this.desc,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isActive ? Theme.of(context).primaryColor : Colors.white,
              ),
              alignment: Alignment.topRight,
              child: SizedBox(
                width: 15.0.w,
                height: 15.0.w,
                child: Image.asset(
                  'assets/icons/Group 23.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: customFractionWidth ?? 0.32,
            child: Container(
              padding: EdgeInsets.all(margin24 / 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: isActive
                          ? Theme.of(context).primaryColor
                          : neutral10Stroke)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: mainBody4.copyWith(
                        color: isActive ? Colors.white : neutral100,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    desc,
                    style: mainBody5.copyWith(
                      color: isActive ? Colors.white : neutral70,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
