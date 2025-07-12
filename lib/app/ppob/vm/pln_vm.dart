import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/ppob/models/ppob_general_model.dart';
import 'package:travelsya/app/ppob/pages/pln/pln_inquiry_postpaid_sheet.dart';
import 'package:travelsya/app/ppob/pages/pln/pln_inquiry_token_sheet.dart';
import 'package:travelsya/app/ppob/pages/pln/pln_type_picker_sheet.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/app/ppob/repository/ppob_repository.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/helper/function_helper.dart';

enum PLNType { token, postpaid }

class PLNVM extends BaseViewModel {
  TextEditingController controller = TextEditingController();
  PLNType type = PLNType.token;
  String uniqueCode = randomNumber();

  PPOBModel? selectedTokenVoucher;
  late PPOBModel selectedPostPaid;
  late PPOBModel selectedPostPaidInquiry;

  bool invoiceLoaded = false;
  String? plnValidation;

  onPelangganNumberChanged(String value) {
    if (value.isEmpty) {
      plnValidation = 'Mohon mengisi nomor pelanggan';
    } else {
      if (value.length >= 11 && value.length <= 12) {
        plnValidation = null;
      } else {
        plnValidation =
            'Nomor pelanggan tidak valid, nomor pelanggan harus 11-12 digit';
      }
    }
    notifyListeners();
  }

  doTopup(
    BuildContext context, {
    required bool usePoint,
  }) {
    showLoading(context);
    FinanceRepository.topUp(context,
            isPointUsed: usePoint,
            phone: controller.text,
            uniqueCode: uniqueCode,
            data: selectedTokenVoucher!)
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

  doPayment(
    BuildContext context, {
    required bool usePoint,
    required String nominal,
  }) {
    showLoading(context);
    FinanceRepository.paymentRequestInquiry(
      context,
      isPointUsed: usePoint,
      noTagihan: controller.text,
      uniqueCode: uniqueCode,
      nominalTagihan: nominal,
      productId: selectedPostPaid.id,
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
    onPelangganNumberChanged(controller.text);

    if (plnValidation == null) {
      FocusScope.of(context).requestFocus(FocusNode());

      if (type == PLNType.token) {
        if (selectedTokenVoucher == null) {
          showSnackbar(context,
              data: 'Mohon memilih voucher token terlebih dahulu',
              colors: Colors.orange);
        } else {
          List<bool>? result = await showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.6),
              backgroundColor: Colors.white,
              builder: (context) {
                return PLNInquiryTokenSheet(
                  data: selectedTokenVoucher!,
                  uniqueCode: uniqueCode,
                  pelangganNumber: controller.text,
                );
              });

          if (result != null && context.mounted) {
            doTopup(context, usePoint: result[1]);
          }
        }
      } else {
        showLoading(context);
        PPOBRepository.inquiryPPOB(context,
                inquiryType: selectedPostPaidInquiry.code,
                noPelanggan: controller.text)
            .then((valueCek) async {
          Navigator.pop(context);
          if (valueCek.status == RequestStatus.successRequest) {
            PPOBInquiryGeneralModel rawData = valueCek.data;

            List<bool>? result = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.6),
                backgroundColor: Colors.white,
                builder: (context) {
                  return PLNInquiryPostpaidSheet(
                      uniqueCode: uniqueCode,
                      data: PLNPostpaidInquiry.fromJson(rawData.rawData));
                });

            if (result != null && context.mounted) {
              doPayment(context,
                  usePoint: result[1],
                  nominal: PLNPostpaidInquiry.fromJson(rawData.rawData)
                      .tagihan
                      .toStringAsFixed(0));
            }
          } else {
            showSnackbar(context,
                data: valueCek.data ?? 'Gagal melakukan cek tagihan',
                colors: Colors.orange);
          }
        });
      }
    } else {
      showSnackbar(context,
          data: 'Mohon cek isian Anda', colors: Colors.orange);
    }
  }

  onInit(BuildContext context, String preloadNumber, int selectedIndexPreload) {
    PPOBState state = BlocProvider.of<PPOBCubit>(context).state;
    if (state is PPOBLoaded) {
      if (state.data.plnPascabayar != null &&
          state.data.plnPascaInquiry != null) {
        selectedPostPaid = state.data.plnPascabayar!;
        selectedPostPaidInquiry = state.data.plnPascaInquiry!;
      }

      if (state.data.pln.isEmpty) {
        type = PLNType.postpaid;
      }

      notifyListeners();
    }

    controller.text = preloadNumber;

    if (selectedIndexPreload == 1) {
      type = PLNType.postpaid;
    }

    notifyListeners();
  }

  onCheckID() {
    invoiceLoaded = true;
    notifyListeners();
  }

  onTokenTap(PPOBModel data) {
    selectedTokenVoucher = data;
    notifyListeners();
  }

  onChangeProduct(BuildContext context) async {
    int? result = await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        backgroundColor: Colors.transparent,
        constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height * 0.6,
            maxHeight: MediaQuery.of(context).size.height * 0.6),
        builder: (context) {
          return const PLNTypeBottomsheet();
        });

    if (result != null) {
      if (result == 0) {
        type = PLNType.token;
      } else {
        type = PLNType.postpaid;
      }

      notifyListeners();
    }
  }
}
