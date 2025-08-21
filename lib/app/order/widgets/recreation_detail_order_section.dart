import 'package:flutter/material.dart';
import 'package:travelsya/app/order/models/order_detail_model.dart';
import 'package:travelsya/app/payment/pages/payment_webview_page.dart';
import 'package:travelsya/app/order/widgets/detail_order_split_data_widget.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_search_page.dart';
// import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RecreationDetailOrderSection extends StatelessWidget {
  final RecreationOrderDetailModel data;
  const RecreationDetailOrderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          padding:
              EdgeInsets.symmetric(vertical: margin24, horizontal: margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detail Produk',
                style: mainBody3.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin16,
              ),
              const DetailOrderSplitDataWidget(
                title: 'Layanan',
                data: 'Rekreasi',
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Nama Rekreasi',
                data: data.recreationName,
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Nama Paket',
                data: data.packageName,
              ),
              SizedBox(
                height: margin8,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: margin24 / 2, horizontal: margin16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).primaryColor.withOpacity(0.2)),
                child: Column(
                  children: [
                    Text(
                      'Tanggal Kadaluarsa',
                      style: mainBody5.copyWith(color: Colors.black87),
                    ),
                    Text(
                      data.expiredAt,
                      style: mainBody4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: margin8,
          color: neutral10Stroke.withOpacity(0.3),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(vertical: margin24, horizontal: margin16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rincian Pembayaran',
                style: mainBody3.copyWith(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: margin16,
              ),
              DetailOrderSplitDataWidget(
                title: 'Status Transaksi',
                data: '',
                customWidget: getTransactionLabel(data.status),
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Tanggal Transaksi',
                data: dateTimeToReadableLocal(data.createdAt),
                // data: data.createdAt == null
                //     ? '-'
                //     : '${dateToReadable(data.createdAt!.substring(0, 10))} ${data.createdAt!.substring(11, 16)}',
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Metode Pembayaran',
                data:
                    "${data.paymentMethod ?? '-'} ${data.paymentChannel == null ? '' : '- ${data.paymentChannel}'}",
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Biaya Admin',
                data: moneyChanger(data.adminFee),
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Poin Digunakan',
                data: data.poinUsed == 0
                    ? '-'
                    : "-${moneyChanger(data.poinUsed, customLabel: '')}",
                customDataStyle: mainBody5.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.red),
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Total Bayar',
                data: moneyChanger(data.total),
              ),
            ],
          ),
        ),
        Center(
          child: _getActionButton(context, data),
        ),
        Container(
          width: double.infinity,
          height: margin8,
          color: neutral10Stroke.withOpacity(0.3),
        ),
        Container(
          padding:
              EdgeInsets.symmetric(horizontal: margin16, vertical: margin24),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Biaya',
                    style: mainBody4,
                  ),
                  Text(
                    moneyChanger(data.total, customLabel: 'IDR'),
                    style: mainBody4.copyWith(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: margin16,
              ),
              data.status.toLowerCase() == 'paid'
                  ? Column(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                              vertical: margin8, horizontal: margin16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffDCF9DC).withOpacity(0.5)),
                          child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  style:
                                      mainBody5.copyWith(color: Colors.black87),
                                  children: [
                                    const TextSpan(text: 'Kamu dapat '),
                                    TextSpan(
                                        text:
                                            '${moneyChanger(data.poinReceived, customLabel: '')} Poin ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: 'dari transaksi ini.'),
                                  ])),
                        ),
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
        SizedBox(
          height: margin72,
        )
      ],
    );
  }


Widget _getActionButton(BuildContext context, RecreationOrderDetailModel data) {
    final status = data.status.toLowerCase();

    if (status == 'paid') {
      // Jika sudah bayar, arahkan ke BusSearchPage
      return GestureDetector(
        onTap: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    RekreasiSearchPage()), // <-- ganti sesuai import kamu
          );
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: margin16, vertical: margin8),
          padding:
              EdgeInsets.symmetric(vertical: margin16, horizontal: margin16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
          ),
          child: Text(
            'Pesan Lagi',
            textAlign: TextAlign.center,
            style: mainFont.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    } else if (status == 'pending') {
      // Jika pending, arahkan ke webview
      return GestureDetector(
        onTap: () {
          if (data.paymentLink != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UserPaymentWebview(
                  url: data.paymentLink!,
                ),
              ),
            );
          } else {
            Navigator.pop(context);
          }
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: margin16, vertical: margin8),
          padding:
              EdgeInsets.symmetric(vertical: margin16, horizontal: margin16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).primaryColor,
          ),
          child: Text(
            'Bayar',
            textAlign: TextAlign.center,
            style: mainFont.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return Container();
  }

  // Widget _getActionButton(
  //     BuildContext context, RecreationOrderDetailModel data) {
  //   if (data.status.toLowerCase() == 'paid' ||
  //       data.status.toLowerCase() == 'pending') {
  //     return GestureDetector(
  //       onTap: () {
  //         if (data.paymentLink != null) {
  //           Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (_) => UserPaymentWebview(
  //                 url: data.paymentLink!,
  //               ),
  //             ),
  //           );
  //         } else {
  //           Navigator.pop(context);
  //         }
  //       },
  //       child: Container(
  //         width: double.infinity,
  //         margin: EdgeInsets.symmetric(horizontal: margin16, vertical: margin8),
  //         padding:
  //             EdgeInsets.symmetric(vertical: margin16, horizontal: margin16),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           color: Theme.of(context).primaryColor,
  //         ),
  //         child: Text(
  //           data.status.toLowerCase() == 'paid' ? 'Pesan Lagi' : 'Bayar',
  //           textAlign: TextAlign.center,
  //           style: mainFont.copyWith(
  //             fontSize: 14,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.white,
  //           ),
  //         ),
  //       ),
  //     );
  //   }

  //   return Container();
  // }
}
