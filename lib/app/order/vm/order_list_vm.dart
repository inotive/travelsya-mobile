import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/pages/hostel_search_page/hostel_search_page.dart';
import 'package:travelsya/app/hotel/pages/hotel_search/hotel_search_page.dart';
import 'package:travelsya/app/order/cubits/order_cubit.dart';
import 'package:travelsya/app/order/models/order_list_model.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/pages/bpjs/bpjs_kesehatan_main_page.dart';
import 'package:travelsya/app/ppob/pages/ewallet/ewallet_main_page.dart';
import 'package:travelsya/app/ppob/pages/pajak/pajak_main_page.dart';
import 'package:travelsya/app/ppob/pages/pdam/pdam_main_page.dart';
import 'package:travelsya/app/ppob/pages/pln/pln_main_page.dart';
import 'package:travelsya/app/ppob/pages/pulsa/pulsa_form_page.dart';
import 'package:travelsya/app/ppob/pages/tv_berbayar/tv_berbayar_main_page.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class OrderListVM extends BaseViewModel {
  OrderCubit orderCubit = OrderCubit();
  int selectedFilter = 0;

  String getPreviewAsset(String service) {
    if (service == 'BPJS') {
      return 'assets/icons/user_protection_1.png';
    } else if (service == 'HOTEL') {
      return 'assets/icons/surface_1.png';
    } else if (service == 'HOSTEL') {
      return 'assets/icons/bank_1.png';
    } else if (service == 'PLN') {
      return 'assets/icons/light_bulb.png';
    } else if (service == 'PDAM') {
      return 'assets/icons/icon_pdam.png';
    } else if (service.contains('PULSA')) {
      return 'assets/icons/icon_pulsa.png';
    } else if (service.contains('TV')) {
      return 'assets/icons/icon_tv.png';
    } else if (service == 'PAJAK') {
      return 'assets/icons/icon_tax.png';
    } else if (service == 'DATA') {
      return 'assets/icons/icon_pulsa.png';
    } else if (service == 'EWALLET') {
      return 'assets/icons/icon_ewallet.png';
    } else if (service == 'LISTRIK-TOKEN') {
      return 'assets/icons/light_bulb.png';
    } else if (service == 'RECREATION') {
      return 'assets/icons/icon_rekreasi.png';
    } else if (service == 'CAR-RENT') {
      return 'assets/icons/sport_car_1.png';
    } else if (service == 'HEALTH-BEAUTY') {
      return 'assets/icons/group_6.png';
    } else if (service == 'BUS-TRAVEL') {
      return ConstHelper.busIcon;
    }

    return 'assets/icons/invoice.png';
  }

  List<OrderList> dataAfterFilter(List<OrderList> data) {
    List<OrderList> dataFinal = [];

    for (var element in data) {
      if (selectedFilter == 0) {
        dataFinal.add(element);
      } else if (selectedFilter == 1) {
        if (element.status == 'PENDING') {
          dataFinal.add(element);
        }
      } else if (selectedFilter == 2) {
        if (element.status != 'PENDING') {
          dataFinal.add(element);
        }
      }
    }

    return dataFinal;
  }

  onFilterChanged(int val) {
    selectedFilter = val;
    notifyListeners();
  }

  onInit(BuildContext context) {
    orderCubit.fetchOrderData(context);
  }

  String getPPOBFromProductName(BuildContext context, String service) {
    PPOBState state = BlocProvider.of<PPOBCubit>(context).state;
    if (state is PPOBLoaded) {
      for (var i = 0; i < state.data.allData.length; i++) {
        if (state.data.allData[i].operator == service) {
          return state.data.allData[i].description;
        }
      }
    }

    return '';
  }

  Widget getDetailWidget(BuildContext context, OrderList data) {
    String service = data.service.toLowerCase();

    if (data.detailTransaction != null) {
      if (service == 'hotel') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hotel',
              style: mainBody5,
            ),
            Text(
              data.detailTransaction!['hotel_name'] ?? '-',
              style: mainBody4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: margin4,
            ),
            Text(
              '${data.detailTransaction!['room_type'] ?? '-'} ${data.detailTransaction!['reservation_duration'] == null ? '' : ' (${data.detailTransaction!['reservation_duration']} Hari'})',
              style: mainBody5.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        );
      } else if (service == 'hostel') {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hostel',
              style: mainBody5,
            ),
            Text(
              data.detailTransaction!['hostel_name'] ?? '-',
              style: mainBody4.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            SizedBox(
              height: margin4,
            ),
            Text(
              '${data.detailTransaction!['room_type'] ?? '-'}',
              style: mainBody5.copyWith(fontWeight: FontWeight.bold),
            )
          ],
        );
      } else if (service == 'bpjs') {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'BPJS',
            style: mainBody5,
          ),
          Text(
            data.detailTransaction!['customer_number'],
            style: mainBody5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ]);
      } else if (service == 'pln') {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'PLN Pascabayar',
            style: mainBody5,
          ),
          Text(
            data.detailTransaction!['customer_number'],
            style: mainBody5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
        ]);
      } else if (service == 'listrik-token') {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'PLN Token',
            style: mainBody5,
          ),
          Text(
            data.detailTransaction!['phone_number'],
            style: mainBody5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: margin8,
          ),
          Text(
            getPPOBFromProductName(
                context, data.detailTransaction!['product_name']),
            style: mainBody5.copyWith(
                fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ]);
      } else if (service == 'pulsa') {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Pulsa',
            style: mainBody5,
          ),
          Text(
            data.detailTransaction!['product_name'],
            style: mainBody5.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
          ),
          SizedBox(
            height: margin4,
          ),
          Text(
            data.detailTransaction!['phone_number'],
            style: mainBody5,
          )
        ]);
      } else if (service == 'data') {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Data',
            style: mainBody5,
          ),
        ]);
      } else if (service == 'ewallet') {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            data.detailTransaction!['product_name'],
            style: mainBody4.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            data.detailTransaction!['phone_number'],
            style: mainBody5.copyWith(color: Theme.of(context).primaryColor),
          )
        ]);
      }
    } else {
      if (service == 'pln') {
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'PLN Token',
            style: mainBody5,
          ),
        ]);
      }
    }

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        data.service.toUpperCase(),
        style: mainBody5.copyWith(fontWeight: FontWeight.bold),
      )
    ]);
  }

  String getProductFromId(
    BuildContext context,
    OrderList data,
  ) {
    String returnValue = '-';

    // if (data.service == 'ppob') {
    //   PPOBState state = BlocProvider.of<PPOBCubit>(context).state;

    //   if (state is PPOBLoaded) {
    //     state.data.allData.forEach((element) {
    //       if (element.id == data.dataTransaction[0]['product_id']) {
    //         returnValue = element.description;
    //       }
    //     });
    //   }
    // } else if (data.service == 'hostel') {
    //   if (data.dataTransaction.isNotEmpty) {
    //     try {
    //       returnValue = data.dataTransaction[0]['hostel_room']['name'];
    //     } catch (e) {}
    //   }
    // }

    return returnValue;
  }

  getActionButton(BuildContext context, OrderList data) {
    if (data.status.toLowerCase() == 'paid' ||
        data.status.toLowerCase() == 'pending') {
      return GestureDetector(
        onTap: () {
          if (data.status.toLowerCase() == 'pending') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => UserPaymentWebview(
                          url: data.link,
                        )));
          } else {
            if (data.service.toLowerCase() == 'bpjs') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => BPJSKesehatanMainPage(
                            preloadNumber:
                                data.detailTransaction!['customer_number'],
                          )));
            } else if (data.service.toLowerCase() == 'pdam') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PDAMMainPage(
                            preloadNumber:
                                data.detailTransaction!['customer_number'],
                          )));
            } else if (data.service.toLowerCase() == 'pln') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PLNMainPage(
                            preloadNumber:
                                data.detailTransaction!['customer_number'],
                            selectedIndex: 1,
                          )));
            } else if (data.service.toLowerCase() == 'listrik-token') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PLNMainPage(
                            preloadNumber:
                                data.detailTransaction!['phone_number'],
                          )));
            } else if (data.service.toLowerCase() == 'ewallet') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => EwalletMainPage(
                            preloadNumber:
                                data.detailTransaction!['phone_number'],
                          )));
            } else if (data.service.toLowerCase() == 'pulsa') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PulsaFormPage(
                            preloadNumber:
                                data.detailTransaction!['phone_number'],
                          )));
            } else if (data.service.toLowerCase().contains('tv')) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TVBerbayarMainPage(
                            preloadNumber:
                                data.detailTransaction!['customer_number'],
                          )));
            } else if (data.service.toLowerCase() == 'pajak') {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => PajakMainPage(
                            preloadNumber:
                                data.detailTransaction!['customer_number'],
                          )));
            } else if (data.service.toLowerCase() == 'hotel') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HotelSearchPage()));
            } else if (data.service.toLowerCase() == 'hostel') {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const HostelSearchPage()));
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: margin24 / 2),
          padding:
              EdgeInsets.symmetric(vertical: margin8, horizontal: margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor),
          child: Text(
            data.status.toLowerCase() == 'paid' ? 'Pesan Lagi' : 'Bayar',
            style: mainFont.copyWith(fontSize: 11, color: Colors.white),
          ),
        ),
      );
    }

    return Container();
  }
}
