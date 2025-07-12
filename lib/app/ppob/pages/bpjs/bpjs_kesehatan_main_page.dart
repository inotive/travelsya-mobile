import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/vm/bpjs_kesehatan_vm.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class BPJSKesehatanMainPage extends StatelessWidget {
  final String preloadNumber;
  const BPJSKesehatanMainPage({super.key, this.preloadNumber = ''});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BPJSKesehatanVM>.reactive(viewModelBuilder: () {
      return BPJSKesehatanVM();
    }, onViewModelReady: (model) {
      model.onInit(preloadNumber);
    }, builder: (context, model, child) {
      return StatusbarWidget(
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbarWidget(context, title: 'BPJS Kesehatan'),
        body: BlocBuilder<PPOBCubit, PPOBState>(
            bloc: BlocProvider.of<PPOBCubit>(context),
            builder: (context, state) {
              if (state is PPOBLoading) {
                return Center(
                  child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor),
                );
              } else if (state is PPOBLoaded) {
                if (model.bpjsModelData(state.data.allData) == null) {
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
                            'Saat ini pembayaran BPJS Kesehatan sedang tidak tersedia, mohon coba lagi nanti',
                            textAlign: TextAlign.center,
                            style: mainBody4,
                          )
                        ]),
                  );
                } else {
                  return ListView(
                    padding: EdgeInsets.all(margin16),
                    children: [
                      TitleWithWidget(
                        title: 'Nomor Pelanggan',
                        child: RoundedTextfield(
                            controller: model.controller,
                            keyboardType: TextInputType.number,
                            hintText: 'Masukkan Nomor Pelanggan'),
                      ),
                      SizedBox(height: margin24),
                      ElevatedButtonWidget(
                          onTap: () {
                            model.onSubmit(context,
                                dataPPOB: state.data.allData);
                          },
                          title: 'Cek Tagihan')
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
      ));
    });
  }
}
