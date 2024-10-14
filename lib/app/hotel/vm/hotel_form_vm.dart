import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/models/hotel_detail_model.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/payment/repository/finance_repository.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class HotelFormVM extends BaseViewModel {
  int identityType = 0;
  HotelCubit hotelDetailRoomCubit = HotelCubit();
  TextEditingController nameController = TextEditingController();
  TextEditingController identityNumberController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  String uniqueCode = randomNumber();

  bool usePoint = false;
  double pointUsed = 0;

  FeeAdmin? feeAdminData(List<FeeAdmin> data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i].serviceName.toLowerCase() == 'hotel') {
        return data[i];
      }
    }

    return null;
  }

  double getAdminValue(BuildContext context, HotelRoom hotelRoom) {
    double finalData = 0;

    FeeAdminState state = BlocProvider.of<FeeAdminCubit>(context).state;
    if (state is FeeAdminLoaded) {
      for (var i = 0; i < state.data.length; i++) {
        if (state.data[i].serviceName.toLowerCase() == 'hotel') {
          double total = (hotelRoom.sellingPrice *
                  filter.roomCount *
                  (filter.selectedTime.endDate!
                      .difference(filter.selectedTime.startDate!)
                      .inDays))
              .toDouble();

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

  late HotelSearchFilter filter;

  onInit(BuildContext context, {required String roomId}) {
    AuthState stateUser = BlocProvider.of<AuthCubit>(context).state;
    BlocProvider.of<PointCubit>(context).fetchPoint(context);
    if (stateUser is AuthLoaded) {
      nameController.text = stateUser.data.name;
      phoneController.text = stateUser.data.phone ?? '';
      emailController.text = stateUser.data.email;
      notifyListeners();
    }

    HotelState state = BlocProvider.of<HotelFilterCubit>(context).state;
    if (state is HotelSearchFilter) {
      filter = state;
      notifyListeners();
    }

    hotelDetailRoomCubit.fetchDetailRoom(context, id: roomId);
  }

  String getTotalInvoice(HotelRoom data) {
    double total = (data.sellingPrice *
            filter.roomCount *
            (filter.selectedTime.endDate!
                .difference(filter.selectedTime.startDate!)
                .inDays))
        .toDouble();

    return moneyChanger(total);
  }

  String getGrandTotalInvoice(BuildContext context, HotelRoom data) {
    double total = (data.sellingPrice *
            filter.roomCount *
            (filter.selectedTime.endDate!
                .difference(filter.selectedTime.startDate!)
                .inDays))
        .toDouble();
    double unique = double.parse(uniqueCode);
    double admin = getAdminValue(context, data);

    return moneyChanger(total + unique + admin);
  }

  onSubmit(BuildContext context,
      {required HotelDetailModel data, required HotelRoom room}) {
    if (nameController.text.isEmpty ||
        phoneController.text.isEmpty ||
        emailController.text.isEmpty) {
      showSnackbar(context,
          data: 'Mohon mengisi identitas Pemesan', colors: Colors.orange);
    } else {
      showLoading(context);
      FinanceRepository.paymentRequestHotel(context, data: {
        "service": "hotel",
        "payment": "xendit",
        "hotel_room_id": room.id.toString(),
        "point": usePoint ? 1 : 0,
        "url": '',
        'total_room': filter.roomCount,
        'total_guest': filter.guessCount,
        "kode_unik": uniqueCode,
        "guest": [
          {
            "type_id": "KTP",
            "identity": 123456,
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text
          }
        ],
        "start":
            DateFormat('yyyy-MM-dd').format(filter.selectedTime.startDate!),
        "end": DateFormat('yyyy-MM-dd').format(filter.selectedTime.endDate!)
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
