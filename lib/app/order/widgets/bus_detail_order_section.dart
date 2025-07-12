import 'package:flutter/material.dart';
import 'package:travelsya/app/order/models/order_detail_model.dart';
import 'package:travelsya/app/order/widgets/detail_order_split_data_widget.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class BusDetailOrderSection extends StatelessWidget {
  final BusDetailOrderModel data;
  const BusDetailOrderSection({super.key, required this.data});

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
                data: 'Bus & Travel',
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Nama Travel',
                data: data.travelName,
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Nama Bus',
                data: data.busName,
              ),
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
                data: data.createdAt == null
                    ? '-'
                    : '${dateToReadable(data.createdAt!.substring(0, 10))} ${data.createdAt!.substring(11, 16)}',
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
}
