import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/rental_mobil/services/rental_mobil_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/helper/function_helper.dart';

class RentalMobilCheckoutVM extends BaseViewModel {
  int identityType = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool usePoint = false;
  double pointUsed = 0;

  FeeAdmin? feeAdminData(List<FeeAdmin> data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i].serviceName.toLowerCase() == 'car-rent') {
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

    return moneyChanger(total);
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
      {required int packageId,
      required DateTime startDate,
      required int duration,
      required TimeOfDay time}) {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      showSnackbar(context,
          data: 'Mohon mengisi identitas Pemesan', colors: Colors.orange);
    } else {
      showLoading(context);
      RentalMobilService.checkoutRental(context, data: {
        "service": "car-rent",
        "payment": "xendit",
        "package_id": packageId.toString(),
        "point": usePoint ? '1' : '0',
        "date": DateFormat('yyyy-MM-dd').format(startDate),
        "duration": duration.toString(),
        "time":
            '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
        "location": "jakarta", //nama kota
        "is_same": 1,
        "customer_call": "Tuan",
        "customer_name": nameController.text,
        "customer_phone": "0${phoneController.text}",
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
