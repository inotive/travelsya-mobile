import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travelsya/app/health/cubits/health_city_cubit.dart';
import 'package:travelsya/app/health/cubits/health_cubit.dart';
import 'package:travelsya/app/health/cubits/health_state.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/app/health/pages/health_detail_page.dart';
import 'package:travelsya/app/health/pages/health_search_result_page.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';
import 'package:travelsya/shared/widgets/date_picker_single.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class HealthSearchPage extends StatefulWidget {
  const HealthSearchPage({super.key});

  @override
  State<HealthSearchPage> createState() => _HealthSearchPageState();
}

class _HealthSearchPageState extends State<HealthSearchPage> {
  int selectedIndex = 0;
  DateTime? selectedDate;

  HealthCubit healthHomeCubit = HealthCubit();
  HealthCubit beautyHomeCubit = HealthCubit();
  HealthCubit spaHomeCubit = HealthCubit();

  HealthCubit healthBeautyCubit = HealthCubit();

  HealthCityModel? selectedCity;

  @override
  void initState() {
    healthHomeCubit.fetchHealthCategory(context);
    beautyHomeCubit.fetchHealthCategory(context, isHealth: false);
    healthBeautyCubit.fetchHealthBeautyHome(context);
    spaHomeCubit.fetchSpaHome(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HealthCityCubit(),
      child: SafeArea(
        child: Scaffold(
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
                    left: margin16, top: margin16,
                    // top: MediaQuery.of(context).padding.top + margin24,
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

              //TABBAR
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
                    SizedBox(
                      width: margin16,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(bottom: margin24 / 2),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: selectedIndex == 2
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent))),
                        child: Text(
                          'Spa & Kecantikan',
                          style: mainBody4.copyWith(
                              fontWeight: FontWeight.bold,
                              color: selectedIndex == 2
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
              // LOKASI
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: margin16,
                ),
                child: GestureDetector(
                  onTap: () async {
                    final result = await showCityPicker<HealthCityModel,
                        HealthCityCubit, HealthCityState>(
                      context,
                      cubit: context.read<HealthCityCubit>(),
                      fetchFunction: (cubit, ctx) => cubit.fetchCities(ctx),
                      isLoading: (state) => state is HealthCityLoading,
                      getCities: (state) =>
                          state is HealthCityLoaded ? state.cities : [],
                      displayName: (city) => city.name,
                    );

                    if (result != null) {
                      setState(() {
                        selectedCity = result;
                        print("DEBUG => Kota terpilih: ${selectedCity?.name}");
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 14, horizontal: margin16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: const Color(0xffa5a5a5)),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_city, color: Colors.grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            selectedCity?.name ?? "Semua Lokasi",
                            style: mainBody5.copyWith(
                              color: selectedCity == null
                                  ? const Color(0xffa5a5a5)
                                  : Colors.black87,
                            ),
                          ),
                        ),
                        const Icon(Icons.keyboard_arrow_down,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: margin16,
              ),
              // TANGGAL
              Container(
                margin: EdgeInsets.symmetric(horizontal: margin16),
                child: GestureDetector(
                  onTap: () async {
                    final selected = await showDialog(
                        context: context,
                        builder: (_) => DateSinglePicker(
                              selectedDate: selectedDate,
                              minDate: DateTime.now(),
                            ));
                    if (selected != null) {
                      setState(() {
                        selectedDate = selected;
                        print("Debug => Tanggal terpilih: $selectedDate");
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 14, horizontal: margin16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xffa5a5a5))),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 18,
                          height: 18,
                          child: Image.asset('assets/new/date_2.png'),
                        ),
                        SizedBox(
                          width: margin16,
                        ),
                        Expanded(
                            child: Text(
                          selectedDate != null
                              ? DateFormat('dd MMM yyyy').format(selectedDate!)
                              : 'Tanggal reservasi',
                          style: mainBody5.copyWith(
                              color: const Color(0xffa5a5a5)),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: margin16,
              ),
              //TOMBOL CARI
              Container(
                  margin: EdgeInsets.symmetric(horizontal: margin16),
                  child: ElevatedButtonWidget(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => HealthSearchResultPage(
                                    isHealth: selectedIndex == 0,
                                    city: selectedCity?.name,
                                  )));
                    },
                    title: 'Cari Sekarang',
                  )),
              SizedBox(
                height: margin16,
              ),
              //SPECIAL DEALS SECTION
              Container(
                padding: EdgeInsets.symmetric(vertical: margin16),
                color: const Color(0xfff8f3f2),
                child: BlocBuilder<HealthCubit, HealthState>(
                    // bloc: selectedIndex == 0 ? healthHomeCubit : beautyHomeCubit,
                    bloc: selectedIndex == 0
                        ? healthHomeCubit
                        : selectedIndex == 1
                            ? beautyHomeCubit
                            : spaHomeCubit,
                    builder: (context, state) {
                      if (state is HealthLoading) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ));
                      } else if (state is HealthHomeLoaded) {
                        return buildSpecialDeals(
                            context, state.specialDeal, selectedIndex);
                        // return Column(
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   children: [
                        //     Container(
                        //       padding: EdgeInsets.symmetric(horizontal: margin16),
                        //       child: Column(
                        //         crossAxisAlignment: CrossAxisAlignment.start,
                        //         children: [
                        //           Row(
                        //             children: [
                        //               SizedBox(
                        //                 width: 24,
                        //                 height: 24,
                        //                 child:
                        //                     Image.asset('assets/new/deals.png'),
                        //               ),
                        //               SizedBox(
                        //                 width: margin8,
                        //               ),
                        //               Expanded(
                        //                   child: Text(
                        //                 'Special Deals',
                        //                 style: mainBody4.copyWith(
                        //                     fontWeight: FontWeight.bold),
                        //               ))
                        //             ],
                        //           ),
                        //           SizedBox(
                        //             height: margin4,
                        //           ),
                        //           Text(
                        //             'Nikmati berbagai pilihan promo menarik dari kami',
                        //             style: mainBody5.copyWith(
                        //                 color: const Color(0xffa5a5a5)),
                        //           )
                        //         ],
                        //       ),
                        //     ),
                        //     SizedBox(
                        //       height: margin16,
                        //     ),
                        //     SingleChildScrollView(
                        //       scrollDirection: Axis.horizontal,
                        //       child: Row(
                        //         children: List.generate(state.specialDeal.length,
                        //             (index) {
                        //           HealthPreviewModel data =
                        //               state.specialDeal[index];
                        //           return GestureDetector(
                        //             onTap: () {
                        //               Navigator.push(
                        //                   context,
                        //                   MaterialPageRoute(
                        //                       builder: (_) => HealthDetailPage(
                        //                           isHealth: selectedIndex == 0,
                        //                           id: data.id.toString())));
                        //             },
                        //             child: Container(
                        //               margin: EdgeInsets.only(left: margin16),
                        //               child: Column(
                        //                 children: [
                        //                   Stack(
                        //                     children: [
                        //                       ClipRRect(
                        //                         borderRadius:
                        //                             const BorderRadius.only(
                        //                                 topLeft:
                        //                                     Radius.circular(8),
                        //                                 topRight:
                        //                                     Radius.circular(8)),
                        //                         child: SizedBox(
                        //                           width: 160,
                        //                           height: 90,
                        //                           child: Image.network(
                        //                             data.image,
                        //                             fit: BoxFit.cover,
                        //                             errorBuilder: (context, error,
                        //                                 stackTrace) {
                        //                               return const Center(
                        //                                 child: Icon(
                        //                                   Icons.broken_image,
                        //                                   size: 50,
                        //                                   color: Colors.grey,
                        //                                 ),
                        //                               );
                        //                             },
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       // Container(
                        //                       //   width: 160,
                        //                       //   height: 90,
                        //                       //   decoration: BoxDecoration(
                        //                       //       borderRadius:
                        //                       //           const BorderRadius.only(
                        //                       //               topLeft:
                        //                       //                   Radius.circular(8),
                        //                       //               topRight:
                        //                       //                   Radius.circular(8)),
                        //                       //       image: DecorationImage(
                        //                       //           image: NetworkImage(
                        //                       //               data.image))),
                        //                       // ),
                        //                       Positioned(
                        //                         left: margin8,
                        //                         bottom: margin8,
                        //                         child: Container(
                        //                           padding: EdgeInsets.symmetric(
                        //                               vertical: margin4,
                        //                               horizontal: margin24 / 2),
                        //                           decoration: BoxDecoration(
                        //                               borderRadius:
                        //                                   BorderRadius.circular(
                        //                                       20),
                        //                               color: const Color(
                        //                                   0xffFFCFCF)),
                        //                           child: Text(
                        //                             'Big Deals',
                        //                             style: mainBody5.copyWith(
                        //                                 color: Theme.of(context)
                        //                                     .primaryColor),
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                   Container(
                        //                     padding: EdgeInsets.all(margin24 / 2),
                        //                     width: 160,
                        //                     decoration: const BoxDecoration(
                        //                         borderRadius: BorderRadius.only(
                        //                             bottomLeft:
                        //                                 Radius.circular(8),
                        //                             bottomRight:
                        //                                 Radius.circular(8)),
                        //                         color: Colors.white),
                        //                     child: Column(
                        //                       crossAxisAlignment:
                        //                           CrossAxisAlignment.start,
                        //                       children: [
                        //                         Row(
                        //                           children: [
                        //                             Expanded(
                        //                                 child: Text(
                        //                               data.location,
                        //                               maxLines: 1,
                        //                               overflow:
                        //                                   TextOverflow.ellipsis,
                        //                               style: mainBody5.copyWith(
                        //                                   color: const Color(
                        //                                       0xffa5a5a5)),
                        //                             )),
                        //                             SizedBox(
                        //                               width: margin4,
                        //                             ),
                        //                             // SizedBox(
                        //                             //   width: 16,
                        //                             //   height: 16,
                        //                             //   child: Image.asset(
                        //                             //       'assets/new/bookmark.png'),
                        //                             // )
                        //                           ],
                        //                         ),
                        //                         SizedBox(
                        //                           height: margin8,
                        //                         ),
                        //                         Text(
                        //                           data.name,
                        //                           maxLines: 1,
                        //                           overflow: TextOverflow.ellipsis,
                        //                           style: mainBody4.copyWith(
                        //                               fontWeight:
                        //                                   FontWeight.bold),
                        //                         ),
                        //                         SizedBox(
                        //                           height: margin4,
                        //                         ),
                        //                         Row(
                        //                           children: [
                        //                             SizedBox(
                        //                               width: 12,
                        //                               height: 12,
                        //                               child: Image.asset(
                        //                                   'assets/new/star.png'),
                        //                             ),
                        //                             SizedBox(
                        //                               width: margin4,
                        //                             ),
                        //                             Text(
                        //                               data.ratingAvg
                        //                                   .toStringAsFixed(1),
                        //                               style: mainBody5.copyWith(
                        //                                   fontWeight:
                        //                                       FontWeight.bold),
                        //                             ),
                        //                             Text(
                        //                               ' (${data.ratingCount} ulasan)',
                        //                               style: mainBody5.copyWith(
                        //                                   color: const Color(
                        //                                       0xffa5a5a5)),
                        //                             ),
                        //                           ],
                        //                         ),
                        //                         SizedBox(
                        //                           height: margin24,
                        //                         ),
                        //                         Text(
                        //                           moneyChanger(data.unitPrice,
                        //                               customLabel: 'IDR '),
                        //                           style: mainBody5.copyWith(
                        //                               color:
                        //                                   const Color(0xffa5a5a5),
                        //                               decorationColor:
                        //                                   const Color(0xffa5a5a5),
                        //                               decoration: TextDecoration
                        //                                   .lineThrough),
                        //                         ),
                        //                         SizedBox(
                        //                           height: margin4,
                        //                         ),
                        //                         Text(
                        //                           moneyChanger(data.price,
                        //                               customLabel: 'IDR '),
                        //                           style: mainBody4.copyWith(
                        //                               fontWeight: FontWeight.bold,
                        //                               color: Theme.of(context)
                        //                                   .primaryColor),
                        //                         )
                        //                       ],
                        //                     ),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           );
                        //         }),
                        //       ),
                        //     )
                        //   ],
                        // );
                      } else if (state is SpaHomeLoaded) {
                        return buildSpecialDeals(
                            context, state.specialDeal, selectedIndex);
                      } else {
                        return Container();
                      }
                    }),
              ),
              //CATEGORY SECTION
              if (selectedIndex != 2) ...[
                Container(
                  padding: EdgeInsets.symmetric(vertical: margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: margin16),
                        child: Text(
                          'Kebutuhan Kesehatan dan Kecantikan',
                          style:
                              mainBody3.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: margin4,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: margin16),
                        child: Text(
                          'Jelajahi kategori-kategori kami untuk kebahagiaan maksimal',
                          style: mainBody4.copyWith(
                              color: const Color(0xffa5a5a5)),
                        ),
                      ),
                      SizedBox(
                        height: margin16,
                      ),
                      BlocBuilder<HealthCubit, HealthState>(
                          bloc: selectedIndex == 0
                              ? healthHomeCubit
                              : beautyHomeCubit,
                          // bloc: selectedIndex == 0
                          //     ? healthHomeCubit
                          //     : selectedIndex == 1
                          //         ? beautyHomeCubit
                          //         : spaHomeCubit,
                          builder: (context, state) {
                            if (state is HealthLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            } else if (state is HealthHomeLoaded) {
                              return buildCategories(state.category);
                            } else if (state is SpaHomeLoaded) {
                              return const SizedBox.shrink();
                            } else {
                              return Container();
                            }
                          })
                    ],
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
              ],
              //DAFTAR KLINIK SECTION
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Daftar Klinik yang Bisa Anda Kunjungi',
                          style: mainBody3.copyWith(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: margin4,
                        ),
                      ],
                    ),
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

                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(
                                  horizontal: margin16, vertical: margin8),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: margin16,
                                crossAxisSpacing: margin16,
                                childAspectRatio: 0.66,
                              ),
                              itemCount: dataFinal.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
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
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Column(
                                      children: [
                                        AspectRatio(
                                          aspectRatio: 167 / 100,
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8)),
                                            child: SizedBox(
                                              width: 160,
                                              height: 90,
                                              child: Image.network(
                                                dataFinal[index].image,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
                                                  return const Center(
                                                    child: Icon(
                                                      Icons.broken_image,
                                                      size: 50,
                                                      color: Colors.grey,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
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
                                                    // SizedBox(
                                                    //   width: 16,
                                                    //   height: 16,
                                                    //   child: Image.asset(
                                                    //       'assets/new/bookmark.png'),
                                                    // )
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
                                );
                              });
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
              SizedBox(
                height: margin32,
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildSpecialDeals(
  BuildContext context,
  List<HealthPreviewModel> deals,
  int selectedIndex,
) {
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
                  style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                ))
              ],
            ),
            SizedBox(
              height: margin4,
            ),
            Text(
              'Nikmati berbagai pilihan promo menarik dari kami',
              style: mainBody5.copyWith(color: const Color(0xffa5a5a5)),
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
          children: List.generate(deals.length, (index) {
            HealthPreviewModel data = deals[index];
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
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8)),
                          child: SizedBox(
                            width: 160,
                            height: 90,
                            child: Image.network(
                              data.image,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 50,
                                    color: Colors.grey,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        // Container(
                        //   width: 160,
                        //   height: 90,
                        //   decoration: BoxDecoration(
                        //       borderRadius:
                        //           const BorderRadius.only(
                        //               topLeft:
                        //                   Radius.circular(8),
                        //               topRight:
                        //                   Radius.circular(8)),
                        //       image: DecorationImage(
                        //           image: NetworkImage(
                        //               data.image))),
                        // ),
                        Positioned(
                          left: margin8,
                          bottom: margin8,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: margin4, horizontal: margin24 / 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color(0xffFFCFCF)),
                            child: Text(
                              'Big Deals',
                              style: mainBody5.copyWith(
                                  color: Theme.of(context).primaryColor),
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
                              bottomRight: Radius.circular(8)),
                          color: Colors.white),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Text(
                                data.location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: mainBody5.copyWith(
                                    color: const Color(0xffa5a5a5)),
                              )),
                              SizedBox(
                                width: margin4,
                              ),
                              // SizedBox(
                              //   width: 16,
                              //   height: 16,
                              //   child: Image.asset(
                              //       'assets/new/bookmark.png'),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: margin8,
                          ),
                          Text(
                            data.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style:
                                mainBody4.copyWith(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: margin4,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 12,
                                height: 12,
                                child: Image.asset('assets/new/star.png'),
                              ),
                              SizedBox(
                                width: margin4,
                              ),
                              Text(
                                data.ratingAvg.toStringAsFixed(1),
                                style: mainBody5.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                ' (${data.ratingCount} ulasan)',
                                style: mainBody5.copyWith(
                                    color: const Color(0xffa5a5a5)),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: margin24,
                          ),
                          Text(
                            moneyChanger(data.unitPrice, customLabel: 'IDR '),
                            style: mainBody5.copyWith(
                                color: const Color(0xffa5a5a5),
                                decorationColor: const Color(0xffa5a5a5),
                                decoration: TextDecoration.lineThrough),
                          ),
                          SizedBox(
                            height: margin4,
                          ),
                          Text(
                            moneyChanger(data.price, customLabel: 'IDR '),
                            style: mainBody4.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor),
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
}

Widget buildCategories(List<HealthCategoryModel> categories) {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: List.generate(categories.length, (index) {
        final category = categories[index];
        return Container(
          width: 140,
          height: 70,
          margin: EdgeInsets.only(
            right: index == categories.length - 1 ? margin16 : 0,
            left: index == 0 ? margin16 : margin8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/new/deals_image.jpg'),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.black38,
            ),
            padding: EdgeInsets.all(margin8),
            alignment: Alignment.bottomLeft,
            child: Text(
              category.name,
              style: mainBody5.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }),
    ),
  );
}
