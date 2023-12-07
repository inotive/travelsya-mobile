import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
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
                  fontSize: 10.0.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        SizedBox(width: 2.0.w),
        Flexible(
          flex: 6,
          child: SizedBox(
            width: double.infinity,
            child: dataCustom ??
                Text(
                  data,
                  style: mainFont.copyWith(
                    fontSize: 10.0.sp,
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
          EdgeInsets.only(left: 2.0.w, right: 2.0.w, top: 2.0.w, bottom: 2.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title,
              maxLines: 1,
              style: mainFont.copyWith(
                  fontSize: customSize ?? 10.sp,
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

  static Widget roundedTextfield(
    BuildContext context, {
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixWidget,
    bool? obscureText,
    double? customRadius,
    Widget? prefixWidget,
    String? labelText,
    bool withBorder = true,
    Function()? onEditingComplete,
    String? validation,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    String? prefixText,
    TextStyle? prefixStyle,
    FocusNode? focusNode,
    EdgeInsetsGeometry? contentPadding,
    int? maxLines,
    Color? customColorFill,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    bool? enabled,
    int? maxLength,
    Function()? onTap,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      onEditingComplete: onEditingComplete,
      enabled: enabled ?? true,
      validator: (value) {
        return validator == null ? null : validator(value!);
      },
      onChanged: onChanged,
      maxLength: maxLength,
      focusNode: focusNode,
      onTap: onTap,
      cursorColor: Theme.of(context).primaryColor,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      style: TextStyle(
        fontSize: 11.0.sp,
      ),
      decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Color(0xffA5A5A5))),
          labelStyle: mainFont.copyWith(
              fontSize: 11.0.sp, color: Theme.of(context).primaryColor),
          hintText: hintText,
          focusedBorder: withBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(customRadius ?? 6),
                )
              : null,
          fillColor: customColorFill ?? Colors.white,
          filled: true,
          prefixText: prefixText,
          prefix: prefixWidget,
          prefixStyle: prefixStyle ??
              TextStyle(
                  fontSize: 11.0.sp,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                vertical: 2.0.h,
                horizontal: 3.0.w,
              ),
          errorMaxLines: 10,
          hintStyle: mainFont.copyWith(
            fontSize: 11.0.sp,
            color: Colors.black87.withOpacity(0.3),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixWidget,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(customRadius ?? 6),
          )),
    );
  }

  static Widget titleWithWidget(
      {double? customTitleSize,
      double? customMargin,
      bool? withHelp = false,
      String? validation,
      bool isRequired = false,
      required String title,
      required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(
                    title,
                    style: mainFont.copyWith(
                      color: Colors.black87,
                      fontSize: customTitleSize ?? 11.0.sp,
                    ),
                  ),
                  isRequired
                      ? Text(
                          ' *',
                          style: mainFont.copyWith(
                            color: Colors.red,
                            fontSize: customTitleSize ?? 11.0.sp,
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: customMargin ?? 2.0.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget,
            validation == null
                ? Container()
                : Container(
                    margin: EdgeInsets.only(top: 1.0.w),
                    child: Text(
                      validation,
                      style: mainFont.copyWith(
                          fontSize: 8.0.sp, color: Colors.red),
                    ),
                  )
          ],
        )
      ],
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
          width: 4.0.w,
          height: 4.0.w,
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
            width: 1.5.w,
            height: 1.5.w,
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
          width: 2.0.w,
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
                    fontSize: 10.0.sp,
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

  static Widget elevatedButtonBasic(BuildContext context,
      {required enabled,
      required Function() onTap,
      bool isLoading = false,
      required String title,
      double? customTextSize,
      EdgeInsetsGeometry? customPadding}) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            primary: isLoading ? Colors.grey : Theme.of(context).primaryColor),
        onPressed: enabled ? onTap : null,
        child: Container(
          width: double.infinity,
          padding: customPadding ?? EdgeInsets.symmetric(vertical: 1.5.h),
          child: Center(
            heightFactor: 1,
            child: Text(
              title,
              style: TextStyle(
                  fontSize: customTextSize ?? 12.0.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
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
        padding: customPadding ?? EdgeInsets.symmetric(vertical: 1.5.h),
        child: Center(
          heightFactor: 1,
          child: Text(
            title,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: customTextSize ?? 12.0.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
