import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/app/ppob/widgets/topup_confirmation_dialog.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
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
  bool usePoint = false;
  int pointUsed = 0;
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
      data.pulsa.forEach((element) {
        if (operatorCheckValidation(element)) {
          dataFinal.add(element);
        }
      });
    } else {
      data.data.forEach((element) {
        if (operatorCheckValidation(element)) {
          dataFinal.add(element);
        }
      });
    }

    return dataFinal;
  }

  operatorCheck(String value) {
    String? returnValue;

    if (value.length >= 4) {
      //check telkomsel
      telkomsel.forEach((element) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Telkomsel';
        }
      });

      //check telkomsel
      indosat.forEach((element) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Indosat';
        }
      });

      //check telkomsel
      telkomsel.forEach((element) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Telkomsel';
        }
      });

      //check Three
      three.forEach((element) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Three';
        }
      });

      //check telkomsel
      smartfren.forEach((element) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Smartfren';
        }
      });

      //check telkomsel
      xl.forEach((element) {
        if (value.substring(0, 4) == element) {
          returnValue = 'XL';
        }
      });

      axis.forEach((element) {
        if (value.substring(0, 4) == element) {
          returnValue = 'Axis';
        }
      });
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
              service: selectedIndex == 0 ? 'pulsa' : 'data',
              uniqueCode: uniqueCode,
              pelangganNumber: controller.text,
            );
          });

      if (result != null && context.mounted) {
        showLoading(context);
        FinanceRepository.topUp(context,
                uniqueCode: uniqueCode,
                isPointUsed: usePoint,
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
