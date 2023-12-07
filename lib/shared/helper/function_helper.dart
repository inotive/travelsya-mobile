import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_model.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';
import 'package:travelsya/shared/styles/font_style.dart';

Widget getTransactionLabel(String data) {
  return Text(
      data.toLowerCase() == 'pending' || data.toLowerCase() == 'process'
          ? 'Menunggu Pembayaran'
          : data.toLowerCase() == 'paid'
              ? 'Lunas'
              : data.toLowerCase() == 'expired'
                  ? 'Expired'
                  : data,
      style: mainFont.copyWith(
        fontSize: 12,
        color:
            data.toLowerCase() == 'pending' || data.toLowerCase() == 'process'
                ? Colors.orange
                : data.toLowerCase() == 'paid'
                    ? Colors.green
                    : Colors.red,
      ));
}

double getAdminFeeByService(
    BuildContext context, String service, double subtotal) {
  double finalData = 0;

  FeeAdminState state = BlocProvider.of<FeeAdminCubit>(context).state;
  if (state is FeeAdminLoaded) {
    for (var i = 0; i < state.data.length; i++) {
      if (state.data[i].serviceName == service) {
        finalData = getAdminFeeHelper(state.data[i], subtotal);
      }
    }
  }

  return finalData;
}

double getAdminFeeHelper(FeeAdmin data, double subtotal) {
  double finalData = 0;

  if (data.isPercent == 1) {
    finalData = subtotal * (data.value / 100);
  } else {
    finalData = data.value.toDouble();
  }

  return finalData;
}

String moneyChanger(double value, {String? customLabel}) {
  return NumberFormat.currency(
          name: customLabel ?? 'Rp', decimalDigits: 0, locale: 'id')
      .format(value.round());
}

String randomNumber({int totalLength = 3}) {
  Random random = Random();

  String finalString = '';

  for (var i = 0; i < totalLength; i++) {
    int randomNumber = random.nextInt(9) + 1;

    finalString = finalString + randomNumber.toString();
  }

  return finalString;
}

String getPreviewAssetTransaction(String service) {
  if (service == 'BPJS') {
    return 'assets/icons/user-protection 1.png';
  } else if (service == 'HOTEL') {
    return 'assets/icons/surface1.png';
  } else if (service == 'HOSTEL') {
    return 'assets/icons/bank 1.png';
  } else if (service == 'PLN') {
    return 'assets/icons/light-bulb.png';
  } else if (service == 'PDAM') {
    return 'assets/icons/Icon PDAM.png';
  } else if (service.contains('PULSA')) {
    return 'assets/icons/Group (3).png';
  } else if (service.contains('TV')) {
    return 'assets/icons/Group (2).png';
  } else if (service == 'PAJAK') {
    return 'assets/icons/Group (4).png';
  } else if (service == 'DATA') {
    return 'assets/icons/Group (3).png';
  } else if (service == 'EWALLET') {
    return 'assets/icons/purse 1.png';
  } else if (service.contains('TOKEN')) {
    return 'assets/icons/light-bulb.png';
  }

  return 'assets/icons/invoice 1.png';
}
