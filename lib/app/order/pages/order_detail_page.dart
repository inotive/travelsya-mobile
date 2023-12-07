import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/order/cubits/order_cubit.dart';
import 'package:travelsya/app/order/cubits/order_state.dart';
import 'package:travelsya/app/order/models/order_detail_model.dart';
import 'package:travelsya/app/order/models/order_list_model.dart';
import 'package:travelsya/app/order/vm/order_detail_vm.dart';
import 'package:travelsya/app/order/widgets/hostel_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/hotel_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/inquiry_detail_order_section.dart';
import 'package:travelsya/app/order/widgets/topup_detail_order_section.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class OrderDetailPage extends StatefulWidget {
  final String noInv;

  const OrderDetailPage({
    Key? key,
    required this.noInv,
  }) : super(key: key);

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  OrderCubit orderCubit = OrderCubit();

  @override
  void initState() {
    orderCubit.fetchOrderDetail(context, noInv: widget.noInv);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderDetailVM>.reactive(
        viewModelBuilder: () {
          return OrderDetailVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return SafeArea(
              child: Scaffold(
            body: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(margin16),
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
                            'Detil Transaksi',
                            style: mainBody4.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.noInv,
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
                  bloc: orderCubit,
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
                                orderCubit.fetchOrderDetail(context,
                                    noInv: widget.noInv);
                              }, title: 'Coba Lagi')
                            ],
                          ),
                        ));
                      } else {
                        if (service == 'hotel') {
                          return Expanded(
                              child: HotelDetailOrderSection(
                            data: OrderDetailHotelModel.fromJson(state.data),
                          ));
                        } else if (service == 'hostel') {
                          return Expanded(
                              child: HostelDetailOrderSection(
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
                            orderCubit.fetchOrderDetail(context,
                                noInv: widget.noInv);
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
