import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/health/cubits/health_cubit.dart';
import 'package:travelsya/app/health/cubits/health_state.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/app/health/pages/health_checkout_page.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class HealthDetailPage extends StatefulWidget {
  final bool isHealth;
  final String id;
  const HealthDetailPage({super.key, required this.isHealth, required this.id});

  @override
  State<HealthDetailPage> createState() => _HealthDetailPageState();
}

class _HealthDetailPageState extends State<HealthDetailPage> {
  bool showMore = false;
  final dataKey = new GlobalKey();

  HealthCubit clinicDetailCubit = HealthCubit();

  double getLowestData(List<HealthPackageModel> data) {
    double finalData = data[0].price;

    for (var i = 0; i < data.length; i++) {
      if (data[i].price < finalData) {
        finalData = data[i].price;
      }
    }

    return finalData;
  }

  @override
  void initState() {
    clinicDetailCubit.fetchDetailClinic(context, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatusbarWidget(
        child: Scaffold(
      body: BlocBuilder<HealthCubit, HealthState>(
          bloc: clinicDetailCubit,
          builder: (context, state) {
            if (state is HealthLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else if (state is HealthDetailLoaded) {
              return Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image:
                                          NetworkImage(state.data.mainImage))),
                            ),
                            Positioned(
                              top:
                                  MediaQuery.of(context).padding.top + margin16,
                              left: margin16,
                              right: margin16,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child: Image.asset('assets/new/back.png'),
                                    ),
                                  ),
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white),
                                    alignment: Alignment.center,
                                    child: SizedBox(
                                      width: 18,
                                      height: 18,
                                      child:
                                          Image.asset('assets/new/share.png'),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(margin16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.data.name,
                                style: mainBody2.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: margin8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: Image.asset('assets/new/star.png'),
                                  ),
                                  SizedBox(
                                    width: margin8,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: state.data.avgRating
                                            .toStringAsFixed(1),
                                        style: mainBody4.copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: '/5 ',
                                        style: mainBody5.copyWith(
                                          color: Colors.black87,
                                        )),
                                    TextSpan(
                                        text:
                                            '(${state.data.ratingCount} ulasan)',
                                        style: mainBody5.copyWith(
                                            decoration:
                                                TextDecoration.underline,
                                            color: Colors.black87)),
                                  ])),
                                  // Container(
                                  //   margin: EdgeInsets.symmetric(
                                  //       horizontal: margin8),
                                  //   width: 6,
                                  //   height: 6,
                                  //   decoration: const BoxDecoration(
                                  //       shape: BoxShape.circle,
                                  //       color: Color(0xffa5a5a5)),
                                  // ),
                                  // Text(
                                  //   '2.500 Terjual',
                                  //   style: mainBody5.copyWith(
                                  //       color: Colors.black87),
                                  // )
                                ],
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      'assets/new/location.png',
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(
                                    width: margin16,
                                  ),
                                  Expanded(
                                      child: Text(
                                    state.data.address ?? '-',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: mainBody4.copyWith(
                                        color: Colors.black87),
                                  )),
                                  SizedBox(
                                    width: margin8,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xffa5a5a5),
                                    size: 20,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: Image.asset(
                                      'assets/new/clock.png',
                                      color: Colors.black87,
                                    ),
                                  ),
                                  SizedBox(
                                    width: margin16,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'Buka: ${state.data.openTime ?? '-'} - ${state.data.closeTime ?? '-'} WIB',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: mainBody4.copyWith(
                                        color: Colors.black87),
                                  )),
                                  SizedBox(
                                    width: margin8,
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xffa5a5a5),
                                    size: 20,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: margin24,
                              ),
                              Container(
                                padding: EdgeInsets.all(margin16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: const Color(0xffFFEEF1)),
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Highlight',
                                      style: mainBody3.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: margin16,
                                    ),
                                    Text(
                                      state.data.highlight ?? '-',
                                      style: mainBody4,
                                    ),
                                    // SizedBox(
                                    //   height: margin16,
                                    // ),
                                    // GestureDetector(
                                    //   onTap: () {
                                    //     showMore = !showMore;
                                    //     setState(() {});
                                    //   },
                                    //   child: Text(
                                    //     showMore
                                    //         ? 'Sembunyikan'
                                    //         : 'Baca Selengkapnya',
                                    //     style: mainBody4.copyWith(
                                    //         color:
                                    //             Theme.of(context).primaryColor),
                                    //   ),
                                    // )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          color: const Color(0xfff8f3f2),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                key: dataKey,
                                width: double.infinity,
                                color: Colors.white,
                                padding: EdgeInsets.all(margin16),
                                child: Text(
                                  'Paket',
                                  style: mainBody2.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(margin16),
                                child: Column(
                                  children: List.generate(
                                      state.data.package.length, (index) {
                                    HealthPackageModel data =
                                        state.data.package[index];
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Container(
                                        padding: EdgeInsets.all(margin16),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  data.name,
                                                  style: mainBody4.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                // SizedBox(
                                                //   width: margin8,
                                                // ),
                                                // Text(
                                                //   'Detail',
                                                //   style: mainBody4.copyWith(
                                                //       color: Theme.of(context)
                                                //           .primaryColor),
                                                // )
                                              ],
                                            ),
                                            SizedBox(
                                              height: margin16,
                                            ),
                                            // Row(
                                            //   children: [
                                            //     SizedBox(
                                            //       width: 20,
                                            //       height: 20,
                                            //       child: Image.asset(
                                            //           'assets/new/money.png'),
                                            //     ),
                                            //     SizedBox(
                                            //       width: margin8,
                                            //     ),
                                            //     Expanded(
                                            //         child: Text(
                                            //       'Tidak bisa refund',

                                            //       style: mainBody5,
                                            //     ))
                                            //   ],
                                            // ),
                                            // SizedBox(
                                            //   height: margin8,
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     SizedBox(
                                            //       width: 20,
                                            //       height: 20,
                                            //       child: Image.asset(
                                            //           'assets/new/date.png'),
                                            //     ),
                                            //     SizedBox(
                                            //       width: margin8,
                                            //     ),
                                            //     Expanded(
                                            //         child: Text(
                                            //       'Pesan tiket untuk hari ini',
                                            //       style: mainBody5,
                                            //     ))
                                            //   ],
                                            // ),
                                            // SizedBox(
                                            //   height: margin8,
                                            // ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 20,
                                                  height: 20,
                                                  child: Image.asset(
                                                      'assets/new/clock.png'),
                                                ),
                                                SizedBox(
                                                  width: margin8,
                                                ),
                                                Expanded(
                                                    child: Text(
                                                  'Berlaku hingga ${data.expiredDate} hari sejak dibeli',
                                                  style: mainBody5,
                                                ))
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height: margin8,
                                            // ),
                                            // Row(
                                            //   children: [
                                            //     SizedBox(
                                            //       width: 20,
                                            //       height: 20,
                                            //       child: Image.asset(
                                            //           'assets/new/clock.png'),
                                            //     ),
                                            //     SizedBox(
                                            //       width: margin8,
                                            //     ),
                                            //     Expanded(
                                            //         child: Text(
                                            //       'Reservasi paling lambat 1 hari sebelumnya',
                                            //       style: mainBody5,
                                            //     ))
                                            //   ],
                                            // ),
                                            SizedBox(
                                              height: margin24,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      moneyChanger(
                                                          data.unitPirce,
                                                          customLabel: 'IDR '),
                                                      style: mainBody5.copyWith(
                                                          color: const Color(
                                                              0xffa5a5a5),
                                                          decorationColor:
                                                              const Color(
                                                                  0xffa5a5a5),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough),
                                                    ),
                                                    SizedBox(
                                                      height: margin4,
                                                    ),
                                                    Text(
                                                      moneyChanger(data.price,
                                                          customLabel: 'IDR '),
                                                      style: mainBody4.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )
                                                  ],
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    needLoginFeature(context,
                                                        () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  HealthCheckoutPage(
                                                                    dataPackage:
                                                                        data,
                                                                    dataDetail:
                                                                        state
                                                                            .data,
                                                                  )));
                                                    });
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: margin8,
                                                            horizontal:
                                                                margin16),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                    child: Text(
                                                      'Pilih Paket',
                                                      style: mainBody4.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(margin16),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Review',
                                    style: mainBody2.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  // Text(
                                  //   'Lihat Semua',
                                  //   style: mainBody5.copyWith(
                                  //       color: Theme.of(context).primaryColor),
                                  // )
                                ],
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: Image.asset('assets/new/star.png'),
                                  ),
                                  SizedBox(
                                    width: margin4,
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        state.data.avgRating.toStringAsFixed(1),
                                        style: mainBody1.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        '/5',
                                        style: mainBody4.copyWith(
                                            color: Color(0xffa5a5a5)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: margin16,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Bagus',
                                        style: mainBody4.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Dari ${state.data.ratingCount} review',
                                        style: mainBody5.copyWith(
                                            color: const Color(0xffa5a5a5)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(state.data.comment.length,
                                (index) {
                              HealthCommentModel data =
                                  state.data.comment[index];
                              return Container(
                                margin: EdgeInsets.only(
                                    left: index == 0 ? margin16 : margin8),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Container(
                                    width: 310,
                                    height: 120,
                                    padding: EdgeInsets.all(margin16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            RichText(
                                                text: TextSpan(children: [
                                              TextSpan(
                                                  text: data.rate
                                                      .toDouble()
                                                      .toStringAsFixed(1),
                                                  style: mainBody3.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black87)),
                                              TextSpan(
                                                  text: '/5',
                                                  style: mainBody3.copyWith(
                                                      color: const Color(
                                                          0xffa5a5a5))),
                                            ])),
                                            Text(
                                              data.createdAt == null
                                                  ? '-'
                                                  : dateToReadable(data
                                                      .createdAt!
                                                      .substring(0, 10)),
                                              style: mainBody5.copyWith(
                                                  color:
                                                      const Color(0xffa5a5a5)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Anonim',
                                                style: mainBody5.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                data.comment,
                                                style: mainBody5.copyWith(
                                                    color: const Color(
                                                        0xffa5a5a5)),
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
                          ),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        Container(
                          height: 10,
                          width: double.infinity,
                          color: const Color(0xfff8f3f2),
                        ),
                        Container(
                          padding: EdgeInsets.all(margin16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lokasi',
                                style: mainBody3.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.black12)),
                                child: Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 120,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              topRight: Radius.circular(10)),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/new/maps_example.png'),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(margin16),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: Image.asset(
                                                  'assets/new/location.png',
                                                  color:
                                                      const Color(0xffa5a5a5),
                                                ),
                                              ),
                                              SizedBox(
                                                width: margin16,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                state.data.address ?? '-',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: mainBody5.copyWith(
                                                    color: Colors.black87),
                                              ))
                                            ],
                                          ),
                                          SizedBox(
                                            height: margin16,
                                          ),
                                          SizedBox(
                                            width: double.infinity,
                                            child: Wrap(
                                              alignment: WrapAlignment.start,
                                              children: [
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Color(
                                                                  0xffFFCFCF)),
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child: Image.asset(
                                                            'assets/new/maps.png'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: margin8,
                                                    ),
                                                    Text(
                                                      'Lihat Peta',
                                                      style: mainBody5.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: margin24,
                                                ),
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              color: Colors
                                                                  .black12)),
                                                      alignment:
                                                          Alignment.center,
                                                      child: SizedBox(
                                                        width: 24,
                                                        height: 24,
                                                        child: Image.asset(
                                                            'assets/new/direction.png'),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: margin8,
                                                    ),
                                                    Text(
                                                      'Panduan ke Lokasi',
                                                      style: mainBody5.copyWith(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        Container(
                          height: 10,
                          width: double.infinity,
                          color: const Color(0xfff8f3f2),
                        ),
                        Container(
                          padding: EdgeInsets.all(margin16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Deskripsi',
                                style: mainBody3.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              Text(
                                state.data.description ?? '-',
                                style: mainBody5.copyWith(
                                    color: const Color(0xffa5a5a5)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        Container(
                          height: 10,
                          width: double.infinity,
                          color: const Color(0xfff8f3f2),
                        ),
                        state.data.maybeLike.isEmpty
                            ? Container()
                            : Container(
                                padding:
                                    EdgeInsets.symmetric(vertical: margin16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(left: margin16),
                                      child: Text(
                                        'Mungkin Kamu Suka',
                                        style: mainBody3.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: margin16,
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: List.generate(
                                            state.data.maybeLike.length,
                                            (index) {
                                          HealthPreviewModel data =
                                              state.data.maybeLike[index];
                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          HealthDetailPage(
                                                              isHealth: data
                                                                      .category
                                                                      .toLowerCase() !=
                                                                  'kecantikan',
                                                              id: data.id
                                                                  .toString())));
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  left: margin16),
                                              child: Column(
                                                children: [
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: 160,
                                                        height: 90,
                                                        decoration: BoxDecoration(
                                                            borderRadius: const BorderRadius
                                                                .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                topRight: Radius
                                                                    .circular(
                                                                        8)),
                                                            image: DecorationImage(
                                                                image: NetworkImage(
                                                                    data.image))),
                                                      ),
                                                      Positioned(
                                                        left: margin8,
                                                        bottom: margin8,
                                                        child: Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      margin4,
                                                                  horizontal:
                                                                      margin24 /
                                                                          2),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              color: const Color(
                                                                  0xffFFCFCF)),
                                                          child: Text(
                                                            'Big Deals',
                                                            style: mainBody5.copyWith(
                                                                color: Theme.of(
                                                                        context)
                                                                    .primaryColor),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(
                                                        margin24 / 2),
                                                    margin: EdgeInsets.only(
                                                        bottom: margin16),
                                                    width: 160,
                                                    decoration: const BoxDecoration(
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            offset: Offset(0.0,
                                                                1.0), //(x,y)
                                                            blurRadius: 6.0,
                                                          ),
                                                        ],
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        8),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            8)),
                                                        color: Colors.white),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                                child: Text(
                                                              data.location,
                                                              style: mainBody5.copyWith(
                                                                  color: const Color(
                                                                      0xffa5a5a5)),
                                                            )),
                                                            SizedBox(
                                                              width: margin4,
                                                            ),
                                                            SizedBox(
                                                              width: 16,
                                                              height: 16,
                                                              child: Image.asset(
                                                                  'assets/new/bookmark.png'),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: margin8,
                                                        ),
                                                        Text(
                                                          data.name,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: mainBody4
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        SizedBox(
                                                          height: margin4,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 12,
                                                              height: 12,
                                                              child: Image.asset(
                                                                  'assets/new/star.png'),
                                                            ),
                                                            SizedBox(
                                                              width: margin4,
                                                            ),
                                                            Text(
                                                              data.ratingAvg
                                                                  .toStringAsFixed(
                                                                      1),
                                                              style: mainBody5.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                            Text(
                                                              ' (${data.ratingCount} ulasan)',
                                                              style: mainBody5.copyWith(
                                                                  color: const Color(
                                                                      0xffa5a5a5)),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: margin24,
                                                        ),
                                                        Text(
                                                          moneyChanger(
                                                              data.unitPrice,
                                                              customLabel:
                                                                  'IDR '),
                                                          style: mainBody5.copyWith(
                                                              color: const Color(
                                                                  0xffa5a5a5),
                                                              decorationColor:
                                                                  const Color(
                                                                      0xffa5a5a5),
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough),
                                                        ),
                                                        SizedBox(
                                                          height: margin4,
                                                        ),
                                                        Text(
                                                          moneyChanger(
                                                              data.price,
                                                              customLabel:
                                                                  'IDR '),
                                                          style: mainBody4.copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                        SizedBox(
                          height: margin32,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(margin16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0), //(x,y)
                          blurRadius: 6.0,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Mulai dari',
                              style: mainBody5.copyWith(
                                  color: const Color(0xffa5a5a5)),
                            ),
                            Text(
                              moneyChanger(getLowestData(state.data.package),
                                  customLabel: 'IDR '),
                              style: mainBody4.copyWith(
                                  color: Theme.of(context).primaryColor),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            // Scrollable.ensureVisible(dataKey.currentContext!);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: margin8, horizontal: margin16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor),
                            child: Text(
                              'Pilih Paket',
                              style: mainBody4.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              );
            } else {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: margin16),
                child: FailedRequestWidget(onRetry: () {
                  clinicDetailCubit.fetchDetailClinic(context, id: widget.id);
                }),
              );
            }
          }),
    ));
  }
}
