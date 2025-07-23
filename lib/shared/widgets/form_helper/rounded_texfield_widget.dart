import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RoundedTextfield extends StatelessWidget {
  final String? hintText;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final bool? obscureText;
  final double? customRadius;
  final Widget? prefixIcon;
  final String? labelText;
  final bool withBorder;
  final Function()? onEditingComplete;
  final String? validation;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final FocusNode? focusNode;
  final EdgeInsetsGeometry? contentPadding;
  final int? maxLines;
  final Color? customColorFill;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final bool? enabled;
  final int? maxLength;
  final Function()? onTap;
  final TextEditingController? controller;

  const RoundedTextfield({
    super.key,
    this.hintText,
    this.onChanged,
    this.onEditingComplete,
    this.prefixWidget,
    this.suffixIcon,
    this.obscureText,
    this.customRadius,
    this.prefixIcon,
    this.labelText,
    this.withBorder = true,
    this.validation,
    this.validator,
    this.keyboardType,
    this.prefixText,
    this.prefixStyle,
    this.focusNode,
    this.contentPadding,
    this.maxLines,
    this.customColorFill,
    this.inputFormatters,
    this.enabled,
    this.maxLength,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onEditingComplete: onEditingComplete,
      enabled: enabled ?? true,
      validator: (value) {
        return validator == null ? null : validator!(value!);
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
      style: mainBody4,
      decoration: InputDecoration(
          labelText: labelText,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Color(0xffA5A5A5))),
          labelStyle: mainBody4.copyWith(color: Theme.of(context).primaryColor),
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
          prefixStyle:
              prefixStyle ?? mainBody4,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(
                vertical: margin8,
                horizontal: margin24 / 2,
              ),
          errorMaxLines: 10,
          hintStyle: mainBody4.copyWith(color: neutral60),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(customRadius ?? 6),
          )),
    );
  }
}
