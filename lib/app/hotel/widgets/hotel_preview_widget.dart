import 'package:flutter/material.dart';
import 'package:travelsya/app/hotel/models/hotel_preview_model.dart';
import 'package:travelsya/app/hotel/pages/hotel_detail_page/hotel_detail_page.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class HotelPreviewWidget extends StatelessWidget {
  final HotelPreview data;
  const HotelPreviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data.id != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HotelDetailPage(
                        id: data.id.toString(),
                      )));
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 167 / 100,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8)),
                    color: data.image == null ? Colors.white : Colors.black12,
                    image: data.image == null
                        ? const DecorationImage(
                            image: AssetImage('assets/icons/logo.jpg'))
                        : DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(data.image!))),
              ),
            ),
            Container(
              padding: EdgeInsets.all(margin24 / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 50,
                    child: Text(
                      data.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: mainBody4.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    data.location,
                    style: mainBody5.copyWith(color: neutral80),
                  ),
                  SizedBox(
                    height: margin8,
                  ),
                  Row(
                    children: [
                      Text(
                        'mulai dari ',
                        style: mainBody5.copyWith(color: neutral80),
                      ),
                      Text(
                        moneyChanger(data.sellingPrice ?? 0, customLabel: ''),
                        style: mainBody5.copyWith(
                            color: Theme.of(context).primaryColor),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: margin4,
                      ),
                      Text(
                        data.avgRating.toStringAsFixed(1),
                        style: mainBody4.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        ' (${data.ratingCount})',
                        style: mainBody5.copyWith(
                          color: const Color(0xffa5a5a5),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotelPreviewCard extends StatelessWidget {
  final HotelPreview data;
  const HotelPreviewCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data.id != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => HotelDetailPage(
                        id: data.id.toString(),
                      )));
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: margin24 / 2),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xffA5A5A5))),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 2 / 1,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: data.image == null
                          ? const DecorationImage(
                              image: AssetImage('assets/icons/logo.jpg'))
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(data.image!)),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12))),
                ),
              ),
              Container(
                padding: EdgeInsets.all(margin24 / 2),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: mainBody4.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: margin4,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        SizedBox(width: margin4),
                        Text(
                          '${data.avgRating.toStringAsFixed(1)} ',
                          style: mainBody4.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '(${data.ratingCount})',
                          style: mainBody5.copyWith(
                            color: const Color(0xffa5a5a5),
                          ),
                        ),
                        SizedBox(
                          width: margin8,
                        ),
                        Text(
                          data.location,
                          style: mainBody5.copyWith(
                              color: const Color(0xffa5a5a5)),
                        )
                      ],
                    ),
                    SizedBox(height: margin24 / 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'mulai dari ',
                          style: mainBody5.copyWith(
                              color: const Color(0xffa5a5a5)),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        moneyChanger(data.sellingPrice ?? 0),
                        style: mainBody4.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        '(Sudah Termasuk Pajak)',
                        style:
                            mainBody5.copyWith(color: const Color(0xffa5a5a5)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
