import 'package:flutter/material.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class HotelRoomTypeSection extends StatefulWidget {
  final List<HostelRoom> data;
  final HostelModel dataHostel;
  final Function(int) onTap;
  const HotelRoomTypeSection(
      {super.key,
      required this.data,
      required this.dataHostel,
      required this.onTap});

  @override
  State<HotelRoomTypeSection> createState() => _HotelRoomTypeSectionState();
}

class _HotelRoomTypeSectionState extends State<HotelRoomTypeSection> {
  String getCategoryRead(String data) {
    String returnValue = '';

    if (data == 'Harian') {
      returnValue = 'Hari';
    } else if (data == 'Tahunan') {
      returnValue = 'Tahun';
    } else if (data == "Bulanan") {
      returnValue = 'Bulan';
    }

    return returnValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          width: double.infinity,
          child: Text(
            'Tipe Kamar',
            style: mainFont.copyWith(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        Column(
          children: List.generate(widget.data.length, (index) {
            List<Map<String, String>> dataFacility = [
              {
                'assets': 'assets/icons/users.png',
                'title': '${widget.data[index].guest} Tamu'
              },
              {
                'assets': 'assets/icons/bed 1.png',
                'title': widget.data[index].bedType
              },
            ];
            return Container(
              margin: EdgeInsets.only(
                  bottom: margin24 / 2, left: margin16, right: margin16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                      color: const Color(0xffa5a5a5).withOpacity(0.3))),
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 167 / 100,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  '${baseUrl}storage/${widget.data[index].images[0]}')),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Colors.black12),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(margin24 / 2),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data[index].name,
                              style: mainFont.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: const Color(0xff333333)),
                            ),
                            Text(
                              'Tidak bisa refund dan reschedule',
                              style: mainFont.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: neutral30,
                                  fontSize: 11),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.symmetric(vertical: margin24 / 2),
                              width: double.infinity,
                              height: 1,
                              color: neutral30.withOpacity(0.3),
                            ),
                            Column(
                              children:
                                  List.generate(dataFacility.length, (index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: margin4),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Image.asset(
                                            dataFacility[index]['assets']!),
                                      ),
                                      SizedBox(
                                        width: margin8,
                                      ),
                                      Expanded(
                                          child: Text(
                                        dataFacility[index]['title']!,
                                        style: mainFont.copyWith(
                                            fontSize: 12,
                                            color: neutral100,
                                            fontWeight: FontWeight.w400),
                                      ))
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      width: double.infinity,
                                      child: RichText(
                                          text: TextSpan(
                                              style: mainFont.copyWith(
                                                  fontSize: 12,
                                                  color: neutral30),
                                              children: [
                                            const TextSpan(text: 'mulai '),
                                            // TextSpan(
                                            //     text: '1,750,000',
                                            //     style: TextStyle(
                                            //         decoration: TextDecoration
                                            //             .lineThrough)),
                                            TextSpan(
                                                text: moneyChanger(
                                                    widget.data[index].price
                                                        .toDouble(),
                                                    customLabel: 'IDR '),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ])),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '/kamar/${getCategoryRead(widget.dataHostel.category ?? '')} (termasuk pajak)',
                                        style: mainFont.copyWith(
                                            fontSize: 11, color: neutral30),
                                      ),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: margin24 / 2,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.onTap(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: margin24 / 2,
                                        horizontal: margin16),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                      'Pesan',
                                      style: mainFont.copyWith(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ]))
                ],
              ),
            );
          }),
        ),
        SizedBox(
          height: margin8,
        ),
        Container(
          width: double.infinity,
          height: 8,
          color: const Color(0xfff4f4f4),
        ),
      ],
    );
  }
}
