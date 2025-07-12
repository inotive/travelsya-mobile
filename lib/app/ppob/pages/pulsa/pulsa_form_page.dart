import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/vm/pulsa_vm.dart';
import 'package:travelsya/app/ppob/widgets/ppob_product_preview_widget.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';

class PulsaFormPage extends StatelessWidget {
  final String preloadNumber;
  const PulsaFormPage({super.key, this.preloadNumber = ''});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PulsaVM>.reactive(viewModelBuilder: () {
      return PulsaVM();
    }, onViewModelReady: (model) {
      model.onInit(preloadNumber);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
              appBar: appbarWidget(context, title: 'Pulsa & Paket Data'),
              backgroundColor: Colors.white,
              body: Column(children: [
                Container(
                  padding: EdgeInsets.only(
                      left: margin16,
                      right: margin16,
                      top: margin16,
                      bottom: margin8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nomor Handphone',
                            style: mainBody4.copyWith(color: Colors.black87),
                          ),
                          Text(
                            model.selectedProvider ?? '',
                            style: mainBody4.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      SizedBox(
                        height: margin8,
                      ),
                      RoundedTextfield(
                          controller: model.controller,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            model.operatorCheck(value);
                          },
                          hintText: 'Masukkan Nomor Handphone'),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            model.onIndexChanged(0);
                          },
                          child: FormHelper.tabbarData(context,
                              title: 'Pulsa',
                              index: 0,
                              customSize: 14,
                              customMargin:
                                  EdgeInsets.symmetric(vertical: margin24 / 2),
                              currentIndex: model.selectedIndex),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            model.onIndexChanged(1);
                          },
                          child: FormHelper.tabbarData(context,
                              title: 'Data',
                              index: 1,
                              customSize: 14,
                              customMargin:
                                  EdgeInsets.symmetric(vertical: margin24 / 2),
                              currentIndex: model.selectedIndex),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: BlocBuilder<PPOBCubit, PPOBState>(
                        bloc: BlocProvider.of<PPOBCubit>(context),
                        builder: (context, state) {
                          if (state is PPOBLoaded) {
                            return model
                                    .getListDataByOperator(state.data)
                                    .isEmpty
                                ? const Center(
                                    child: Text('Data Tidak Tersedia'),
                                  )
                                : ListView(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: margin16),
                                    children: [
                                      SizedBox(
                                        height: margin16,
                                      ),
                                      Text(
                                        'Pilih Nominal',
                                        style: mainBody4.copyWith(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: margin24 / 2,
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: Wrap(
                                          alignment: WrapAlignment.spaceBetween,
                                          runSpacing: margin24 / 2,
                                          children: List.generate(
                                              model
                                                  .getListDataByOperator(
                                                      state.data)
                                                  .length, (index) {
                                            return PPOBProductPreviewWidget(
                                                isActive: model.selectedData == null
                                                    ? false
                                                    : model.selectedData!.id ==
                                                        model
                                                            .getListDataByOperator(state
                                                                .data)[index]
                                                            .id,
                                                customFractionWidth:
                                                    model.selectedIndex == 0
                                                        ? 0.48
                                                        : 1,
                                                title: moneyChanger(
                                                    double.parse(model
                                                        .getListDataByOperator(
                                                            state.data)[index]
                                                        .price),
                                                    customLabel: ''),
                                                desc: model
                                                    .getListDataByOperator(state.data)[index]
                                                    .description,
                                                onTap: () {
                                                  model.onDataTap(model
                                                      .getListDataByOperator(
                                                          state.data)[index]);
                                                });
                                          }),
                                        ),
                                      ),
                                      SizedBox(
                                        height: margin16,
                                      ),
                                    ],
                                  );
                          }

                          return Container();
                        })),
                Container(
                  padding: EdgeInsets.all(margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButtonWidget(
                          enabled: model.selectedData != null,
                          onTap: () {
                            model.onSubmit(context);
                          },
                          title: 'Bayar Sekarang')
                    ],
                  ),
                )
              ])));
    });
  }
}
