import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/ppob/models/ppob_general_model.dart';
import 'package:travelsya/app/ppob/pages/ewallet/ewallet_provider_picker.dart';
import 'package:travelsya/app/ppob/pages/pdam/pdam_provider_picker.dart';
import 'package:travelsya/app/ppob/widgets/topup_confirmation_dialog.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/function/pay_to_inquiry_function.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/app/ppob/repository/ppob_repository.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/widgets/general_inquiry_widget.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class EwalletVM extends BaseViewModel {
  PPOBModel? selectedEwallet;
  PPOBModel? selectedData;
  String uniqueCode = randomNumber();
  TextEditingController controller = TextEditingController();

  bool usePoint = false;
  int pointUsed = 0;

  onChangePointUsed(BuildContext context) {
    if (usePoint == false) {
      ProfileState state = BlocProvider.of<ProfileCubit>(context).state;
      if (state is ProfileLoaded) {
        if (state.data.user.point > 0) {
          usePoint = !usePoint;
          pointUsed = state.data.user.point;
          notifyListeners();
        }
      }
    } else {
      usePoint = !usePoint;
      pointUsed = 0;
      notifyListeners();
    }
  }

  onInit(String preloadNumber) {
    controller.text = preloadNumber;
    notifyListeners();
  }

  doPayment(BuildContext context,
      {required bool usePoint, required String nominal}) {
    showLoading(context);
    FinanceRepository.paymentRequestInquiry(
      context,
      isPointUsed: usePoint,
      uniqueCode: uniqueCode,
      noTagihan: controller.text,
      nominalTagihan: nominal,
      productId: selectedEwallet!.id,
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
              inquiryType: payToInquiry(selectedEwallet!.code),
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
                  service: 'ewallet',
                  uniqueCode: uniqueCode,
                  accountNumber: controller.text,
                  ppob: selectedEwallet!,
                );
              });

          if (result != null && context.mounted) {
            PPOBInquiryGeneralModel dataResult = value.data;
            doPayment(context,
                usePoint: false,
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
          return const EWalletProviderPicker();
        });

    if (result != null) {
      selectedEwallet = result;
      selectedData = null;

      notifyListeners();
    }
  }

  List<PPOBModel> getDataEWalletByOperator(List<PPOBModel> dataRaw) {
    List<PPOBModel> dataFinal = [];

    if (selectedEwallet != null) {
      for (var i = 0; i < dataRaw.length; i++) {
        if (dataRaw[i].operator == selectedEwallet!.operator) {
          dataFinal.add(dataRaw[i]);
        }
      }
    }

    return dataFinal;
  }

  onSelectProduct(PPOBModel data) {
    selectedData = data;
    notifyListeners();
  }

  bool isSelectedProduct(PPOBModel data) {
    if (selectedData != null) {
      if (selectedData!.id == data.id) {
        return true;
      }
    }

    return false;
  }

  doTopup(BuildContext context) {
    if (controller.text.isEmpty) {
      showSnackbar(context,
          data: 'Mohon mengisi nomor E-Wallet', colors: Colors.orange);
    } else {
      needLoginFeature(context, () async {
        List<bool>? result = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            constraints: BoxConstraints(maxHeight: 60.0.h),
            backgroundColor: Colors.white,
            builder: (context) {
              return TopupConfirmationDialog(
                data: selectedData!,
                uniqueCode: uniqueCode,
                service: 'ewallet',
                pelangganNumber: controller.text,
              );
            });

        if (result != null && context.mounted) {
          showLoading(context);
          FinanceRepository.topUp(context,
                  uniqueCode: uniqueCode,
                  isPointUsed: result[1],
                  phone: controller.text,
                  data: selectedData!)
              .then((value) async {
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
      });
    }
  }
}
