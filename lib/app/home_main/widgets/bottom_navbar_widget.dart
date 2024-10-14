import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class BottomNavbarWidget extends StatelessWidget {
  final String title;
  final bool showIcon;
  final Function onTap;
  final String iconsAsset;
  final bool isActive;
  const BottomNavbarWidget(
      {super.key,
      required this.title,
      required this.iconsAsset,
      required this.isActive,
      required this.onTap,
      this.showIcon = true});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: margin8),
          child: Column(
            children: [
              Center(
                child: !showIcon
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                      )
                    : SizedBox(
                        width: 22,
                        height: 22,
                        child: ImageIcon(
                          AssetImage(iconsAsset),
                          color: isActive
                              ? Theme.of(context).primaryColor
                              : neutral70,
                        )),
              ),
              Text(title,
                  style: mainBody5.copyWith(
                      color: isActive ? neutral100 : neutral70))
            ],
          ),
        ),
      ),
    );
  }
}
