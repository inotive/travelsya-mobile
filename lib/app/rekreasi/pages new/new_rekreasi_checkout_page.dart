import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/viewmodel/recreation_checkout_vm.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_checkout_bill_detail_card.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_checkout_detail_card.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_checkout_order_user_card.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_rules_checkout_section.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class CheckoutItem {
  final RecreationPackageModel package;
  final int quantity;

  CheckoutItem({required this.package, required this.quantity});
}

class NewRekreasiCheckoutPage extends StatelessWidget {
  final RecreationDetailModel data;
  final List<CheckoutItem> items;
  const NewRekreasiCheckoutPage(
      {super.key, required this.data, required this.items});

  double get totalHarga =>
      items.fold(0, (sum, e) => sum + (e.package.price * e.quantity));

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
                  ...items.map((item) => RekreasiCheckoutDetailCard(
                        package: item.package,
                        dataDetail: data,
                      )),
                  SizedBox(
                    height: margin32,
                  ),
                  const RekreasiRulesCheckoutSection(),
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: const Color(0xfff4f4f4),
                  ),
                  const RekreasiCheckoutOrderUserCard(),
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: const Color(0xfff4f4f4),
                  ),
                  const RekreasiCheckoutBillDetailCard()
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
                          moneyChanger(totalHarga, customLabel: 'IDR '),
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
                          for (var item in items) {
                            model.onSubmit(
                              context,
                              packageId: item.package.id,
                              // quantity: item.quantity,
                            );
                          }
                        },
                        title: 'Lanjutkan ke Pembayaran Baru')
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
