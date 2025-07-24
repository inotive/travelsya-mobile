import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/order/cubits/order_cubit.dart';
import 'package:travelsya/app/order/cubits/order_state.dart';
import 'package:travelsya/app/order/models/order_detail_model.dart';
import 'package:travelsya/app/order/vm/order_detail_vm.dart';
import 'package:travelsya/app/order/widgets/bus_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/car_rent_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/clinic_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/hostel_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/hotel_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/inquiry_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/recreation_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/topup_detail_order_section.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class OrderDetailPage extends StatelessWidget {
  final String noInv;

  const OrderDetailPage({
    super.key,
    required this.noInv,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailVM>.reactive(viewModelBuilder: () {
      return OrderDetailVM();
    }, onViewModelReady: (model) {
      model.orderCubit.fetchOrderDetail(context, noInv: noInv);
    }, builder: (context, model, child) {
      return StatusbarWidget(
          customBrightness: Brightness.light,
          child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      left: margin16,
                      right: margin16,
                      top: margin16 + MediaQuery.of(context).padding.top,
                      bottom: margin16),
                  color: Theme.of(context).primaryColor,
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: margin24 / 2,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Detail Transaksi',
                            style: mainBody4.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            noInv,
                            style: mainBody5.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                ),
                BlocBuilder<OrderCubit, OrderState>(
                  bloc: model.orderCubit,
                  builder: (context, state) {
                    if (state is OrderLoading) {
                      return Expanded(
                          child: Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).primaryColor,
                        ),
                      ));
                    } else if (state is DetailOrderLoaded) {
                      String service =
                          state.data['service'].toString().toLowerCase();

                      try {
                        service = state.data['tickets'][0][0]['service'];
                      } catch (e) {}

                      if (service == 'null') {
                        return Expanded(
                            child: Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(
                              vertical: margin16, horizontal: margin16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.asset(
                                  'assets/icons/logo.jpg',
                                ),
                              ),
                              SizedBox(
                                height: margin24 / 2,
                              ),
                              Text(
                                'Terjadi Kesalahan',
                                style: mainBody3.copyWith(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: margin4,
                              ),
                              Text(
                                'Terjadi kesalahan dalam memuat detail transaksi, mohon coba lagi nanti',
                                textAlign: TextAlign.center,
                                style: mainBody4.copyWith(
                                  color: Colors.black54,
                                ),
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              FormHelper.borderButton(context, onTap: () {
                                model.orderCubit
                                    .fetchOrderDetail(context, noInv: noInv);
                              }, title: 'Coba Lagi')
                            ],
                          ),
                        ));
                      } else {
                        if (service == 'hotel') {
                          return Expanded(
                              child: HotelDetailOrderSection(
                            onRefresh: () {
                              model.orderCubit
                                  .fetchOrderDetail(context, noInv: noInv);
                            },
                            data: OrderDetailHotelModel.fromJson(state.data),
                          ));
                        } else if (service == 'hostel') {
                          return Expanded(
                              child: HostelDetailOrderSection(
                            onRefresh: () {
                              model.orderCubit
                                  .fetchOrderDetail(context, noInv: noInv);
                            },
                            data: OrderDetailHostelModel.fromJson(state.data),
                          ));
                        } else if (service == 'pln' ||
                            service == 'bpjs' ||
                            service == 'pdam' ||
                            service.contains('tv') ||
                            service.contains('pajak')) {
                          return Expanded(
                              child: InquiryDetailOrderSection(
                            data: OrderDetailInquiryModel.fromJson(state.data),
                          ));
                        } else if (service == 'recreation') {
                          return Expanded(
                              child: RecreationDetailOrderSection(
                            data:
                                RecreationOrderDetailModel.fromJson(state.data),
                          ));
                        } else if (service == 'car-rent') {
                          return Expanded(
                              child: CarRentDetailOrderSection(
                                  data: CarRentOrderDetailModel.fromJson(
                                      state.data)));
                        } else if (service == 'health-beauty') {
                          return Expanded(
                              child: ClinicDetailOrderSection(
                            data: ClinicOrderDetailModel.fromJson(state.data),
                          ));
                        } else if (service == 'bus-travel') {
                          return Expanded(
                            child: BusDetailOrderSection(
                                data: BusDetailOrderModel.fromJson(
                                    state.data['tickets'][0][0])),
                          );
                        } else {
                          return Expanded(
                              child: TopupDetailOrderSection(
                            data: OrderDetailTopupModel.fromJson(state.data),
                          ));
                        }
                      }
                    } else {
                      return Expanded(
                          child: Container(
                        margin: EdgeInsets.symmetric(horizontal: margin16),
                        child: FailedRequestWidget(
                          onRetry: () {
                            model.orderCubit
                                .fetchOrderDetail(context, noInv: noInv);
                          },
                        ),
                      ));
                    }
                  },
                )
              ],
            ),
          ));
    });
  }
}
