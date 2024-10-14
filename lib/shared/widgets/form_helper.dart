import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class FormHelper {
  static Widget splitRow(
      {required String data, required String title, Widget? dataCustom}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          flex: 4,
          child: SizedBox(
            width: double.infinity,
            child: Text(
              title,
              style: mainFont.copyWith(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
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
                  style: mainFont.copyWith(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
          ),
        ),
      ],
    );
  }

  static Widget tabbarData(BuildContext context,
      {required String title,
      required int index,
      double? customSize,
      required int currentIndex,
      EdgeInsetsGeometry? customMargin}) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: index == currentIndex
                      ? Theme.of(context).primaryColor
                      : Colors.transparent))),
      padding: customMargin ??
          EdgeInsets.only(
              left: margin8, right: margin8, top: margin8, bottom: margin8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              maxLines: 1,
              style: mainFont.copyWith(
                  fontSize: customSize ?? 12,
                  color: index == currentIndex
                      ? Theme.of(context).primaryColor
                      : Colors.black38,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }

  static Widget dropdownForm(BuildContext context,
      {String? data,
      IconData? customIcons,
      Widget? customWidget,
      required String hintText}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          vertical: margin24 / 2, horizontal: margin24 / 2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xffA5A5A5))),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: customWidget ??
                  Text(
                    data ?? hintText,
                    maxLines: 1,
                    style: data == null
                        ? mainFont.copyWith(
                            fontSize: 13,
                            color: Colors.black87.withOpacity(0.3),
                          )
                        : mainFont.copyWith(
                            fontSize: 13, color: Colors.black87),
                  ),
            ),
          ),
          SizedBox(width: margin8),
          Icon(
            customIcons ?? Icons.keyboard_arrow_down_rounded,
            color: const Color(0xFFAFBDD8),
          )
        ],
      ),
    );
  }

  static Widget optionsCircle(BuildContext context,
      {required String title,
      required Function() onTap,
      Widget? customDetailWidget,
      bool isBold = false,
      required bool status}) {
    Widget roundedIndicator(bool isActive) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive
                  ? Theme.of(context).primaryColor
                  : Colors.transparent,
              border: Border.all(
                  width: 1,
                  color:
                      isActive ? Theme.of(context).primaryColor : neutral30)),
          alignment: Alignment.center,
          child: Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.white : Colors.transparent),
          ),
        ),
      );
    }

    return Row(
      crossAxisAlignment: customDetailWidget == null
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        roundedIndicator(status),
        SizedBox(
          width: margin8,
        ),
        GestureDetector(
          onTap: () {
            onTap();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: mainFont.copyWith(
                    fontSize: 12,
                    color: neutral100,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
              ),
              customDetailWidget ?? Container()
            ],
          ),
        ),
      ],
    );
  }

  static Widget borderButton(BuildContext context,
      {required Function() onTap,
      required String title,
      double? customTextSize,
      EdgeInsetsGeometry? customPadding}) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Theme.of(context).primaryColor),
          color: Colors.transparent,
        ),
        padding: customPadding ?? const EdgeInsets.symmetric(vertical: 8),
        child: Center(
          heightFactor: 1,
          child: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: customTextSize ?? 14,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
