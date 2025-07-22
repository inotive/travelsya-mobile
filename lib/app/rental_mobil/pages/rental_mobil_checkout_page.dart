import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_cubit.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_state.dart';
import 'package:travelsya/app/rental_mobil/models/rental_mobil_model.dart';
import 'package:travelsya/app/rental_mobil/viewmodel/rental_mobil_checkout_vm.dart';
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

class RentalCheckoutPage extends StatelessWidget {
  final RentalMobilModel dataRental;
  final VendorRentalModel dataVendor;
  const RentalCheckoutPage(
      {super.key, required this.dataRental, required this.dataVendor});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RentalMobilCheckoutVM>.reactive(
        viewModelBuilder: () {
      return RentalMobilCheckoutVM();
    }, onViewModelReady: (model) {
      model.onInit(
        context,
      );
    }, builder: (context, model, child) {
      return SafeArea(
        child: BlocBuilder<RentalMobilFilterCubit, RentalMobilFilterState>(
            bloc: BlocProvider.of<RentalMobilFilterCubit>(context),
            builder: (context, state) {
              if (state is RentalMobilFilterLoaded) {
                return Scaffold(
                  backgroundColor: Colors.white,
                  body: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(margin16),
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
                        children: [
                          Container(
                            padding: EdgeInsets.all(margin16),
                            color: neutral10,
                            child: Column(
                              children: [
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
                                            'Detail Mobil dan Vendor',
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
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  RichText(
                                                      text: TextSpan(children: [
                                                    TextSpan(
                                                        text: dataVendor.name,
                                                        style:
                                                            mainBody5.copyWith(
                                                                color:
                                                                    neutral100,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    TextSpan(
                                                        text:
                                                            ' - ${state.data.isWithDriver ? 'Dengan Supir' : 'Lepas Kunci'}',
                                                        style:
                                                            mainBody5.copyWith(
                                                                color:
                                                                    neutral50,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .italic))
                                                  ])),
                                                  Text(
                                                    dataRental.brand,
                                                    style: mainBody5.copyWith(
                                                        color: neutral100),
                                                  ),
                                                  SizedBox(
                                                    height: margin8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: margin16,
                                                          height: margin16,
                                                          child: Image.asset(
                                                              'assets/icons/users.png')),
                                                      SizedBox(
                                                        width: margin4,
                                                      ),
                                                      Text(
                                                        '${dataRental.seats} Orang',
                                                        style:
                                                            mainBody5.copyWith(
                                                                color:
                                                                    neutral50),
                                                      ),
                                                      SizedBox(
                                                        width: margin24 / 2,
                                                      ),
                                                      SizedBox(
                                                          width: margin16,
                                                          height: margin16,
                                                          child: Image.asset(
                                                              'assets/icons/users.png')),
                                                      SizedBox(
                                                        width: margin4,
                                                      ),
                                                      Text(
                                                        dataRental.transmision,
                                                        style:
                                                            mainBody5.copyWith(
                                                                color:
                                                                    neutral50),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: margin24 / 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        moneyChanger(
                                                            dataVendor.price),
                                                        style: mainBody4.copyWith(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        ' /hari',
                                                        style:
                                                            mainBody5.copyWith(
                                                                color:
                                                                    neutral50),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )),
                                              SizedBox(
                                                width: margin24 / 2,
                                              ),
                                              SizedBox(
                                                  width: 45,
                                                  height: 45,
                                                  child: Image.network(
                                                      dataRental.image))
                                            ],
                                          )
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
                                            'Waktu Sewa',
                                            style: mainBody5.copyWith(
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
                                          Row(
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'Tanggal Jemput',
                                                        style:
                                                            mainBody5.copyWith(
                                                                color:
                                                                    neutral50),
                                                      ),
                                                      Text(
                                                        dateToReadable(DateFormat(
                                                                'yyyy-MM-dd')
                                                            .format(state.data
                                                                .selectedDate)),
                                                        style:
                                                            mainBody4.copyWith(
                                                                color:
                                                                    neutral100,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        '${state.data.selectedTime.hour.toString().padLeft(2, '0')}:${state.data.selectedTime.minute.toString().padLeft(2, '0')}',
                                                        style:
                                                            mainBody4.copyWith(
                                                                color:
                                                                    neutral100),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: margin16,
                                              ),
                                              Flexible(
                                                flex: 1,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Tanggal Selesai',
                                                      style: mainBody5.copyWith(
                                                          color: neutral50),
                                                    ),
                                                    Text(
                                                      dateToReadable(DateFormat(
                                                              'yyyy-MM-dd')
                                                          .format(state
                                                              .data.selectedDate
                                                              .add(Duration(
                                                                  days: state
                                                                      .data
                                                                      .duration)))),
                                                      style: mainBody4.copyWith(
                                                          color: neutral100,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      '${state.data.selectedTime.hour.toString().padLeft(2, '0')}:${state.data.selectedTime.minute.toString().padLeft(2, '0')}',
                                                      style: mainBody4.copyWith(
                                                          color: neutral100),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: margin24 / 2),
                                            width: double.infinity,
                                            height: 1,
                                            color: neutral50.withOpacity(0.3),
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Bisa refund, reschedule dan overtime',
                                                style: mainBody5.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )),
                                              SizedBox(
                                                width: margin24 / 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: neutral100,
                                                size: 15,
                                              )
                                            ],
                                          )
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
                                            'Area Sewa',
                                            style: mainBody5.copyWith(
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
                                            'Jakarta',
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
                                          Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                'Lihat Cakupan Area',
                                                style: mainBody5.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Theme.of(context)
                                                        .primaryColor),
                                              )),
                                              SizedBox(
                                                width: margin24 / 2,
                                              ),
                                              Icon(
                                                Icons.arrow_forward_ios_rounded,
                                                color: neutral100,
                                                size: 15,
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
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
                          )
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
                                  model.getTotalInvoice(
                                      dataVendor.price * state.data.duration),
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
                                      duration: state.data.duration,
                                      packageId: dataVendor.idCar,
                                      startDate: state.data.selectedDate,
                                      time: state.data.selectedTime);
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
