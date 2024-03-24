import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_filter_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class HostelFormVM extends BaseViewModel {
  int identityType = 0;
  String uniqueCode = randomNumber();
  HostelCubit hostelRoomCubit = HostelCubit();
  TextEditingController nameController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool usePoint = false;
  double pointUsed = 0;

  FeeAdmin? feeAdminData(List<FeeAdmin> data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i].serviceName.toLowerCase() == 'hostel') {
        return data[i];
      }
    }

    return null;
  }

  double getAdminValue(BuildContext context, HostelRoom data) {
    double finalData = 0;

    FeeAdminState state = BlocProvider.of<FeeAdminCubit>(context).state;
    if (state is FeeAdminLoaded) {
      for (var i = 0; i < state.data.length; i++) {
        if (state.data[i].serviceName.toLowerCase() == 'hostel') {
          double total = (data.sellingPrice * filter.totalDuration).toDouble();

          finalData = getAdminFeeHelper(state.data[i], total);
        }
      }
    }

    return finalData;
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

  String getEndSewa(
    BuildContext context,
  ) {
    HostelState state = BlocProvider.of<HostelFilterCubit>(context).state;
    if (state is HostelSearchFilter) {
      DateTime currentDate = state.startDate;

      if (state.selectedDuration == 'Bulanan') {
        int finalMonth = currentDate.month;
        finalMonth = finalMonth + state.totalDuration;
        currentDate = DateTime((currentDate.year + (finalMonth ~/ 12)),
            finalMonth % 12, currentDate.day);
      } else {
        int finalYear = currentDate.year;
        finalYear = finalYear + state.totalDuration;
        currentDate = DateTime(finalYear, currentDate.month, currentDate.day);
      }

      return dateToReadable(DateFormat('yyyy-MM-dd').format(currentDate));
    } else {
      return '';
    }
  }

  DateTime getEndSewaDateTime(
    BuildContext context,
  ) {
    HostelState state = BlocProvider.of<HostelFilterCubit>(context).state;
    if (state is HostelSearchFilter) {
      DateTime currentDate = state.startDate;

      if (state.selectedDuration == 'Bulanan') {
        int finalMonth = currentDate.month;
        finalMonth = finalMonth + state.totalDuration;
        currentDate = DateTime((currentDate.year + (finalMonth ~/ 12)),
            finalMonth % 12, currentDate.day);
      } else {
        int finalYear = currentDate.year;
        finalYear = finalYear + state.totalDuration;
        currentDate = DateTime(finalYear, currentDate.month, currentDate.day);
      }

      return currentDate;
    } else {
      return filter.startDate;
    }
  }

  late HostelSearchFilter filter;

  onInit(BuildContext context, {required String roomId}) {
    AuthState stateUser = BlocProvider.of<AuthCubit>(context).state;
    BlocProvider.of<PointCubit>(context).fetchPoint(context);
    if (stateUser is AuthLoaded) {
      nameController.text = stateUser.data.name;
      phoneController.text = stateUser.data.phone ?? '';
      emailController.text = stateUser.data.email;
      notifyListeners();
    }

    hostelRoomCubit.fetchDetailRoom(context, id: roomId);

    HostelState state = BlocProvider.of<HostelFilterCubit>(context).state;
    if (state is HostelSearchFilter) {
      filter = state;
      notifyListeners();
    }
  }

  String getTotalInvoice(HostelRoom data) {
    double total = (data.sellingPrice * filter.totalDuration).toDouble();

    return moneyChanger(total);
  }

  String getGrandTotalInvoice(BuildContext context, HostelRoom data) {
    double total = (data.sellingPrice * filter.totalDuration).toDouble();
    double unique = double.parse(uniqueCode);
    double admin = getAdminValue(context, data);

    return moneyChanger(total + unique + admin);
  }

  onSubmit(BuildContext context,
      {required HostelDetailModel data, required HostelRoom room}) {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      showSnackbar(context,
          data: 'Mohon mengisi identitas Pemesan', colors: Colors.orange);
    } else {
      showLoading(context);
      FinanceRepository.paymentRequestHostel(context, data: {
        "service": "hostel",
        "payment": "xendit",
        "hostel_room_id": room.id.toString(),
        "point": usePoint ? 1 : 0,
        'total_room': '1',
        'duration_type': filter.selectedDuration.toLowerCase() == 'bulanan'
            ? 'monthly'
            : 'yearly',
        'total_guest': '1',
        "url": '',
        "guest": [
          {
            "type_id": "KTP",
            "identity": 123456,
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text
          }
        ],
        "kode_unik": uniqueCode,
        "start": DateFormat('yyyy-MM-dd').format(filter.startDate),
        "end": DateFormat('yyyy-MM-dd').format(getEndSewaDateTime(context))
      }).then((value) async {
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
      });
    }
  }
}
