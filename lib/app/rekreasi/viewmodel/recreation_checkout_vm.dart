import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/home_main/pages/home_main_page.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
// import 'package:travelsya/app/rekreasi/pages%20new/new_rekreasi_checkout_page.dart';
import 'package:travelsya/app/rekreasi/services/recreation_service.dart';
import 'package:travelsya/shared/api/api_return_value.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/show_loading.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/helper/function_helper.dart';

import '../pages new/new_rekreasi_checkout_page.dart';

class RecreationCheckoutVM extends BaseViewModel {
  bool usePoint = false;
  double pointUsed = 0;
  String uniqueCode = randomNumber();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FeeAdmin? feeAdminData(List<FeeAdmin> data) {
    for (var i = 0; i < data.length; i++) {
      if (data[i].serviceName.toLowerCase() == 'recreation') {
        return data[i];
      }
    }

    return null;
  }

  double getAdminValue(BuildContext context, double totalItem) {
    double finalData = 0;

    FeeAdminState state = BlocProvider.of<FeeAdminCubit>(context).state;
    if (state is FeeAdminLoaded) {
      for (var i = 0; i < state.data.length; i++) {
        if (state.data[i].serviceName.toLowerCase() == 'recreation') {
          finalData = getAdminFeeHelper(state.data[i], totalItem);
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

  double getTotalItemPrice(List<CheckoutItem> items) {
    return items.fold(
      0.0,
      (sum, e) => sum + (e.package.price * e.quantity),
    );
  }

  double getGrandTotal(
    BuildContext context,
    List<CheckoutItem> items,
  ) {
    final totalItem = getTotalItemPrice(items);
    final admin = getAdminValue(context, totalItem);
    final unique = double.parse(uniqueCode);

    return totalItem + admin + unique;
  }

  onSubmit(
    BuildContext context, {
    required int packageId,
  }) {
    showLoading(context);
    RecreationService.checkoutRecreation(context, data: {
      "service": "recreation",
      "payment": "xendit",
      "package_id": packageId.toString(),
      "point": usePoint ? '1' : '0',
      "total_ticket": '1',
      "kode_unik": uniqueCode,
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

  // //tes
  // onSubmit(
  //   BuildContext context, {
  //   required int packageId,
  //   required int recreationId, // tambahkan recreationId biar ga error
  //   required int total, // total dari perhitungan tagihan
  // }) async {
  //   showLoading(context);

  //   try {
  //     final value = await RecreationService.checkoutRecreation(
  //       context,
  //       data: {
  //         "service": "recreation",
  //         "payment": "xendit",
  //         "package_id": packageId.toString(),
  //         "total_ticket": "1",
  //         "point": usePoint ? '1' : '0',
  //         "guest_identity": [], // nanti bisa diisi sesuai kebutuhan
  //         "recreation_id": recreationId.toString(),
  //         "total": total.toString(),
  //       },
  //     );

  //     if (context.mounted) {
  //       Navigator.pop(context); // tutup loading

  //       if (value.status == RequestStatus.successRequest) {
  //         BlocProvider.of<MainIndexCubit>(context).changeIndex(1);

  //         Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (_) => const HomeMainPage()),
  //           (route) => false,
  //         );

  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => UserPaymentWebview(
  //               url: value.data,
  //             ),
  //           ),
  //         );
  //       } else {
  //         showSnackbar(
  //           context,
  //           data: value.data ?? 'Gagal membuat link pembayaran',
  //           colors: Colors.orange,
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       Navigator.pop(context);
  //       showSnackbar(
  //         context,
  //         data: 'Terjadi kesalahan: $e',
  //         colors: Colors.orange,
  //       );
  //     }
  //   }
  // }

  //ONSUBMIT YG SEBELUMNYA
  // onSubmit(
  //   BuildContext context, {
  //   required int packageId,
  // }) {
  //   showLoading(context);
  //   RecreationService.checkoutRecreation(context, data: {
  //     "service": "recreation",
  //     "payment": "xendit",
  //     "package_id": packageId.toString(),
  //     "point": usePoint ? '1' : '0',
  //     "total_ticket": '1'
  //   }).then((value) async {
  //     if (context.mounted) {
  //       Navigator.pop(context);
  //       if (value.status == RequestStatus.successRequest) {
  //         BlocProvider.of<MainIndexCubit>(context).changeIndex(1);

  //         Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(builder: (_) => const HomeMainPage()),
  //             (route) => false);

  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (_) => UserPaymentWebview(
  //                       url: value.data,
  //                     )));
  //       } else {
  //         showSnackbar(context,
  //             data: value.data ?? 'Gagal membuat link pembayaran',
  //             colors: Colors.orange);
  //       }
  //     }
  //   });
  // }

//PAYMENT PAKET LEBIH DARI 1
  // onSubmit(
  //   BuildContext context, {
  //   required List<CheckoutItem> items,
  // }) async {
  //   showLoading(context);

  //   try {
  //     List<String> paymentUrls = [];

  //     for (var item in items) {
  //       final response = await RecreationService.checkoutRecreation(
  //         context,
  //         data: {
  //           "service": "recreation",
  //           "payment": "xendit",
  //           "package_id": item.package.id.toString(),
  //           "point": usePoint ? '1' : '0',
  //           "total_ticket": item.quantity.toString(),
  //           "status": "pending"
  //         },
  //       );

  //       if (response.status == RequestStatus.successRequest) {
  //         paymentUrls.add(response.data);
  //       } else {
  //         Navigator.pop(context);
  //         showSnackbar(
  //           context,
  //           data: response.data ?? 'Gagal membuat link pembayaran',
  //           colors: Colors.orange,
  //         );
  //         return;
  //       }
  //     }

  //     if (context.mounted) {
  //       Navigator.pop(context);
  //       BlocProvider.of<MainIndexCubit>(context).changeIndex(1);
  //       Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (_) => const HomeMainPage()),
  //         (route) => false,
  //       );

  //       if (paymentUrls.isNotEmpty) {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => UserPaymentWebview(url: paymentUrls.first),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {
  //     if (context.mounted) {
  //       Navigator.pop(context);
  //       showSnackbar(context,
  //           data: 'Terjadi kesalahan: $e', colors: Colors.orange);
  //     }
  //   }
  // }
}
