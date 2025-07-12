import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/health/cubits/health_cubit.dart';
import 'package:travelsya/app/health/cubits/health_state.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/app/health/pages/health_detail_page.dart';
import 'package:travelsya/app/health/pages/health_search_result_page.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class HealthSearchPage extends StatefulWidget {
  const HealthSearchPage({super.key});

  @override
  State<HealthSearchPage> createState() => _HealthSearchPageState();
}

class _HealthSearchPageState extends State<HealthSearchPage> {
  int selectedIndex = 0;

  HealthCubit healthHomeCubit = HealthCubit();
  HealthCubit beautyHomeCubit = HealthCubit();

  HealthCubit healthBeautyCubit = HealthCubit();

  String? selectedCity;

  @override
  void initState() {
    healthHomeCubit.fetchHealthCategory(context);
    beautyHomeCubit.fetchHealthCategory(context, isHealth: false);
    healthBeautyCubit.fetchHealthBeautyHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 200,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage('assets/new/health_beauty.png'))),
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black45,
                ),
              ),
              Positioned(
                left: margin16,
                top: MediaQuery.of(context).padding.top + margin24,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 37,
                        height: 37,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: Image.asset('assets/new/back.png'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: margin48,
                    ),
                    Text(
                      'Health & Beauty',
                      style: mainBody3.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: double.infinity,
                  height: 20,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      color: Colors.white),
                ),
              )
            ],
          ),
          SizedBox(
            height: margin16,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 0;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: margin24 / 2),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: selectedIndex == 0
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent))),
                    child: Text(
                      'Health',
                      style: mainBody4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: selectedIndex == 0
                              ? Theme.of(context).primaryColor
                              : const Color(0xffa5a5a5)),
                    ),
                  ),
                ),
                SizedBox(
                  width: margin16,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = 1;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: margin24 / 2),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: selectedIndex == 1
                                    ? Theme.of(context).primaryColor
                                    : Colors.transparent))),
                    child: Text(
                      'Beauty',
                      style: mainBody4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: selectedIndex == 1
                              ? Theme.of(context).primaryColor
                              : const Color(0xffa5a5a5)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: margin16,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: margin16),
            child: GestureDetector(
              onTap: () async {
                String? result = await showCityPicker(context);

                if (result != null) {
                  setState(() {
                    selectedCity = result;
                  });
                }
              },
              child: FormHelper.dropdownForm(context,
                  data: selectedCity ?? 'Semua Lokasi',
                  hintText: 'Kota Reservasi'),
            ),
          ),
          // SizedBox(
          //   height: margin16,
          // ),
          // Container(
          //   margin: EdgeInsets.symmetric(horizontal: margin16),
          //   padding: EdgeInsets.symmetric(vertical: 14, horizontal: margin16),
          //   decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(8),
          //       border: Border.all(color: const Color(0xffa5a5a5))),
          //   child: Row(
          //     children: [
          //       SizedBox(
          //         width: 18,
          //         height: 18,
          //         child: Image.asset('assets/new/date_2.png'),
          //       ),
          //       SizedBox(
          //         width: margin16,
          //       ),
          //       Expanded(
          //           child: Text(
          //         'Tanggal reservasi',
          //         style: mainBody5.copyWith(color: const Color(0xffa5a5a5)),
          //       ))
          //     ],
          //   ),
          // ),
          SizedBox(
            height: margin16,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: margin16),
              child: ElevatedButtonWidget(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => HealthSearchResultPage(
                                isHealth: selectedIndex == 0,
                              )));
                },
                title: 'Cari Sekarang',
              )),
          SizedBox(
            height: margin16,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: margin16),
            color: const Color(0xfff8f3f2),
            child: BlocBuilder<HealthCubit, HealthState>(
                bloc: selectedIndex == 0 ? healthHomeCubit : beautyHomeCubit,
                builder: (context, state) {
                  if (state is HealthLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ));
                  } else if (state is HealthHomeLoaded) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: margin16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 24,
                                    height: 24,
                                    child: Image.asset('assets/new/deals.png'),
                                  ),
                                  SizedBox(
                                    width: margin8,
                                  ),
                                  Expanded(
                                      child: Text(
                                    'Special Deals',
                                    style: mainBody4.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ))
                                ],
                              ),
                              SizedBox(
                                height: margin4,
                              ),
                              Text(
                                'Nikmati berbagai pilihan promo menarik dari kami',
                                style: mainBody5.copyWith(
                                    color: const Color(0xffa5a5a5)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(state.specialDeal.length,
                                (index) {
                              HealthPreviewModel data =
                                  state.specialDeal[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => HealthDetailPage(
                                              isHealth: selectedIndex == 0,
                                              id: data.id.toString())));
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: margin16),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: 160,
                                            height: 90,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8)),
                                                image: DecorationImage(
                                                    image: NetworkImage(
                                                        data.image))),
                                          ),
                                          Positioned(
                                            left: margin8,
                                            bottom: margin8,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: margin4,
                                                  horizontal: margin24 / 2),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color:
                                                      const Color(0xffFFCFCF)),
                                              child: Text(
                                                'Big Deals',
                                                style: mainBody5.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(margin24 / 2),
                                        width: 160,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(8),
                                                bottomRight:
                                                    Radius.circular(8)),
                                            color: Colors.white),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  data.location,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                              overflow: TextOverflow.ellipsis,
                                              style: mainBody4.copyWith(
                                                  fontWeight: FontWeight.bold),
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
                                                      .toStringAsFixed(1),
                                                  style: mainBody5.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                              moneyChanger(data.unitPrice,
                                                  customLabel: 'IDR '),
                                              style: mainBody5.copyWith(
                                                  color:
                                                      const Color(0xffa5a5a5),
                                                  decorationColor:
                                                      const Color(0xffa5a5a5),
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            SizedBox(
                                              height: margin4,
                                            ),
                                            Text(
                                              moneyChanger(data.price,
                                                  customLabel: 'IDR '),
                                              style: mainBody4.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context)
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
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: margin16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: margin16),
                  child: Text(
                    'Kebutuhan Kesehatan dan Kecantikan',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: margin4,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: margin16),
                  child: Text(
                    'Jelajahi kategori-kategori kami untuk kebahagiaan maksimal',
                    style: mainBody4.copyWith(color: const Color(0xffa5a5a5)),
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                BlocBuilder<HealthCubit, HealthState>(
                    bloc:
                        selectedIndex == 0 ? healthHomeCubit : beautyHomeCubit,
                    builder: (context, state) {
                      if (state is HealthLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else if (state is HealthHomeLoaded) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                List.generate(state.category.length, (index) {
                              return Container(
                                width: 140,
                                height: 70,
                                margin: EdgeInsets.only(
                                    right: index == state.category.length - 1
                                        ? margin16
                                        : 0,
                                    left: index == 0 ? margin16 : margin8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage(
                                            'assets/new/deals_image.png'))),
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black38),
                                  padding: EdgeInsets.all(margin8),
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    state.category[index].name,
                                    style: mainBody5.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    })
              ],
            ),
          ),
          Container(
            height: 8,
            width: double.infinity,
            color: const Color(0xfff8f3f2),
          ),
          SizedBox(
            height: margin16,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kebutuhan Kesehatan dan Kecantikan',
                        style: mainBody3.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: margin4,
                      ),
                      Text(
                        'Jelajahi kategori-kategori kami untuk kebahagiaan maksimal',
                        style:
                            mainBody4.copyWith(color: const Color(0xffa5a5a5)),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                BlocBuilder<HealthCubit, HealthState>(
                    bloc: healthBeautyCubit,
                    builder: (context, state) {
                      if (state is HealthLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else if (state is HealthBeautyHomeLoaded) {
                        List<HealthPreviewModel> dataFinal =
                            selectedIndex == 0 ? state.health : state.beauty;

                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: margin16),
                          width: double.infinity,
                          child: Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            children: List.generate(dataFinal.length, (index) {
                              return FractionallySizedBox(
                                widthFactor: 0.49,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => HealthDetailPage(
                                                  isHealth: selectedIndex == 0,
                                                  id: dataFinal[index]
                                                      .id
                                                      .toString(),
                                                )));
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 167 / 100,
                                          child: Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(8),
                                                        topRight:
                                                            Radius.circular(8)),
                                                image: DecorationImage(
                                                    fit: BoxFit.fitWidth,
                                                    image: NetworkImage(
                                                        dataFinal[index]
                                                            .image))),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(margin24 / 2),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: Text(
                                                      dataFinal[index].category,
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
                                                  dataFinal[index].name,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: mainBody4.copyWith(
                                                      color: Colors.black87,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: margin16,
                                                ),
                                                Text(
                                                  moneyChanger(
                                                      dataFinal[index]
                                                          .unitPrice,
                                                      customLabel: 'IDR '),
                                                  style: mainBody5.copyWith(
                                                      color: const Color(
                                                          0xffa5a5a5),
                                                      decorationColor:
                                                          const Color(
                                                              0xffa5a5a5),
                                                      decoration: TextDecoration
                                                          .lineThrough),
                                                ),
                                                SizedBox(
                                                  height: margin4,
                                                ),
                                                Text(
                                                  moneyChanger(
                                                      dataFinal[index].price,
                                                      customLabel: 'IDR '),
                                                  style: mainBody4.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Theme.of(context)
                                                          .primaryColor),
                                                )
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                // SizedBox(
                //   height: margin16,
                // ),
                // Container(
                //   padding: EdgeInsets.symmetric(horizontal: margin16),
                //   child: FormHelper.borderButton(context,
                //       onTap: () {}, title: 'Lihat Semua'),
                // )
              ],
            ),
          ),
          SizedBox(
            height: margin32,
          )
        ],
      ),
    );
  }
}
