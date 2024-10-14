import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/order/cubits/order_cubit.dart';
import 'package:travelsya/app/order/cubits/order_state.dart';
import 'package:travelsya/app/order/models/order_list_model.dart';
import 'package:travelsya/app/order/pages/order_detail_page.dart';
import 'package:travelsya/app/order/vm/order_list_vm.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';

class OrderListPage extends StatefulWidget {
  const OrderListPage({super.key});

  @override
  State<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {
  List<String> filterData = ['Semua', 'Pesanan Aktif', 'Riwayat'];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OrderListVM>.reactive(viewModelBuilder: () {
      return OrderListVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
        appBar: appbarBasicWidget(context, title: 'Pesanan Anda'),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: margin24 / 2),
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(filterData.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        model.onFilterChanged(index);
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            left: index == 0 ? margin24 / 2 : margin4,
                            right: index == filterData.length - 1
                                ? margin24 / 2
                                : 0),
                        padding: EdgeInsets.symmetric(
                            vertical: margin4, horizontal: margin16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: index == model.selectedFilter
                                ? const Color(0xffFFEEF1)
                                : Colors.transparent,
                            border: Border.all(
                                color: index == model.selectedFilter
                                    ? Theme.of(context).primaryColor
                                    : const Color(0xffA5A5A5))),
                        child: Text(
                          filterData[index],
                          style: mainFont.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: index == model.selectedFilter
                                  ? Theme.of(context).primaryColor
                                  : const Color(0xffA5A5A5)),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
                child: BlocBuilder<OrderCubit, OrderState>(
                    bloc: model.orderCubit,
                    builder: (context, state) {
                      if (state is ListOrderLoaded) {
                        return model.dataAfterFilter(state.data).isEmpty
                            ? Container(
                                width: double.infinity,
                                margin:
                                    EdgeInsets.symmetric(vertical: margin16),
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
                                      'Data Kosong',
                                      style: mainBody3.copyWith(
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: margin4,
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: margin32),
                                      child: Text(
                                        'Data Tidak Ditemukan, Silahkan melakukan pemesanan',
                                        textAlign: TextAlign.center,
                                        style: mainBody4.copyWith(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : RefreshIndicator(
                                onRefresh: () async {
                                  model.onInit(context);
                                },
                                color: Theme.of(context).primaryColor,
                                child: ListView(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: margin16),
                                  children: List.generate(
                                      model.dataAfterFilter(state.data).length,
                                      (index) {
                                    OrderList data = model
                                        .dataAfterFilter(state.data)[index];

                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => OrderDetailPage(
                                                      noInv: data.noInv,
                                                    )));
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: index == 0 ? margin8 : 0,
                                            bottom: index ==
                                                    model
                                                            .dataAfterFilter(
                                                                state.data)
                                                            .length -
                                                        1
                                                ? margin40
                                                : margin24 / 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: margin24 / 2,
                                                  horizontal: margin16),
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color:
                                                              Colors.black12))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    data.service.toUpperCase(),
                                                    style: mainFont.copyWith(
                                                        fontSize: 13,
                                                        color: Colors.black54),
                                                  ),
                                                  getTransactionLabel(
                                                      data.status),
                                                ],
                                              ),
                                            ),
                                            Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  right: 0,
                                                  child: SizedBox(
                                                    width: 50,
                                                    height: 50,
                                                    child: Image.asset(
                                                      'assets/icons/Group 23.png',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: margin16,
                                                      horizontal: margin16),
                                                  child: Row(children: [
                                                    SizedBox(
                                                      width: 30,
                                                      height: 30,
                                                      child: Image.asset(model
                                                          .getPreviewAsset(data
                                                              .service
                                                              .toUpperCase())),
                                                    ),
                                                    SizedBox(
                                                      width: margin24 / 2,
                                                    ),
                                                    Expanded(
                                                        child: model
                                                            .getDetailWidget(
                                                                context, data)),
                                                    SizedBox(
                                                      width: margin24 / 2,
                                                    ),
                                                    const Icon(
                                                      Icons
                                                          .arrow_forward_ios_rounded,
                                                      size: 15,
                                                      color: Colors.black87,
                                                    )
                                                  ]),
                                                )
                                              ],
                                            ),
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: margin24 / 2,
                                                  horizontal: margin16),
                                              decoration: const BoxDecoration(
                                                  border: Border(
                                                      top: BorderSide(
                                                          color:
                                                              Colors.black12))),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${dateToReadable(data.createdAt.substring(0, 10))} ${data.createdAt.substring(11, 19)}',
                                                        style:
                                                            mainFont.copyWith(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black54),
                                                      ),
                                                      Text(
                                                        moneyChanger(
                                                            data.total),
                                                        style: mainFont.copyWith(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                      )
                                                    ],
                                                  )),
                                                  model.getActionButton(
                                                      context, data),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                      } else if (state is OrderLoading) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: margin16),
                          child: FailedRequestWidget(
                            onRetry: () {
                              model.onInit(context);
                            },
                          ),
                        );
                      }
                    }))
          ],
        ),
      ));
    });
  }
}
