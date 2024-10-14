import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/order/cubits/order_state.dart';
import 'package:travelsya/app/order/models/order_list_model.dart';
import 'package:travelsya/app/order/repository/order_repository.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  fetchOrderData(BuildContext context) {
    emit(OrderLoading());
    OrderRepository.fetchListOrder(context).then((value) {
      if (value.status == RequestStatus.successRequest) {
        List<OrderList> dataFinal = value.data;
        dataFinal = dataFinal.reversed.toList();
        emit(ListOrderLoaded(dataFinal));
      } else {
        emit(OrderFailed(value));
      }
    });
  }

  fetchOrderDetail(BuildContext context, {required String noInv}) {
    emit(OrderLoading());
    OrderRepository.fetchDetailOrder(context, invId: noInv).then((value) {
      if (value.status == RequestStatus.successRequest) {
        emit(DetailOrderLoaded(value.data));
      } else {
        emit(OrderFailed(value));
      }
    });
  }
}
