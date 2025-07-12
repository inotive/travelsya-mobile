import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/app/bus/viewmodel/bus_checkout_vm.dart';
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
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(margin16),
                            color: const Color(0xffFFF6F6),
                            child: Column(
                              children: List.generate(
                                  stateFilter.data.isWayBack ? 2 : 1, (index) {
                                BusDataModel data =
                                    index == 0 ? goData : backData!;

                                return Container(
                                  margin: EdgeInsets.only(
                                      top: index == 0 ? 0 : margin24 / 2),
                                  padding: EdgeInsets.all(margin16),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          color: neutral50.withOpacity(0.3))),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data.bussinessName,
                                                style: mainBody4.copyWith(
                                                    color: neutral100,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                data.kelas,
                                                style: mainBody5.copyWith(
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
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                '${data.availableTicket} kursi tersedia',
                                                style: mainBody5.copyWith(
                                                    color: Colors.green),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    moneyChanger(data.price,
                                                        customLabel: 'IDR '),
                                                    style: mainBody4.copyWith(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    ' /pax',
                                                    style: mainBody5.copyWith(
                                                        color: neutral50),
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
                                              CrossAxisAlignment.start,
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
                                                            maxWidth: 64),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data.departureTime,
                                                          style: mainBody3
                                                              .copyWith(
                                                                  color:
                                                                      neutral100,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text(
                                                          "${getDay(DateFormat('yyyy-MM-dd').format(index == 0 ? stateFilter.data.selectedDateGo! : stateFilter.data.selectedDateBack!))} ${dateToReadable(DateFormat('yyyy-MM-dd').format(index == 0 ? stateFilter.data.selectedDateGo! : stateFilter.data.selectedDateBack!))}",
                                                          style: mainBody4
                                                              .copyWith(
                                                                  color:
                                                                      neutral100),
                                                        ),
                                                        SizedBox(
                                                          height: margin32,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                margin8),
                                                    height: double.infinity,
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: margin8,
                                                          height: margin8,
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Theme.of(
                                                                      context)
                                                                  .primaryColor),
                                                        ),
                                                        Expanded(
                                                            child: Container(
                                                          width: 1,
                                                          height:
                                                              double.infinity,
                                                          color:
                                                              Theme.of(context)
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
                                                        style:
                                                            mainBody4.copyWith(
                                                          color: neutral100,
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 64),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          data.arrivalTime,
                                                          style: mainBody3
                                                              .copyWith(
                                                                  color:
                                                                      neutral100,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                        Text(
                                                          "${getDay(DateFormat('yyyy-MM-dd').format(index == 0 ? stateFilter.data.selectedDateGo! : stateFilter.data.selectedDateBack!))} ${dateToReadable(DateFormat('yyyy-MM-dd').format(index == 0 ? stateFilter.data.selectedDateGo! : stateFilter.data.selectedDateBack!))}",
                                                          style: mainBody4
                                                              .copyWith(
                                                                  color:
                                                                      neutral100),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10),
                                                    child: Container(
                                                      width: margin8,
                                                      height: margin8,
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryColor),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      data.arrivalPoint,
                                                      style: mainBody4.copyWith(
                                                        color: neutral100,
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
                                );
                              }),
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
