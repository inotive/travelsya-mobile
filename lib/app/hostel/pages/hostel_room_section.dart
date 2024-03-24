import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class HostelRoomSection extends StatefulWidget {
  final List<HostelRoom> data;
  final HostelDetailModel dataHostel;
  final Function(int) onTap;
  const HostelRoomSection(
      {Key? key,
      required this.data,
      required this.dataHostel,
      required this.onTap})
      : super(key: key);

  @override
  State<HostelRoomSection> createState() => _HostelRoomSectionState();
}

class _HostelRoomSectionState extends State<HostelRoomSection> {
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
          padding: EdgeInsets.only(top: 5.0.w, left: 5.0.w, right: 5.0.w),
          width: double.infinity,
          child: Text(
            'Tipe Kamar',
            style: mainFont.copyWith(
                fontSize: 12.0.sp,
                color: Colors.black87,
                fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 5.0.w,
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
              margin: EdgeInsets.only(bottom: 3.0.w, left: 5.0.w, right: 5.0.w),
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
                      decoration: const BoxDecoration(
                          // image: DecorationImage(
                          //     fit: BoxFit.cover,
                          //     image: NetworkImage(
                          //         '${baseUrl}storage/${widget.data[index].images[0]}')),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          color: Colors.black12),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(3.0.w),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.data[index].name,
                              style: mainFont.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11.0.sp,
                                  color: const Color(0xff333333)),
                            ),
                            Text(
                              'Tidak bisa refund dan reschedule',
                              style: mainFont.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: neutral30,
                                  fontSize: 9.0.sp),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 3.0.w),
                              width: double.infinity,
                              height: 1,
                              color: neutral30.withOpacity(0.3),
                            ),
                            Column(
                              children:
                                  List.generate(dataFacility.length, (index) {
                                return Container(
                                  margin: EdgeInsets.only(bottom: 1.0.w),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 6.0.w,
                                        height: 6.0.w,
                                        child: Image.asset(
                                            dataFacility[index]['assets']!),
                                      ),
                                      SizedBox(
                                        width: 2.0.w,
                                      ),
                                      Expanded(
                                          child: Text(
                                        dataFacility[index]['title']!,
                                        style: mainFont.copyWith(
                                            fontSize: 10.0.sp,
                                            color: neutral100,
                                            fontWeight: FontWeight.w400),
                                      ))
                                    ],
                                  ),
                                );
                              }),
                            ),
                            SizedBox(
                              height: 3.0.w,
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
                                                  fontSize: 10.0.sp,
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
                                                    fontSize: 12.0.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor)),
                                          ])),
                                    ),
                                    SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        '/kamar/malam (termasuk pajak)',
                                        style: mainFont.copyWith(
                                            fontSize: 9.0.sp, color: neutral30),
                                      ),
                                    )
                                  ],
                                )),
                                SizedBox(
                                  width: 3.0.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.onTap(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 3.0.w, horizontal: 5.0.w),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    child: Text(
                                      'Pesan',
                                      style: mainFont.copyWith(
                                          fontSize: 11.0.sp,
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
          height: 2.0.w,
        ),
        Container(
          width: double.infinity,
          height: 2.0.w,
          color: const Color(0xfff4f4f4),
        ),
      ],
    );
  }
}
