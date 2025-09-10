import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RekreasiRulesCheckoutSection extends StatelessWidget {
  const RekreasiRulesCheckoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Peraturan',
              style: mainBody4.copyWith(
                  fontWeight: FontWeight.bold, color: neutral100),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              'Reflexology 30 menit',
              style: mainBody4.copyWith(
                  fontWeight: FontWeight.w600, color: primaryColor),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nisl justo, imperdiet ut metus sit amet, semper molestie quam. Pellentesque molestie ante tempus mauris tincidunt, sed elementum massa venenatis. Duis facilisis urna massa, ut varius nibh viverra in. ',
          style: secondaryBody5.copyWith(color: neutral100),
        )
      ],
    );
  }
}
