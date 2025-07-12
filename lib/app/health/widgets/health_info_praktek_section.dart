import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class HealthInfoPraktekSection extends StatelessWidget {
  const HealthInfoPraktekSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: margin16,
      ),
      Container(
        margin: EdgeInsets.only(left: margin16),
        child: Text(
          'Jadwal Praktek',
          style: mainBody3.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(margin16),
        child: Column(
          children: List.generate(3, (index) {
            return Container(
              margin: EdgeInsets.only(top: index == 0 ? 0 : margin8),
              padding: EdgeInsets.symmetric(
                  vertical: margin24 / 2, horizontal: margin16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: neutral30),
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    'Senin - Sabtu',
                    style: mainBody5,
                  )),
                  SizedBox(
                    width: margin8,
                  ),
                  Text(
                    '10:00 - 12:00',
                    style: mainBody5.copyWith(
                        fontWeight: FontWeight.bold, color: neutral60),
                  )
                ],
              ),
            );
          }),
        ),
      ),
      Container(
        width: double.infinity,
        height: 8,
        color: const Color(0xfff4f4f4),
      ),
    ]);
  }
}
