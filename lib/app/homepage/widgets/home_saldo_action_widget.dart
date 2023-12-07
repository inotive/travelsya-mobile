import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class HomeSaldoActionWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final String iconAsset;
  const HomeSaldoActionWidget(
      {Key? key,
      required this.iconAsset,
      required this.title,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xfff6f6f6)),
                child: FractionallySizedBox(
                  widthFactor: 0.4,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(iconAsset),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: margin4),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: mainBody5,
            )
          ],
        ),
      ),
    );
  }
}
