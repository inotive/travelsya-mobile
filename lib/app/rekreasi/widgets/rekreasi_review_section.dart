import 'package:flutter/material.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RekreasiReviewSection extends StatelessWidget {
  final RecreationDetailModel data;
  const RekreasiReviewSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review',
                    style: mainBody3.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  // GestureDetector(
                  //   onTap: () {},
                  //   child: Text(
                  //     'Lihat Semua',
                  //     style: mainBody4.copyWith(
                  //         color: Theme.of(context).primaryColor,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // )
                ],
              ),
              SizedBox(
                height: margin16,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(margin24 / 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: neutral50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(Icons.star_rounded,
                            color: Theme.of(context).primaryColor, size: 20),
                        SizedBox(
                          width: margin4,
                        ),
                        Text(
                          data.avgRating.toStringAsFixed(1),
                          style: mainBody3.copyWith(
                              color: neutral100, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' /5',
                          style: mainBody4.copyWith(
                              color: neutral50, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: margin24 / 2,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.avgRating.toStringAsFixed(1),
                        style: mainBody4.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'dari ${data.ratingCount} review',
                        style: mainBody5.copyWith(
                            color: neutral70, fontWeight: FontWeight.w400),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: IntrinsicHeight(
              child: Row(
                children: List.generate(data.comment.length, (index) {
                  return Container(
                    margin: EdgeInsets.only(
                        left: index == 0 ? margin16 : 0,
                        right: index == data.comment.length - 1 ? margin16 : 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 200),
                        padding: EdgeInsets.all(margin24 / 2),
                        height: double.infinity,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: margin24,
                                  height: margin24,
                                  child: Icon(Icons.account_circle,
                                      color: neutral50, size: margin24),
                                ),
                                SizedBox(width: margin24 / 2),
                                Expanded(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Anonim',
                                      style: mainBody4.copyWith(
                                          color: neutral100,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data.comment[index].createdAt == null
                                          ? '-'
                                          : dateToReadable(data
                                              .comment[index].createdAt!
                                              .substring(0, 10)),
                                      style:
                                          mainBody5.copyWith(color: neutral50),
                                    )
                                  ],
                                )),
                                SizedBox(width: margin24 / 2),
                                Icon(
                                  Icons.star_rounded,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: margin4),
                                Text(
                                  data.comment[index].rate
                                      .toDouble()
                                      .toStringAsFixed(1),
                                  style: mainBody4.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: margin24 / 2),
                              width: double.infinity,
                              height: 1,
                              color: neutral50.withOpacity(0.3),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                data.comment[index].comment,
                                style: mainBody5.copyWith(color: neutral100),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
        SizedBox(
          height: margin32,
        ),
      ],
    );
  }
}
