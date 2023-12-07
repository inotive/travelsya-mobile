import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class FailedRequestHorizontalWidget extends StatelessWidget {
  final Function onRetry;
  const FailedRequestHorizontalWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Gagal Memuat Data',
              style: mainBody4.copyWith(
                  color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: margin4,
            ),
            Text(
              'Gagal memuat data, silahkan coba lagi',
              textAlign: TextAlign.center,
              style: mainBody5.copyWith(
                color: Colors.black54,
              ),
            ),
          ],
        )),
        SizedBox(
          width: margin8,
        ),
        GestureDetector(
          onTap: () {
            onRetry();
          },
          child: Container(
            padding:
                EdgeInsets.symmetric(vertical: margin8, horizontal: margin16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor),
            child: Text(
              'Coba Lagi',
              style: mainBody5.copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
