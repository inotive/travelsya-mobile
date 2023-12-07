import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/vm/tv_berbayar_vm.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';

class TVBerbayarMainPage extends StatelessWidget {
  final String preloadNumber;
  const TVBerbayarMainPage({Key? key, this.preloadNumber = ''})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TVBerbayarVM>.reactive(viewModelBuilder: () {
      return TVBerbayarVM();
    }, onViewModelReady: (model) {
      model.onInit(preloadNumber);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: appbarWidget(context, title: 'TV Berbayar'),
              body: BlocBuilder<PPOBCubit, PPOBState>(
                  bloc: BlocProvider.of<PPOBCubit>(context),
                  builder: (context, state) {
                    if (state is PPOBLoading) {
                      return Center(
                        child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor),
                      );
                    } else if (state is PPOBLoaded) {
                      if (state.data.tvInternet.isEmpty) {
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
                                  'Saat ini pembayaran TV berbayar sedang tidak tersedia, mohon coba lagi nanti',
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
                                        child: Image.asset(ConstHelper.tvIcon),
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
                                            'Penyedia TV Berbayar',
                                            style: mainBody4,
                                          ),
                                          Text(
                                            model.selectedProvider == null
                                                ? 'Mohon memilih Penyedia TV Berbayar'
                                                : model.selectedProvider!
                                                    .description,
                                            style: model.selectedProvider ==
                                                    null
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
                            FormHelper.elevatedButtonBasic(context,
                                enabled: model.selectedProvider != null,
                                onTap: () {
                              model.onSubmit(context);
                            }, title: 'Cek Tagihan')
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
