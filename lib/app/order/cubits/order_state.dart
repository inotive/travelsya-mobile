import 'package:equatable/equatable.dart';
import 'package:travelsya/app/order/models/order_list_model.dart';
import 'package:travelsya/shared/api/api_return_value.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderFailed extends OrderState {
  final ApiReturnValue data;

  const OrderFailed(this.data);

  @override
  List<Object> get props => [data];
}

class ListOrderLoaded extends OrderState {
  final List<OrderList> data;

  const ListOrderLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class DetailOrderLoaded extends OrderState {
  final Map<String, dynamic> data;

  const DetailOrderLoaded(this.data);

  @override
  List<Object> get props => [data];
}
