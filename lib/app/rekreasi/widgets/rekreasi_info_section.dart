import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class RekreasiInfoSection extends StatelessWidget {
  const RekreasiInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Container(
      //   padding: EdgeInsets.all(margin16),
      //   child: Column(
      //     children: [
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Text(
      //             'Info Umum',
      //             style: mainFont.copyWith(
      //                 fontSize: 14,
      //                 color: Colors.black87,
      //                 fontWeight: FontWeight.bold),
      //           ),
      //           // Text(
      //           //   'Baca Semua',
      //           //   style: mainFont.copyWith(
      //           //       fontSize: 11.0.sp,
      //           //       color: Theme.of(context).primaryColor,
      //           //       fontWeight: FontWeight.bold),
      //           // )
      //         ],
      //       ),
      //       Center(
      //         child: Container(
      //           margin: EdgeInsets.only(top: margin24 / 2, bottom: margin8),
      //           width: MediaQuery.of(context).size.width * 0.8,
      //           child: IntrinsicHeight(
      //             child: Row(
      //               children: [
      //                 Flexible(
      //                   flex: 1,
      //                   child: Container(
      //                     padding: EdgeInsets.symmetric(vertical: margin24 / 2),
      //                     width: double.infinity,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(8),
      //                         color: const Color(0xfff4f4f4)),
      //                     child: Column(
      //                       children: [
      //                         Text(
      //                           'Buka',
      //                           style: mainFont.copyWith(
      //                               fontSize: 10,
      //                               color: const Color(0xffa5a5a5)),
      //                         ),
      //                         Text(
      //                           '08:00 AM',
      //                           style: mainFont.copyWith(
      //                               fontSize: 13,
      //                               color: Colors.black87,
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 Container(
      //                   margin: EdgeInsets.symmetric(horizontal: margin24 / 2),
      //                   height: double.infinity,
      //                   width: 1,
      //                   color: const Color(0xffa5a5a5),
      //                 ),
      //                 Flexible(
      //                   flex: 1,
      //                   child: Container(
      //                     padding: EdgeInsets.symmetric(vertical: margin24 / 2),
      //                     width: double.infinity,
      //                     decoration: BoxDecoration(
      //                         borderRadius: BorderRadius.circular(8),
      //                         color: const Color(0xfff4f4f4)),
      //                     child: Column(
      //                       children: [
      //                         Text(
      //                           'Tutup',
      //                           style: mainFont.copyWith(
      //                               fontSize: 10,
      //                               color: const Color(0xffa5a5a5)),
      //                         ),
      //                         Text(
      //                           '21:00 PM',
      //                           style: mainFont.copyWith(
      //                               fontSize: 13,
      //                               color: Colors.black87,
      //                               fontWeight: FontWeight.bold),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
      SizedBox(
        height: margin16,
      ),
      Container(
        margin: EdgeInsets.only(left: margin16),
        child: Text(
          'Info Umum',
          style: mainBody3.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: EdgeInsets.all(margin16),
        child: Column(
          children: List.generate(3, (index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: margin16,
                      child: Text(
                        '${index + 1}.',
                        style: mainBody4.copyWith(color: Colors.black87),
                      ),
                    ),
                    Expanded(
                        child: Text(
                      index == 0
                          ? 'Waktu buka dan tutup layanan'
                          : 'Anak diatas umur 5 tahun dikenakan biaya',
                      style: mainBody4.copyWith(color: Colors.black87),
                    ))
                  ],
                ),
                index == 0
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              top: margin24 / 2, bottom: margin8),
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: margin24 / 2),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xfff4f4f4)),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Buka',
                                          style: mainBody5.copyWith(
                                              color: const Color(0xffa5a5a5)),
                                        ),
                                        Text(
                                          '10:00 AM',
                                          style: mainBody4.copyWith(
                                              color: Colors.black87,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: margin24 / 2),
                                  height: double.infinity,
                                  width: 1,
                                  color: const Color(0xffa5a5a5),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: margin24 / 2),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xfff4f4f4)),
                                    child: Column(
                                      children: [
                                        Text(
                                          'Tutup',
                                          style: mainBody5.copyWith(
                                              color: const Color(0xffa5a5a5)),
                                        ),
                                        Text(
                                          '10:00 AM',
                                          style: mainBody4.copyWith(
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
                    : Container()
              ],
            );
          }),
        ),
      ),
      Container(
        width: double.infinity,
        height: 8,
        color: const Color(0xfff4f4f4),
      ),
    ]);
  }
}
