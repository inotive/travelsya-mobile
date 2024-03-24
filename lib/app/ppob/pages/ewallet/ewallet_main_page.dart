import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/vm/ewallet_vm.dart';
import 'package:travelsya/app/ppob/widgets/ppob_product_preview_widget.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class EwalletMainPage extends StatelessWidget {
  final String preloadNumber;
  const EwalletMainPage({Key? key, this.preloadNumber = ''}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EwalletVM>.reactive(viewModelBuilder: () {
      return EwalletVM();
    }, onViewModelReady: (model) {
      model.onInit(preloadNumber);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appbarWidget(context, title: 'E-Wallet'),
              body: BlocBuilder<PPOBCubit, PPOBState>(
                  bloc: BlocProvider.of<PPOBCubit>(context),
                  builder: (context, state) {
                    if (state is PPOBLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor),
                      );
                    } else if (state is PPOBLoaded) {
                      if (state.data.ewallet.isEmpty) {
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
                                  'Saat ini Fitur E-Wallet sedang tidak tersedia, mohon coba lagi nanti',
                                  textAlign: TextAlign.center,
                                  style: mainBody4,
                                )
                              ]),
                        );
                      } else {
                        return Column(
                          children: [
                            SizedBox(
                              height: margin16,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: margin16),
                              child: GestureDetector(
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
                                          child: Image.asset(
                                              ConstHelper.ewalletIcon),
                                        ),
                                        SizedBox(
                                          width: margin8,
                                        ),
                                        Expanded(
                                            child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'E-Wallet',
                                              style: mainBody5,
                                            ),
                                            Text(
                                              model.selectedEwallet == null
                                                  ? 'Mohon memilih Penyedia E-Wallet'
                                                  : model.selectedEwallet!
                                                      .operator,
                                              style:
                                                  model.selectedEwallet == null
                                                      ? mainBody5.copyWith(
                                                          color: Colors.orange,
                                                          fontStyle:
                                                              FontStyle.italic)
                                                      : mainBody4.copyWith(
                                                          color: Colors.black87,
                                                          fontWeight:
                                                              FontWeight.bold),
                                            ),
                                          ],
                                        )),
                                        SizedBox(
                                          width: margin24 / 2,
                                        ),
                                        Text(
                                          'Ubah',
                                          style: mainBody5.copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: margin16),
                              child: TitleWithWidget(
                                title: 'Nomor E-Wallet',
                                child: RoundedTextfield(
                                    keyboardType: TextInputType.number,
                                    controller: model.controller,
                                    hintText: 'Masukkan Nomor E-Wallet'),
                              ),
                            ),
                            model.selectedEwallet == null
                                ? Expanded(child: Container())
                                : Expanded(
                                    child: Column(
                                    children: [
                                      SizedBox(
                                        height: margin16,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        height: 4,
                                        color: Colors.black12,
                                      ),
                                      model
                                              .getDataEWalletByOperator(
                                                  state.data.ewallet)
                                              .isEmpty
                                          ? Expanded(
                                              child: Center(
                                                child: Text(
                                                  'Data Tidak Ditemukan',
                                                  style: mainBody4.copyWith(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: neutral70),
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              child: ListView(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: margin16),
                                                children: [
                                                  SizedBox(
                                                    height: margin16,
                                                  ),
                                                  Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Wrap(
                                                          alignment:
                                                              WrapAlignment
                                                                  .spaceBetween,
                                                          runSpacing:
                                                              margin24 / 2,
                                                          children: List.generate(
                                                              model
                                                                  .getDataEWalletByOperator(
                                                                      state.data
                                                                          .ewallet)
                                                                  .length,
                                                              (index) {
                                                            return PPOBProductPreviewWidget(
                                                              customFractionWidth:
                                                                  0.48,
                                                              desc: model
                                                                  .getDataEWalletByOperator(
                                                                      state.data
                                                                          .ewallet)[
                                                                      index]
                                                                  .description,
                                                              isActive: model.isSelectedProduct(
                                                                  model.getDataEWalletByOperator(state
                                                                          .data
                                                                          .ewallet)[
                                                                      index]),
                                                              title: moneyChanger(
                                                                  double.parse(model
                                                                      .getDataEWalletByOperator(
                                                                          state
                                                                              .data
                                                                              .ewallet)[
                                                                          index]
                                                                      .price),
                                                                  customLabel:
                                                                      ''),
                                                              onTap: () {
                                                                model.onSelectProduct(
                                                                    model.getDataEWalletByOperator(state
                                                                            .data
                                                                            .ewallet)[
                                                                        index]);
                                                              },
                                                            );
                                                          }),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                    ],
                                  )),
                            Container(
                              padding: EdgeInsets.all(margin16),
                              child: Column(
                                children: [
                                  FormHelper.elevatedButtonBasic(context,
                                      enabled: model.selectedData != null,
                                      onTap: () {
                                    model.doTopup(context);
                                  }, title: 'Topup'),
                                ],
                              ),
                            )
                          ],
                        );
                      }
                    } else {
                      return FailedRequestWidget(
                        onRetry: () {
                          BlocProvider.of<PPOBCubit>(context)
                              .fetchPPOBData(context);
                        },
                      );
                    }
                  })));
    });
  }
}
