import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/app/ppob/widgets/topup_confirmation_dialog.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/helper/function_helper.dart';

class PulsaVM extends BaseViewModel {
  int selectedIndex = 0;
  String uniqueCode = randomNumber();
  PPOBModel? selectedData;
  TextEditingController controller = TextEditingController();
  String? selectedProvider;
  double pointUsed = 0;
  String type = 'prabayar';

  onInit(String preloadNumber) {
    controller.text = preloadNumber;
    operatorCheck(preloadNumber);
    notifyListeners();
  }

  changeType(String value) {
    type = value;
    notifyListeners();
  }

  var telkomsel = [
    "0812",
    "0813",
    "0821",
    "0822",
    "0852",
    "0853",
    "0823",
    "0851"
  ];
  var indosat = ["0814", "0815", "0816", "0855", "0856", "0857", "0858"];
  var three = ["0895", "0896", "0897", "0898", "0899"];
  var smartfren = [
    "0881",
    "0882",
    "0883",
    "0884",
    "0885",
    "0886",
    "0887",
    "0888",
    "0889"
  ];
  var xl = ["0817", "0818", "0819", "0859", "0877", "0878"];
  var axis = ["0838", "0831", "0832", "0833"];

  onDataTap(PPOBModel data) {
    selectedData = data;
    notifyListeners();
  }

  bool operatorCheckValidation(PPOBModel data) {
    bool returnValue = false;
    if (selectedProvider != null) {
      if (data.operator
          .toLowerCase()
          .contains(selectedProvider!.toLowerCase())) {
        returnValue = true;
      }
    }

    return returnValue;
  }

  List<PPOBModel> getListDataByOperator(PPOBGroup data) {
    List<PPOBModel> dataFinal = [];

    if (selectedIndex == 0) {
      //pulsa
      for (var element in data.pulsa) {
        if (operatorCheckValidation(element)) {
          dataFinal.add(element);
        }
      }
    } else {
      for (var element in data.data) {
        if (operatorCheckValidation(element)) {
          dataFinal.add(element);
        }
      }
    }

    return dataFinal;
  }

  operatorCheck(String value) {
    String? returnValue;

    if (value.length >= 4) {
      //check telkomsel
      for (var element in telkomsel) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Telkomsel';
        }
      }

      //check telkomsel
      for (var element in indosat) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Indosat';
        }
      }

      //check telkomsel
      for (var element in telkomsel) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Telkomsel';
        }
      }

      //check Three
      for (var element in three) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Three';
        }
      }

      //check telkomsel
      for (var element in smartfren) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Smartfren';
        }
      }

      //check telkomsel
      for (var element in xl) {
        if (value.substring(0, 4) == element) {
          returnValue = 'XL';
        }
      }

      for (var element in axis) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Axis';
        }
      }
    } else {
      selectedData = null;
    }

    selectedProvider = returnValue;
    notifyListeners();
  }

  onIndexChanged(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  onSubmit(BuildContext context) async {
    needLoginFeature(context, () async {
      BlocProvider.of<PointCubit>(context).fetchPoint(context);
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
            return TopupConfirmationDialog(
              data: selectedData!,
              service: selectedIndex == 0 ? 'pulsa' : 'data',
              uniqueCode: uniqueCode,
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
