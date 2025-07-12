import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/bus/models/bus_filter_model.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/app/bus/services/bus_service.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/helper/function_helper.dart';

class BusCheckoutVM extends BaseViewModel {
  int identityType = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool usePoint = false;
  double pointUsed = 0;

  FeeAdmin? feeAdminData(List<FeeAdmin> data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i].serviceName.toLowerCase() == 'bus-travel') {
        return data[i];
      }
    }

    return null;
  }

  // double getAdminValue(BuildContext context) {
  //   double finalData = 0;

  //   FeeAdminState state = BlocProvider.of<FeeAdminCubit>(context).state;
  //   if (state is FeeAdminLoaded) {
  //     for (var i = 0; i < state.data.length; i++) {
  //       if (state.data[i].serviceName.toLowerCase() == 'hotel') {
  //         double total = (hotelRoom.sellingPrice *
  //                 filter.roomCount *
  //                 (filter.selectedTime.endDate!
  //                     .difference(filter.selectedTime.startDate!)
  //                     .inDays))
  //             .toDouble();

  //         finalData = getAdminFeeHelper(state.data[i], total);
  //       }
  //     }
  //   }

  //   return finalData;
  // }

  String getTotalInvoice(double subtotal) {
    double total = subtotal;

    return moneyChanger(total, customLabel: 'IDR ');
  }

  onChangePointUsed(BuildContext context) {
    if (usePoint == false) {
      PointState state = BlocProvider.of<PointCubit>(context).state;
      if (state is PointLoaded) {
        if (state.data.pointAvailable > 0) {
          usePoint = !usePoint;
          pointUsed = state.data.pointAvailable;
          notifyListeners();
        }
      }
    } else {
      usePoint = !usePoint;
      pointUsed = 0;
      notifyListeners();
    }
  }

  onChangeType(int value) {
    identityType = value;
    notifyListeners();
  }

  onInit(BuildContext context) {
    AuthState stateUser = BlocProvider.of<AuthCubit>(context).state;
    BlocProvider.of<PointCubit>(context).fetchPoint(context);
    if (stateUser is AuthLoaded) {
      nameController.text = stateUser.data.name;
      phoneController.text = stateUser.data.phone ?? '';
      emailController.text = stateUser.data.email;
      notifyListeners();
    }
  }

  onSubmit(BuildContext context,
      {required BusFilterModel filter,
      required BusDataModel goData,
      BusDataModel? backData}) {
    log(nameController.text);
    log(phoneController.text);
    log(emailController.text);

    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      showSnackbar(context,
          data: 'Mohon mengisi identitas Pemesan', colors: Colors.orange);
    } else {
      showLoading(context);
      BusService.checkoutBus(context, data: {
        "service": "bus-travel",
        "payment": "xendit",
        "ticket_pergi_id": goData.id.toString(),
        "ticket_pulang_id": backData == null ? '' : backData.id.toString(),
        "point": usePoint ? '1' : '0', // 1: use point 0:nonusepoint
        "date_pergi": DateFormat('yyyy-MM-dd').format(filter.selectedDateGo!),
        "date_pulang": filter.isWayBack
            ? DateFormat('yyyy-MM-dd').format(filter.selectedDateBack!)
            : '',
        "jumlah_penumpang": filter.totalPassanger.toString(),
        "is_pulang_pergi": filter.isWayBack ? '1' : '0',
        "is_same": 1,
        "customer_call": "Tuan",
        "customer_name": nameController.text,
        "customer_phone": phoneController.text,
        "customer_email": emailController.text
      }).then((value) async {
        if (context.mounted) {
          Navigator.pop(context);
          if (value.status == RequestStatus.successRequest) {
            BlocProvider.of<MainIndexCubit>(context).changeIndex(1);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomeMainPage()),
                (route) => false);

            Navigator.push(
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
        }
      });
    }
  }
}
