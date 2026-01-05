import 'package:flutter/material.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RekreasiRulesCheckoutSection extends StatelessWidget {
  final RecreationPackageModel package;
  const RekreasiRulesCheckoutSection({super.key, required this.package});

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
              package.name,
              style: mainBody4.copyWith(
                  fontWeight: FontWeight.w600, color: primaryColor),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          package.rule,
          // 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse nisl justo, imperdiet ut metus sit amet, semper molestie quam. Pellentesque molestie ante tempus mauris tincidunt, sed elementum massa venenatis. Duis facilisis urna massa, ut varius nibh viverra in. ',
          style: secondaryBody5.copyWith(color: neutral100),
        )
      ],
    );
  }
}
