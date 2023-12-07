import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class HostelDetailInfoSection extends StatelessWidget {
  final HostelDetailModel data;
  const HostelDetailInfoSection({Key? key, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: EdgeInsets.all(5.0.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Info Umum',
                  style: mainFont.copyWith(
                      fontSize: 12.0.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                // Text(
                //   'Baca Semua',
                //   style: mainFont.copyWith(
                //       fontSize: 11.0.sp,
                //       color: Theme.of(context).primaryColor,
                //       fontWeight: FontWeight.bold),
                // )
              ],
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 3.0.w, bottom: 2.0.w),
                width: 80.0.w,
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3.0.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xfff4f4f4)),
                          child: Column(
                            children: [
                              Text(
                                'Check In',
                                style: mainFont.copyWith(
                                    fontSize: 8.0.sp, color: Color(0xffa5a5a5)),
                              ),
                              Text(
                                data.checkIn,
                                style: mainFont.copyWith(
                                    fontSize: 11.0.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 3.0.w),
                        height: double.infinity,
                        width: 1,
                        color: Color(0xffa5a5a5),
                      ),
                      Flexible(
                        flex: 1,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 3.0.w),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xfff4f4f4)),
                          child: Column(
                            children: [
                              Text(
                                'Check Out',
                                style: mainFont.copyWith(
                                    fontSize: 8.0.sp, color: Color(0xffa5a5a5)),
                              ),
                              Text(
                                data.checkOut,
                                style: mainFont.copyWith(
                                    fontSize: 11.0.sp,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      // Column(
      //   children: List.generate(3, (index) {
      //     return Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Row(
      //           children: [
      //             SizedBox(
      //               width: 5.0.w,
      //               child: Text(
      //                 '${index + 1}.',
      //                 style: mainFont.copyWith(
      //                     fontSize: 11.0.sp, color: Colors.black87),
      //               ),
      //             ),
      //             Expanded(
      //                 child: Text(
      //               'Anak diatas umur 5 tahun dikenakan biaya',
      //               style: mainFont.copyWith(
      //                   fontSize: 10.0.sp, color: Colors.black87),
      //             ))
      //           ],
      //         ),
      //         index == 0
      //             ? Center(
      //                 child: Container(
      //                   margin:
      //                       EdgeInsets.only(top: 3.0.w, bottom: 2.0.w),
      //                   width: 80.0.w,
      //                   child: IntrinsicHeight(
      //                     child: Row(
      //                       children: [
      //                         Flexible(
      //                           flex: 1,
      //                           child: Container(
      //                             padding: EdgeInsets.symmetric(
      //                                 vertical: 3.0.w),
      //                             width: double.infinity,
      //                             decoration: BoxDecoration(
      //                                 borderRadius:
      //                                     BorderRadius.circular(8),
      //                                 color: Color(0xfff4f4f4)),
      //                             child: Column(
      //                               children: [
      //                                 Text(
      //                                   'Check In',
      //                                   style: mainFont.copyWith(
      //                                       fontSize: 8.0.sp,
      //                                       color: Color(0xffa5a5a5)),
      //                                 ),
      //                                 Text(
      //                                   '10:00 AM',
      //                                   style: mainFont.copyWith(
      //                                       fontSize: 11.0.sp,
      //                                       color: Colors.black87,
      //                                       fontWeight:
      //                                           FontWeight.bold),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                         Container(
      //                           margin: EdgeInsets.symmetric(
      //                               horizontal: 3.0.w),
      //                           height: double.infinity,
      //                           width: 1,
      //                           color: Color(0xffa5a5a5),
      //                         ),
      //                         Flexible(
      //                           flex: 1,
      //                           child: Container(
      //                             padding: EdgeInsets.symmetric(
      //                                 vertical: 3.0.w),
      //                             width: double.infinity,
      //                             decoration: BoxDecoration(
      //                                 borderRadius:
      //                                     BorderRadius.circular(8),
      //                                 color: Color(0xfff4f4f4)),
      //                             child: Column(
      //                               children: [
      //                                 Text(
      //                                   'Check Out',
      //                                   style: mainFont.copyWith(
      //                                       fontSize: 8.0.sp,
      //                                       color: Color(0xffa5a5a5)),
      //                                 ),
      //                                 Text(
      //                                   '10:00 AM',
      //                                   style: mainFont.copyWith(
      //                                       fontSize: 11.0.sp,
      //                                       color: Colors.black87,
      //                                       fontWeight:
      //                                           FontWeight.bold),
      //                                 ),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               )
      //             : Container()
      //       ],
      //     );
      //   }),
      // ),
    ]);
  }
}
