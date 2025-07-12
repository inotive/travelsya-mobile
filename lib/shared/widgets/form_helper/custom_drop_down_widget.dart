import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class CustomDropdown extends StatelessWidget {
  final String? hintText;
  final String? value;
  const CustomDropdown({super.key, this.hintText, this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding:
          EdgeInsets.symmetric(vertical: margin24 / 2, horizontal: margin16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black87)),
      child: Row(
        children: [
          Expanded(
            child: Text(value == null ? hintText ?? '' : value!,
                style: mainBody4.copyWith(
                    color: value == null ? Colors.black54 : Colors.black87)),
          ),
          SizedBox(width: margin8),
          const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: Colors.black87,
          )
        ],
      ),
    );
  }
}
