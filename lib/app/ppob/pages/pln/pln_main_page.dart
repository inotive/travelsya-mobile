import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/vm/pln_vm.dart';
import 'package:travelsya/app/ppob/widgets/ppob_product_preview_widget.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class PLNMainPage extends StatelessWidget {
  final String preloadNumber;
  final int selectedIndex;
  const PLNMainPage(
      {super.key, this.preloadNumber = '', this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PLNVM>.reactive(viewModelBuilder: () {
      return PLNVM();
    }, onViewModelReady: (model) {
      model.onInit(context, preloadNumber, selectedIndex);
    }, builder: (context, model, child) {
      return Scaffold(
        appBar: appbarWidget(context, title: 'Bayar Listrik'),
        body: BlocBuilder<PPOBCubit, PPOBState>(
            bloc: BlocProvider.of<PPOBCubit>(context),
            builder: (context, state) {
              if (state is PPOBLoading) {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
              } else if (state is PPOBLoaded) {
                if (state.data.pln.isEmpty &&
                    state.data.plnPascaInquiry == null &&
                    state.data.plnPascabayar == null) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: margin32),
                    width: double.infinity,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Image.asset(ConstHelper.logoIcon),
                          ),
                          SizedBox(
                            height: margin16,
                          ),
                          Text(
                            'Saat ini Fitur PLN sedang tidak tersedia, mohon coba lagi nanti',
                            textAlign: TextAlign.center,
                            style: mainBody4,
                          )
                        ]),
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(margin16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                model.onChangeProduct(context);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: margin24 / 2,
                                      horizontal: margin16),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 25,
                                          height: 25,
                                          child: Image.asset(
                                              'assets/icons/Logo_PLN.png')),
                                      SizedBox(
                                        width: margin24 / 2,
                                      ),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Jenis Produk Listrik',
                                              style: mainBody5),
                                          Text(
                                            model.type == PLNType.postpaid
                                                ? 'Tagihan Listrik'
                                                : 'Token Listrik',
                                            style: mainBody4.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )),
                                      SizedBox(width: margin24 / 2),
                                      Text(
                                        'Ubah',
                                        style: mainBody5.copyWith(
                                            color:
                                                Theme.of(context).primaryColor),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            TitleWithWidget(
                              title: 'ID Pelanggan',
                              child: RoundedTextfield(
                                  validation: model.plnValidation,
                                  controller: model.controller,
                                  onChanged: (value) {
                                    model.onPelangganNumberChanged(value);
                                  },
                                  keyboardType: TextInputType.number,
                                  hintText: 'Masukkan ID Pelanggan'),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          Expanded(
                              child: ListView(
                            children: [
                              SizedBox(
                                height: margin24 / 2,
                              ),
                              model.type == PLNType.postpaid
                                  ? Container()
                                  : Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: margin16),
                                      child: Wrap(
                                        alignment: WrapAlignment.spaceBetween,
                                        runSpacing: margin24 / 2,
                                        children: List.generate(
                                            state.data.pln.length, (index) {
                                          return PPOBProductPreviewWidget(
                                            customFractionWidth: 0.48,
                                            title: moneyChanger(
                                                double.parse(
                                                  state.data.pln[index].price,
                                                ),
                                                customLabel: ''),
                                            desc: state
                                                .data.pln[index].description,
                                            onTap: () {
                                              model.onTokenTap(
                                                  state.data.pln[index]);
                                            },
                                            isActive: model
                                                        .selectedTokenVoucher ==
                                                    null
                                                ? false
                                                : model.selectedTokenVoucher!
                                                        .id ==
                                                    state.data.pln[index].id,
                                          );
                                        }),
                                      ),
                                    ),
                              SizedBox(
                                height: margin32,
                              ),
                            ],
                          )),
                        ],
                      )),
                      Container(
                          padding: EdgeInsets.all(margin16),
                          child: FormHelper.elevatedButtonBasic(context,
                              enabled: model.plnValidation == null, onTap: () {
                            model.onSubmit(context);
                          }, title: 'Lanjutkan'))
                    ],
                  );
                }
              } else {
                return FailedRequestWidget(
                  onRetry: () {
                    BlocProvider.of<PPOBCubit>(context).fetchPPOBData(context);
                  },
                );
              }
            }),
      );
    });
  }
}
