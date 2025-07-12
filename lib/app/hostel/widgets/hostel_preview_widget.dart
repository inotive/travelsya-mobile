import 'package:flutter/material.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/app/hostel/pages/hostel_detail_page/hostel_detail_page.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class HostelPreviewWidget extends StatelessWidget {
  final HostelPreviewModel data;
  const HostelPreviewWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HostelDetailPage(
                      id: data.id.toString(),
                    )));
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
                    color: Colors.black12,
                    image: data.image == null
                        ? const DecorationImage(
                            fit: BoxFit.cover,
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
                  Text(
                    data.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: mainFont.copyWith(
                        fontSize: 13,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.location ?? '-',
                    style: mainFont.copyWith(
                        fontSize: 11, color: const Color(0xffa5a5a5)),
                  ),
                  SizedBox(
                    height: margin8,
                  ),
                  Row(
                    children: [
                      Text(
                        'mulai dari ',
                        style: mainFont.copyWith(
                            fontSize: 11, color: const Color(0xffa5a5a5)),
                      ),
                      Text(
                        moneyChanger(data.sellingPrice, customLabel: ''),
                        style: mainFont.copyWith(
                            fontSize: 11,
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
                        data.ratingAvg.toStringAsFixed(1),
                        style: mainFont.copyWith(
                            fontSize: 13,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '(${data.ratingCount})',
                        style: mainFont.copyWith(
                          fontSize: 11,
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
