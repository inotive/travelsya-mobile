import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/vm/pdam_vm.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class PDAMMainPage extends StatelessWidget {
  final String preloadNumber;
  const PDAMMainPage({super.key, this.preloadNumber = ''});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PDAMVM>.reactive(viewModelBuilder: () {
      return PDAMVM();
    }, onViewModelReady: (model) {
      model.onInit(preloadNumber);
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appbarWidget(context, title: 'PDAM'),
              body: BlocBuilder<PPOBCubit, PPOBState>(
                  bloc: BlocProvider.of<PPOBCubit>(context),
                  builder: (context, state) {
                    if (state is PPOBLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor),
                      );
                    } else if (state is PPOBLoaded) {
                      if (state.data.pdam.isEmpty) {
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
                                  'Saat ini pembayaran PDAM sedang tidak tersedia, mohon coba lagi nanti',
                                  textAlign: TextAlign.center,
                                  style: mainBody4,
                                )
                              ]),
                        );
                      } else {
                        return ListView(
                          padding: EdgeInsets.all(margin16),
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
                                        child:
                                            Image.asset(ConstHelper.pdamIcon),
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
                                            'Penyedia PDAM',
                                            style: mainBody4,
                                          ),
                                          Text(
                                            model.selectedPDAM == null
                                                ? 'Mohon memilih Penyedia PDAM'
                                                : model
                                                    .selectedPDAM!.description,
                                            style: model.selectedPDAM == null
                                                ? mainBody5.copyWith(
                                                    color: Colors.orange,
                                                    fontStyle: FontStyle.italic)
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
                              title: 'Nomor Pelanggan',
                              child: RoundedTextfield(
                                  controller: model.controller,
                                  hintText: 'Masukkan Nomor Pelanggan'),
                            ),
                            SizedBox(
                              height: margin32,
                            ),
                            ElevatedButtonWidget(
                                enabled: model.selectedPDAM != null,
                                onTap: () {
                                  model.onSubmit(context);
                                },
                                title: 'Cek Tagihan')
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
