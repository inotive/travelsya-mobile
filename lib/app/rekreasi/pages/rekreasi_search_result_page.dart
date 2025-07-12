import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_cubit.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_state.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_detail_page.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class RekreasiSearchResultPage extends StatefulWidget {
  final String? city;
  const RekreasiSearchResultPage({super.key, this.city});

  @override
  State<RekreasiSearchResultPage> createState() =>
      _RekreasiSearchResultPageState();
}

class _RekreasiSearchResultPageState extends State<RekreasiSearchResultPage> {
  RecreationCubit searchCubit = RecreationCubit();

  @override
  void initState() {
    searchCubit.onLoadSearchRecreation(context, city: widget.city);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatusbarWidget(
      customBrightness: Brightness.dark,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Container(
              padding: EdgeInsets.all(margin16),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: Image.asset('assets/new/back.png'),
                    ),
                  ),
                  SizedBox(
                    width: margin16,
                  ),
                  Expanded(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xffa5a5a5))),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          SizedBox(
                            width: margin16,
                          ),
                          SizedBox(
                            width: 16,
                            height: 16,
                            child: Image.asset('assets/new/search.png'),
                          ),
                          SizedBox(
                            width: margin8,
                          ),
                          Expanded(
                              child: TextField(
                            decoration: InputDecoration(
                                isDense: true,
                                hintText: 'Cari Rekreasi',
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.zero,
                                hintStyle: mainBody4.copyWith(
                                    color: const Color(0xffa5a5a5))),
                          )),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: margin8, vertical: margin8),
                            height: double.infinity,
                            width: 1,
                            color: const Color(0xffa5a5a5),
                          ),
                          Container(
                            padding:
                                EdgeInsets.symmetric(vertical: margin24 / 2),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: Image.asset('assets/new/location.png'),
                                ),
                                SizedBox(
                                  width: margin4,
                                ),
                                Text(
                                  widget.city ?? 'Semua Lokasi',
                                  style: mainBody5.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).primaryColor),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: margin16,
                          )
                        ],
                      ),
                    ),
                  ))
                ],
              ),
            ),
            Expanded(
                child: BlocBuilder<RecreationCubit, RecreationState>(
                    bloc: searchCubit,
                    builder: (context, state) {
                      if (state is RecreationLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else if (state is RecreationPreviewListLoaded) {
                        return ListView(
                          padding: EdgeInsets.symmetric(horizontal: margin16),
                          children: [
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            Text(
                              'Rekreasi',
                              style: mainBody2.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: 'Menampilkan',
                                  style: mainBody4.copyWith(
                                      color: const Color(0xffa5a5a5))),
                              TextSpan(
                                  text: ' ${state.data.length}',
                                  style: mainBody4.copyWith(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: ' hasil pencarian',
                                  style: mainBody4.copyWith(
                                      color: const Color(0xffa5a5a5)))
                            ])),
                            // SizedBox(
                            //   height: margin16,
                            // ),
                            // SingleChildScrollView(
                            //   scrollDirection: Axis.horizontal,
                            //   child: Row(
                            //     children: List.generate(4, (index) {
                            //       return Container(
                            //         margin: EdgeInsets.only(right: margin8),
                            //         padding: EdgeInsets.symmetric(
                            //             vertical: margin8, horizontal: margin8),
                            //         decoration: BoxDecoration(
                            //             borderRadius: BorderRadius.circular(20),
                            //             border: Border.all(
                            //                 color: const Color(0xffa5a5a5))),
                            //         child: Row(
                            //           children: [
                            //             SizedBox(
                            //               width: 16,
                            //               height: 16,
                            //               child: Image.asset(index == 0
                            //                   ? 'assets/new/filter.png'
                            //                   : index == 1
                            //                       ? 'assets/new/date.png'
                            //                       : index == 2
                            //                           ? 'assets/new/money.png'
                            //                           : 'assets/new/filter.png'),
                            //             ),
                            //             SizedBox(
                            //               width: margin4,
                            //             ),
                            //             Text(
                            //               index == 0
                            //                   ? 'Filter'
                            //                   : index == 1
                            //                       ? 'Tanggal'
                            //                       : index == 2
                            //                           ? 'Harga'
                            //                           : 'Urutkan',
                            //               style: mainBody4,
                            //             )
                            //           ],
                            //         ),
                            //       );
                            //     }),
                            //   ),
                            // ),
                            SizedBox(
                              height: margin16,
                            ),
                            Column(
                              children:
                                  List.generate(state.data.length, (index) {
                                RecreationPreviewModel data = state.data[index];
                                return Container(
                                  margin: EdgeInsets.only(bottom: margin24 / 2),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  RekreasiDetailPage(
                                                    id: data.id!.toString(),
                                                  )));
                                    },
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                width: double.infinity,
                                                height: 156,
                                                decoration: BoxDecoration(
                                                    color: Colors.black12,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                            data.image)),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    12),
                                                            topRight:
                                                                Radius.circular(
                                                                    12))),
                                              ),
                                              // Positioned(
                                              //   bottom: margin8,
                                              //   left: 0,
                                              //   right: 0,
                                              //   child: Row(
                                              //     mainAxisAlignment:
                                              //         MainAxisAlignment.center,
                                              //     children:
                                              //         List.generate(5, (index) {
                                              //       return Container(
                                              //         margin: EdgeInsets.only(
                                              //             left: index == 0
                                              //                 ? 0
                                              //                 : margin4),
                                              //         width:
                                              //             index == 1 ? 20 : 6,
                                              //         height: 6,
                                              //         decoration: index == 1
                                              //             ? BoxDecoration(
                                              //                 borderRadius:
                                              //                     BorderRadius
                                              //                         .circular(
                                              //                             8),
                                              //                 color: Theme.of(
                                              //                         context)
                                              //                     .primaryColor)
                                              //             : const BoxDecoration(
                                              //                 shape: BoxShape
                                              //                     .circle,
                                              //                 color: Colors
                                              //                     .white60),
                                              //       );
                                              //     }),
                                              //   ),
                                              // )
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(margin16),
                                            width: double.infinity,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 16,
                                                          height: 16,
                                                          child: Image.asset(
                                                              'assets/new/location_border.png'),
                                                        ),
                                                        SizedBox(
                                                          width: margin8,
                                                        ),
                                                        Text(
                                                          data.location,
                                                          style: mainBody5.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: const Color(
                                                                  0xffa5a5a5)),
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                      height: 20,
                                                      child: Image.asset(
                                                          'assets/new/bookmark.png'),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: margin24 / 2,
                                                ),
                                                Text(
                                                  data.name,
                                                  style: mainBody3.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: margin16,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      width: 18,
                                                      height: 18,
                                                      child: Image.asset(
                                                          'assets/new/star.png'),
                                                    ),
                                                    SizedBox(
                                                      width: margin8,
                                                    ),
                                                    Expanded(
                                                        child: RichText(
                                                            text: TextSpan(
                                                                children: [
                                                          TextSpan(
                                                              text: data
                                                                  .avgRating
                                                                  .toStringAsFixed(
                                                                      1),
                                                              style: mainBody4.copyWith(
                                                                  color: Colors
                                                                      .black87,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold)),
                                                          TextSpan(
                                                              text: '/5',
                                                              style: mainBody5
                                                                  .copyWith(
                                                                color: Colors
                                                                    .black87,
                                                              )),
                                                          TextSpan(
                                                              text:
                                                                  ' (${data.ratingCount} ulasan)',
                                                              style: mainBody5
                                                                  .copyWith(
                                                                color: const Color(
                                                                    0xffa5a5a5),
                                                              )),
                                                        ])))
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: margin16,
                                                ),
                                                Text(
                                                  moneyChanger(data.price,
                                                      customLabel: 'IDR '),
                                                  style: mainBody4.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            )
                          ],
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: margin16),
                          child: FailedRequestWidget(onRetry: () {
                            searchCubit.onLoadSearchRecreation(context,
                                city: widget.city);
                          }),
                        );
                      }
                    }))
          ],
        ),
      ),
    );
  }
}
