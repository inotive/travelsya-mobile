import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/ppob/models/ppob_general_model.dart';
import 'package:travelsya/app/ppob/pages/pdam/pdam_provider_picker.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/function/pay_to_inquiry_function.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/app/ppob/repository/ppob_repository.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/widgets/general_inquiry_widget.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class PDAMVM extends BaseViewModel {
  PPOBModel? selectedPDAM;
  String uniqueCode = randomNumber();
  TextEditingController controller = TextEditingController();

  doPayment(BuildContext context,
      {required bool usePoint, required String nominal}) {
    showLoading(context);
    FinanceRepository.paymentRequestInquiry(
      context,
      uniqueCode: uniqueCode,
      isPointUsed: usePoint,
      noTagihan: controller.text,
      nominalTagihan: nominal,
      productId: selectedPDAM!.id,
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

  onSubmit(BuildContext context) async {
    if (controller.text.isEmpty) {
      showSnackbar(context,
          data: 'Mohon untuk mengisi nomor pelanggan', colors: Colors.orange);
    } else {
      showLoading(context);
      PPOBRepository.inquiryPPOB(context,
              inquiryType: payToInquiry(selectedPDAM!.code),
              noPelanggan: controller.text)
          .then((value) async {
        Navigator.pop(context);
        if (value.status == RequestStatus.successRequest) {
          BlocProvider.of<PointCubit>(context).fetchPoint(context);
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
                  uniqueCode: uniqueCode,
                  service: 'negara',
                  data: value.data,
                  accountNumber: controller.text,
                  ppob: selectedPDAM!,
                );
              });

          if (result != null && context.mounted) {
            PPOBInquiryGeneralModel dataResult = value.data;
            doPayment(context,
                usePoint: result,
                nominal: dataResult.tagihan.toStringAsFixed(0));
          }
        } else {
          showSnackbar(context,
              data: value.data ?? 'Gagal melakukan inquiry',
              colors: Colors.orange);
        }
      });
    }
  }

  onChangeProduct(BuildContext context) async {
    PPOBModel? result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        backgroundColor: Colors.white,
        builder: (context) {
          return const PDAMProviderPicker();
        });

    if (result != null) {
      selectedPDAM = result;

      notifyListeners();
    }
  }

  onInit(String preloadNumber) {
    controller.text = preloadNumber;
    notifyListeners();
  }
}
