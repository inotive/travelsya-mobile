import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/bus/cubits/bus_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/cubits/bus_state.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/app/bus/viewmodel/bus_detail_vm.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/no_data_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class BusDetailPage extends StatelessWidget {
  const BusDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusDetailVM>.reactive(viewModelBuilder: () {
      return BusDetailVM();
    }, onViewModelReady: (model) {
      model.busSearchCubit.searchRentalMobil(context);
    }, builder: (context, model, child) {
      return BlocBuilder<BusFilterCubit, BusFilterState>(
          bloc: BlocProvider.of<BusFilterCubit>(context),
          builder: (context, stateFilter) {
            if (stateFilter is BusFilterLoaded) {
              return StatusbarWidget(
                  customBrightness: Brightness.light,
                  child: Scaffold(
                    backgroundColor: const Color(0xfff5f5f5),
                    body: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: margin16,
                              right: margin16,
                              top:
                                  margin16 + MediaQuery.of(context).padding.top,
                              bottom: margin16),
                          color: Theme.of(context).primaryColor,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: margin24 / 2,
                              ),
                              Text(
                                'Cari Tiket',
                                style: mainBody3.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(margin16),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border(
                                  bottom: BorderSide(
                                      color: neutral50.withOpacity(0.3)))),
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Wrap(
                                  children: [
                                    Text(
                                      model.goData == null
                                          ? '${stateFilter.data.selectedCityOrigin} ke ${stateFilter.data.selectedCityDestination}'
                                          : '${stateFilter.data.selectedCityDestination} ke ${stateFilter.data.selectedCityOrigin}',
                                      style: mainBody3.copyWith(
                                          color: neutral100,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: margin4,
                                          horizontal: margin24 / 2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.3)),
                                      child: Text(
                                        model.goData == null
                                            ? 'Pergi'
                                            : 'Pulang',
                                        style: mainBody5.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: margin24 / 2,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: margin8, horizontal: margin16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: neutral10),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        width: 16,
                                        height: 16,
                                        child: Image.asset(
                                            'assets/icons/users.png')),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    Expanded(
                                        child: Text(
                                      '${stateFilter.data.totalPassanger} Penumpang | ${model.goData == null ? dateToReadable(DateFormat('yyyy-MM-dd').format(stateFilter.data.selectedDateGo!)) : dateToReadable(DateFormat('yyyy-MM-dd').format(stateFilter.data.selectedDateBack!))}',
                                      style:
                                          mainBody4.copyWith(color: neutral100),
                                    )),
                                    SizedBox(
                                      width: margin8,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (model.goData == null) {
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        'Ubah',
                                        style: mainBody4.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        // Container(
                        //     padding: EdgeInsets.all(margin16),
                        //     child: Row(
                        //       children: [
                        //         Flexible(
                        //           flex: 1,
                        //           child: SizedBox(
                        //             width: double.infinity,
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   'Boarding Point',
                        //                   style: mainBody4.copyWith(color: neutral50),
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       'Semua Jakarta',
                        //                       style:
                        //                           mainBody4.copyWith(color: neutral100),
                        //                     ),
                        //                     Icon(
                        //                       Icons.keyboard_arrow_down_rounded,
                        //                       size: margin16,
                        //                       color: neutral50,
                        //                     )
                        //                   ],
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         ),
                        //         SizedBox(
                        //           width: margin16,
                        //         ),
                        //         Flexible(
                        //           flex: 1,
                        //           child: SizedBox(
                        //             width: double.infinity,
                        //             child: Column(
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Text(
                        //                   'Arrival Point',
                        //                   style: mainBody4.copyWith(color: neutral50),
                        //                 ),
                        //                 Row(
                        //                   mainAxisAlignment:
                        //                       MainAxisAlignment.spaceBetween,
                        //                   children: [
                        //                     Text(
                        //                       'Semua Surabaya',
                        //                       style:
                        //                           mainBody4.copyWith(color: neutral100),
                        //                     ),
                        //                     Icon(
                        //                       Icons.keyboard_arrow_down_rounded,
                        //                       size: margin16,
                        //                       color: neutral50,
                        //                     )
                        //                   ],
                        //                 )
                        //               ],
                        //             ),
                        //           ),
                        //         )
                        //       ],
                        //     )),
                        Expanded(
                            child: BlocBuilder<BusCubit, BusState>(
                                bloc: model.busSearchCubit,
                                builder: (context, state) {
                                  if (state is BusLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    );
                                  } else if (state is BusSearchLoaded) {
                                    if (state.dataGo.isEmpty) {
                                      return const NoDataWidget();
                                    }

                                    return Container(
                                      color: Colors.white,
                                      child: ListView(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: margin16),
                                        children: List.generate(
                                            model.goData == null
                                                ? state.dataGo.length
                                                : state.dataBack.length,
                                            (index) {
                                          BusDataModel data =
                                              model.goData == null
                                                  ? state.dataGo[index]
                                                  : state.dataBack[index];

                                          return GestureDetector(
                                            onTap: () {
                                              model.onTapDetail(context, data);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(
                                                  top: index == 0
                                                      ? margin16
                                                      : margin24 / 2),
                                              padding: EdgeInsets.all(margin16),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: neutral50
                                                          .withOpacity(0.3))),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data.bussinessName,
                                                            style: mainBody4.copyWith(
                                                                color:
                                                                    neutral100,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          Text(
                                                            data.kelas,
                                                            style: mainBody5
                                                                .copyWith(
                                                              color: neutral50,
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                      SizedBox(
                                                        width: margin24 / 2,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            '${data.availableTicket} kursi tersedia',
                                                            style: mainBody5
                                                                .copyWith(
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                          Row(
                                                            children: [
                                                              Text(
                                                                moneyChanger(
                                                                    data.price,
                                                                    customLabel:
                                                                        'IDR '),
                                                                style: mainBody3.copyWith(
                                                                    color: Theme.of(
                                                                            context)
                                                                        .primaryColor,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                              Text(
                                                                ' /pax',
                                                                style: mainBody5
                                                                    .copyWith(
                                                                        color:
                                                                            neutral50),
                                                              )
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: margin24 / 2,
                                                  ),
                                                  SizedBox(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: margin8,
                                                        ),
                                                        IntrinsicHeight(
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                        maxWidth:
                                                                            64),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      data.departureTime,
                                                                      style: mainBody3.copyWith(
                                                                          color:
                                                                              neutral100,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      '${getDay(DateFormat('yyyy-MM-dd').format(model.goData != null ? stateFilter.data.selectedDateBack! : stateFilter.data.selectedDateGo!))}, ${dateToReadable(DateFormat('yyyy-MM-dd').format(model.goData != null ? stateFilter.data.selectedDateBack! : stateFilter.data.selectedDateGo!))}',
                                                                      style: mainBody4.copyWith(
                                                                          color:
                                                                              neutral100),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          margin32,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: EdgeInsets
                                                                    .symmetric(
                                                                        horizontal:
                                                                            margin8),
                                                                height: double
                                                                    .infinity,
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      width:
                                                                          margin8,
                                                                      height:
                                                                          margin8,
                                                                      decoration: BoxDecoration(
                                                                          shape: BoxShape
                                                                              .circle,
                                                                          color:
                                                                              Theme.of(context).primaryColor),
                                                                    ),
                                                                    Expanded(
                                                                        child:
                                                                            Container(
                                                                      width: 1,
                                                                      height: double
                                                                          .infinity,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ))
                                                                  ],
                                                                ),
                                                              ),
                                                              Expanded(
                                                                  child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    data.departurePoint,
                                                                    style: mainBody4
                                                                        .copyWith(
                                                                      color:
                                                                          neutral100,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ))
                                                            ],
                                                          ),
                                                        ),
                                                        IntrinsicHeight(
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                constraints:
                                                                    const BoxConstraints(
                                                                        maxWidth:
                                                                            64),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      data.arrivalTime,
                                                                      style: mainBody3.copyWith(
                                                                          color:
                                                                              neutral100,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      '${getDay(DateFormat('yyyy-MM-dd').format(model.goData != null ? stateFilter.data.selectedDateBack! : stateFilter.data.selectedDateGo!))}, ${dateToReadable(DateFormat('yyyy-MM-dd').format(model.goData != null ? stateFilter.data.selectedDateBack! : stateFilter.data.selectedDateGo!))}',
                                                                      style: mainBody4.copyWith(
                                                                          color:
                                                                              neutral100),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                margin: const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        10),
                                                                child:
                                                                    Container(
                                                                  width:
                                                                      margin8,
                                                                  height:
                                                                      margin8,
                                                                  decoration: BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  data.arrivalPoint,
                                                                  style: mainBody4
                                                                      .copyWith(
                                                                    color:
                                                                        neutral100,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                                    );
                                  } else {
                                    return Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: margin16),
                                      child: FailedRequestWidget(onRetry: () {
                                        model.busSearchCubit
                                            .searchRentalMobil(context);
                                      }),
                                    );
                                  }
                                })),
                      ],
                    ),
                  ));
            }

            return Container();
          });
    });
  }
}
