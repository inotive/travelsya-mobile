import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/pages/bus_detail_page.dart';
import 'package:travelsya/app/bus/viewmodel/bus_search_vm.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class BusSearchPage extends StatelessWidget {
  const BusSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusSearchVM>.reactive(viewModelBuilder: () {
      return BusSearchVM();
    }, onViewModelReady: (model) {
      BlocProvider.of<BusFilterCubit>(context).onResetData();
    }, builder: (context, model, child) {
      return Scaffold(
          body: BlocBuilder<BusFilterCubit, BusFilterState>(
              bloc: BlocProvider.of<BusFilterCubit>(context),
              builder: (context, state) {
                if (state is BusFilterLoaded) {
                  return ListView(
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
                                    image: AssetImage(
                                        'assets/images/edvin-johansson-rlwE8f8anOc-unsplash 1 (2).png'))),
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
                                        shape: BoxShape.circle,
                                        color: Colors.white),
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
                                  'Bus & Travel',
                                  style: mainBody3.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<BusFilterCubit>(context)
                                    .onPickCity(context);
                              },
                              child: FormHelper.dropdownForm(context,
                                  data: state.data.selectedCityOrigin,
                                  hintText: 'Kota Asal'),
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            Text(
                              'Stasiun Asal',
                              style: mainBody5.copyWith(color: neutral50),
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<BusFilterCubit>(context)
                                    .onPickCity(context, isOrigin: false);
                              },
                              child: FormHelper.dropdownForm(context,
                                  data: state.data.selectedCityDestination,
                                  hintText: 'Kota Tujuan'),
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            Text(
                              'Stasiun Tujuan',
                              style: mainBody5.copyWith(color: neutral50),
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<BusFilterCubit>(context)
                                    .onPickDate(
                                  context,
                                );
                              },
                              child: FormHelper.dropdownForm(context,
                                  customIcons: Icons.date_range,
                                  data: dateToReadable(DateFormat('yyyy-MM-dd')
                                      .format(state.data.selectedDateGo!)),
                                  hintText: 'Tanggal Keberangkatan'),
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            Text(
                              'Tanggal Keberangkatan',
                              style: mainBody5.copyWith(color: neutral50),
                            ),
                            state.data.isWayBack
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: margin24 / 2,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<BusFilterCubit>(
                                                  context)
                                              .onPickDate(context,
                                                  isStartDate: false);
                                        },
                                        child: FormHelper.dropdownForm(context,
                                            customIcons: Icons.date_range,
                                            data: state.data.selectedDateBack ==
                                                    null
                                                ? null
                                                : dateToReadable(DateFormat(
                                                        'yyyy-MM-dd')
                                                    .format(state.data
                                                        .selectedDateBack!)),
                                            hintText: 'Tanggal Kepulangan'),
                                      ),
                                      SizedBox(
                                        height: margin8,
                                      ),
                                      Text(
                                        'Tanggal Kepulangan',
                                        style: mainBody5.copyWith(
                                            color: neutral50),
                                      ),
                                    ],
                                  )
                                : Container(),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<BusFilterCubit>(
                                                  context)
                                              .onPickPassanger(context);
                                        },
                                        child: FormHelper.dropdownForm(context,
                                            data:
                                                '${state.data.totalPassanger} Penumpang',
                                            hintText: 'Jumlah Penumpang'),
                                      ),
                                      SizedBox(
                                        height: margin8,
                                      ),
                                      Text(
                                        'Jumlah Penumpang',
                                        style: mainBody5.copyWith(
                                            color: neutral50),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: margin24 / 2,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: Checkbox(
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            value: state.data.isWayBack,
                                            onChanged: (value) {
                                              BlocProvider.of<BusFilterCubit>(
                                                      context)
                                                  .onChangeWaybackStatus(
                                                      value!);
                                            })),
                                    SizedBox(
                                      width: margin4,
                                    ),
                                    Text(
                                      'Pulang pergi?',
                                      style:
                                          mainBody4.copyWith(color: neutral100),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: margin16,
                            ),
                            ElevatedButtonWidget(
                                enabled: true,
                                onTap: () {
                                  BlocProvider.of<BusFilterCubit>(context)
                                      .onSearch(context, onSuccess: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                const BusDetailPage()));
                                  });
                                },
                                title: 'Cari Tiket')
                          ],
                        ),
                      ),
                      SizedBox(
                        height: margin32,
                      )
                    ],
                  );
                }

                return Container();
              }));
    });
  }
}
