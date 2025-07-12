import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/health/services/health_service.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class HealthCheckoutVM extends BaseViewModel {
  bool usePoint = false;
  double pointUsed = 0;

  FeeAdmin? feeAdminData(List<FeeAdmin> data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i].serviceName.toLowerCase() == 'health-beauty') {
        return data[i];
      }
    }

    return null;
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

  onInit(BuildContext context) {
    BlocProvider.of<PointCubit>(context).fetchPoint(context);
  }

  onSubmit(
    BuildContext context, {
    required int packageId,
  }) {
    showLoading(context);
    HealthService.checkoutHealth(context, data: {
      "service": "health-beauty",
      "payment": "xendit",
      "package_id": packageId.toString(),
      "point": usePoint ? '1' : '0',
      "total_ticket": '1'
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
