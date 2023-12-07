import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/models/ppob_general_model.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/app/ppob/repository/ppob_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/function/pay_to_inquiry_function.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/widgets/general_inquiry_widget.dart';

class BPJSKesehatanVM extends BaseViewModel {
  String uniqueCode = randomNumber();

  TextEditingController controller = TextEditingController();

  onInit(String preloadNumber) {
    controller.text = preloadNumber;
    notifyListeners();
  }

  PPOBModel? bpjsModelData(List<PPOBModel> data) {
    PPOBModel? dataFinal;

    for (var element in data) {
      if (element.code == ConstHelper.bpjsKSCode) {
        dataFinal = element;
      }
    }

    return dataFinal;
  }

  doPayment(BuildContext context,
      {required bool usePoint, required String nominal}) {
    PPOBState state = BlocProvider.of<PPOBCubit>(context).state;
    if (state is PPOBLoaded) {
      showLoading(context);
      FinanceRepository.paymentRequestInquiry(
        context,
        uniqueCode: uniqueCode,
        isPointUsed: usePoint,
        noTagihan: controller.text,
        productId: bpjsModelData(state.data.allData)!.id,
        nominalTagihan: nominal,
      ).then((value) async {
        Navigator.pop(context);
        if (value.status == RequestStatus.successRequest) {
          BlocProvider.of<MainIndexCubit>(context).changeIndex(1);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => UserPaymentWebview(
                        url: value.data,
                      )));
        } else {
          showSnackbar(context,
              data: value.data ?? 'Gagal membuat link pembayaran',
              colors: Colors.orange);
        }
      });
    }
  }

  onSubmit(BuildContext context, {required List<PPOBModel> dataPPOB}) async {
    showLoading(context);
    PPOBRepository.inquiryPPOB(context,
            inquiryType: payToInquiry(bpjsModelData(dataPPOB)!.code),
            noPelanggan: controller.text)
        .then((value) async {
      Navigator.pop(context);
      if (value.status == RequestStatus.successRequest) {
        bool? result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.6),
            backgroundColor: Colors.white,
            builder: (context) {
              return GeneralInquiryWidget(
                data: value.data,
                service: 'bpjs',
                uniqueCode: uniqueCode,
                accountNumber: controller.text,
                ppob: bpjsModelData(dataPPOB)!,
              );
            });

        if (result != null && context.mounted) {
          PPOBInquiryGeneralModel dataInquiry = value.data;
          doPayment(context,
              usePoint: result,
              nominal: dataInquiry.tagihan.toStringAsFixed(0));
        }
      } else {
        if (value.data.toString().contains('LUNAS/EXPIRED')) {
          showSnackbar(context,
              data: 'Tagihan sudah Lunas', colors: Colors.green);
        } else {
          showSnackbar(context,
              data: value.data ?? 'Gagal melakukan inquiry',
              colors: Colors.orange);
        }
      }
    });
  }
}
