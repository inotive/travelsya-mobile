import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/viewmodel/recreation_checkout_vm.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class RekreasiCheckoutPage extends StatelessWidget {
  final RecreationDetailModel data;
  final RecreationPackageModel package;
  const RekreasiCheckoutPage(
      {super.key, required this.data, required this.package});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecreationCheckoutVM>.reactive(
        viewModelBuilder: () {
      return RecreationCheckoutVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
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
                          color: Colors.white, fontWeight: FontWeight.w700),
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
                                        color: neutral50.withOpacity(0.3)),
                                    borderRadius: BorderRadius.circular(10),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Detail Paket',
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
                                    data.name,
                                    style: mainBody4,
                                  ),
                                  Text(
                                    package.name,
                                    style: mainBody5.copyWith(
                                        color: Theme.of(context).primaryColor),
                                  ),
                                  SizedBox(
                                    height: margin4,
                                  ),
                                  Text(
                                    moneyChanger(package.price,
                                        customLabel: 'IDR '),
                                    style: mainBody4.copyWith(
                                        fontWeight: FontWeight.bold),
                                  )
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //         child: Column(
                                  //       crossAxisAlignment:
                                  //           CrossAxisAlignment.start,
                                  //       children: [
                                  //         RichText(
                                  //             text: TextSpan(children: [
                                  //           TextSpan(
                                  //               text: dataVendor.name,
                                  //               style: mainBody5.copyWith(
                                  //                   color: neutral100,
                                  //                   fontWeight:
                                  //                       FontWeight.bold)),
                                  //           TextSpan(
                                  //               text:
                                  //                   ' - ${state.data.isWithDriver ? 'Dengan Supir' : 'Lepas Kunci'}',
                                  //               style: mainBody5.copyWith(
                                  //                   color: neutral50,
                                  //                   fontStyle:
                                  //                       FontStyle.italic))
                                  //         ])),
                                  //         Text(
                                  //           dataRental.brand,
                                  //           style: mainBody5.copyWith(
                                  //               color: neutral100),
                                  //         ),
                                  //         SizedBox(
                                  //           height: margin8,
                                  //         ),
                                  //         Row(
                                  //           children: [
                                  //             SizedBox(
                                  //                 width: margin16,
                                  //                 height: margin16,
                                  //                 child: Image.asset(
                                  //                     'assets/icons/users.png')),
                                  //             SizedBox(
                                  //               width: margin4,
                                  //             ),
                                  //             Text(
                                  //               '${dataRental.seats} Orang',
                                  //               style: mainBody5.copyWith(
                                  //                   color: neutral50),
                                  //             ),
                                  //             SizedBox(
                                  //               width: margin24 / 2,
                                  //             ),
                                  //             SizedBox(
                                  //                 width: margin16,
                                  //                 height: margin16,
                                  //                 child: Image.asset(
                                  //                     'assets/icons/users.png')),
                                  //             SizedBox(
                                  //               width: margin4,
                                  //             ),
                                  //             Text(
                                  //               dataRental.transmision,
                                  //               style: mainBody5.copyWith(
                                  //                   color: neutral50),
                                  //             )
                                  //           ],
                                  //         ),
                                  //         SizedBox(
                                  //           height: margin24 / 2,
                                  //         ),
                                  //         Row(
                                  //           children: [
                                  //             Text(
                                  //               moneyChanger(
                                  //                   dataVendor.price),
                                  //               style: mainBody4.copyWith(
                                  //                   color: Theme.of(context)
                                  //                       .primaryColor,
                                  //                   fontWeight:
                                  //                       FontWeight.bold),
                                  //             ),
                                  //             Text(
                                  //               ' /hari',
                                  //               style: mainBody5.copyWith(
                                  //                   color: neutral50),
                                  //             )
                                  //           ],
                                  //         )
                                  //       ],
                                  //     )),
                                  //     SizedBox(
                                  //       width: margin24 / 2,
                                  //     ),
                                  //     SizedBox(
                                  //         width: 45,
                                  //         height: 45,
                                  //         child: Image.network(
                                  //             dataRental.image))
                                  //   ],
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
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
                    border: Border(top: BorderSide(color: neutral10Stroke))),
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
                                          color:
                                              Theme.of(context).primaryColor),
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
                                          color:
                                              Theme.of(context).primaryColor),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: margin8,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: margin8),
                                  padding: EdgeInsets.symmetric(
                                      vertical: margin4, horizontal: margin8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.black.withOpacity(0.05)),
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                      SizedBox(
                                        width: margin8,
                                      ),
                                      CupertinoSwitch(
                                          value: model.usePoint,
                                          activeColor:
                                              Theme.of(context).primaryColor,
                                          onChanged: (val) {
                                            // model.onChangePointUsed(
                                            //     context);
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gagal Memuat Data Poin',
                                  style:
                                      mainBody5.copyWith(color: Colors.black54),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<PointCubit>(context)
                                        .fetchPoint(context);
                                  },
                                  child: Text(
                                    'Coba Lagi',
                                    style: mainBody5.copyWith(
                                        color: Theme.of(context).primaryColor),
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
                          moneyChanger(package.price, customLabel: 'IDR '),
                          style: mainBody4.copyWith(
                              color: neutral100, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    SizedBox(
                      height: margin24 / 2,
                    ),
                    ElevatedButtonWidget(
                        enabled: true,
                        onTap: () {
                          model.onSubmit(
                            context,
                            packageId: package.id,
                          );
                        },
                        title: 'Lanjutkan ke Pembayaran')
                  ],
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
