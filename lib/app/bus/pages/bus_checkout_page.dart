import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/app/bus/viewmodel/bus_checkout_vm.dart';
import 'package:travelsya/app/bus/widgets/bus_route_timeline_widget.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class BusCheckoutPage extends StatelessWidget {
  final BusDataModel goData;
  final BusDataModel? backData;
  const BusCheckoutPage(
      {super.key, required this.goData, required this.backData});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusCheckoutVM>.reactive(viewModelBuilder: () {
      return BusCheckoutVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return StatusbarWidget(
        customBrightness: Brightness.light,
        child: BlocBuilder<BusFilterCubit, BusFilterState>(
            bloc: BlocProvider.of<BusFilterCubit>(context),
            builder: (context, stateFilter) {
              if (stateFilter is BusFilterLoaded) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            left: margin16,
                            right: margin16,
                            bottom: margin16,
                            top: MediaQuery.of(context).padding.top + margin16),
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
                              'Informasi Pemesanan',
                              style: mainBody3.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            padding: EdgeInsets.all(margin16),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: Wrap(
                                    children: [
                                      Text(
                                        '${stateFilter.data.selectedCityOrigin} ke ${stateFilter.data.selectedCityDestination}',
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
                                          stateFilter.data.isWayBack
                                              ? 'Pulang Pergi'
                                              : 'Pergi',
                                          style: mainBody5.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
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
                                        '${stateFilter.data.totalPassanger} Penumpang | ${dateToReadable(DateFormat('yyyy-MM-dd').format(stateFilter.data.selectedDateGo!))}',
                                        style: mainBody4.copyWith(
                                            color: neutral100),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(margin16),
                            color: const Color(0xffFFF6F6),
                            child: Column(
                              children: [
                                BusRouteTimelineCard(
                                    data: goData,
                                    selectedDate:
                                        stateFilter.data.selectedDateGo!,
                                    onTap: () {}),
                                if (backData != null) ...[
                                  SizedBox(
                                    height: margin16,
                                  ),
                                  BusRouteTimelineCard(
                                      data: backData!,
                                      selectedDate:
                                          stateFilter.data.selectedDateBack!,
                                      onTap: () {})
                                ],
                                SizedBox(
                                  height: margin16,
                                ),
                                Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    neutral50.withOpacity(0.3)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        alignment: Alignment.topRight,
                                        child: SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: Image.asset(
                                            'assets/icons/group_23.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(margin16),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Deskripsi',
                                            style: mainBody4.copyWith(
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: margin24 / 2),
                                            width: double.infinity,
                                            height: 1,
                                            color: neutral50.withOpacity(0.3),
                                          ),
                                          Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                            style: mainBody4.copyWith(
                                              color: neutral100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: margin16,
                                ),
                                Stack(
                                  children: [
                                    Positioned(
                                      top: 0,
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        width: double.infinity,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    neutral50.withOpacity(0.3)),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white),
                                        alignment: Alignment.topRight,
                                        child: SizedBox(
                                          width: 45,
                                          height: 45,
                                          child: Image.asset(
                                            'assets/icons/group_23.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(margin16),
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Peraturan',
                                            style: mainBody4.copyWith(
                                                color: neutral100,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: margin24 / 2),
                                            width: double.infinity,
                                            height: 1,
                                            color: neutral50.withOpacity(0.3),
                                          ),
                                          Text(
                                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                                            style: mainBody4.copyWith(
                                              color: neutral100,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(margin16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Detail Pemesan',
                                  style: mainBody3.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: margin16,
                                ),
                                TitleWithWidget(
                                    title: 'Nama Lengkap',
                                    child: RoundedTextfield(
                                        hintText: 'Masukkan nama lengkap Anda',
                                        controller: model.nameController)),
                                SizedBox(
                                  height: margin4,
                                ),
                                Text(
                                  'Seperti di KTP/SIM/Paspor.',
                                  style: mainBody5.copyWith(color: neutral50),
                                ),
                                SizedBox(
                                  height: margin16,
                                ),
                                TitleWithWidget(
                                    title: 'Nomor Handphone',
                                    child: RoundedTextfield(
                                        prefixIcon: Center(
                                          widthFactor: 1,
                                          child: Text(
                                            '+62',
                                            style: mainBody4.copyWith(
                                                color: Colors.black87),
                                          ),
                                        ),
                                        hintText: '812xxxxxx',
                                        controller: model.phoneController)),
                                SizedBox(
                                  height: margin16,
                                ),
                                TitleWithWidget(
                                    title: 'Email',
                                    child: RoundedTextfield(
                                        hintText: 'Masukkan email Anda',
                                        controller: model.emailController)),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: margin32,
                          ),
                        ],
                      )),
                      Container(
                        padding: EdgeInsets.all(margin16),
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: neutral10Stroke))),
                        child: Column(
                          children: [
                            BlocBuilder<PointCubit, PointState>(
                                bloc: BlocProvider.of<PointCubit>(context),
                                builder: (context, statePoint) {
                                  if (statePoint is PointLoaded) {
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Poin Travelsya Anda',
                                              style: mainBody5.copyWith(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              '${moneyChanger(statePoint.data.currentPoint, customLabel: '')} Poin',
                                              style: mainBody5.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: margin4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Poin yang dapat digunakan',
                                              style: mainBody5.copyWith(
                                                  color: Colors.black54),
                                            ),
                                            Text(
                                              '${moneyChanger(statePoint.data.pointAvailable, customLabel: '')} Poin',
                                              style: mainBody5.copyWith(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: margin8,
                                        ),
                                        Container(
                                          margin:
                                              EdgeInsets.only(bottom: margin8),
                                          padding: EdgeInsets.symmetric(
                                              vertical: margin4,
                                              horizontal: margin8),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: Colors.black
                                                  .withOpacity(0.05)),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Tukar ${moneyChanger(statePoint.data.pointAvailable, customLabel: '')} Travelsya Poin',
                                                    style: mainBody4.copyWith(
                                                        color: model.usePoint
                                                            ? Theme.of(context)
                                                                .primaryColor
                                                            : Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              )),
                                              SizedBox(
                                                width: margin8,
                                              ),
                                              CupertinoSwitch(
                                                  value: model.usePoint,
                                                  activeColor: Theme.of(context)
                                                      .primaryColor,
                                                  onChanged: (val) {
                                                    model.onChangePointUsed(
                                                        context);
                                                  })
                                            ],
                                          ),
                                        ),
                                      ],
                                    );
                                  } else if (statePoint is PointLoading) {
                                    return SizedBox(
                                      width: 15,
                                      height: 15,
                                      child: CircularProgressIndicator(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    );
                                  } else {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Gagal Memuat Data Poin',
                                          style: mainBody5.copyWith(
                                              color: Colors.black54),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            BlocProvider.of<PointCubit>(context)
                                                .fetchPoint(context);
                                          },
                                          child: Text(
                                            'Coba Lagi',
                                            style: mainBody5.copyWith(
                                                color: Theme.of(context)
                                                    .primaryColor),
                                          ),
                                        )
                                      ],
                                    );
                                  }
                                }),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Total Tagihan',
                                  style: mainBody5.copyWith(color: neutral100),
                                ),
                                Text(
                                  backData == null
                                      ? model.getTotalInvoice(goData.price *
                                          stateFilter.data.totalPassanger)
                                      : model.getTotalInvoice((goData.price *
                                              stateFilter.data.totalPassanger) +
                                          (backData!.price *
                                              stateFilter.data.totalPassanger)),
                                  style: mainBody4.copyWith(
                                      color: neutral100,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            ElevatedButtonWidget(
                                enabled: true,
                                onTap: () {
                                  model.onSubmit(context,
                                      filter: stateFilter.data,
                                      goData: goData,
                                      backData: backData);
                                },
                                title: 'Lanjutkan ke Pembayaran')
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
              return Container();
            }),
      );
    });
  }
}
