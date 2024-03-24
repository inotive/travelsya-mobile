import 'package:flutter/material.dart';
import 'package:travelsya/app/order/models/order_detail_model.dart';
import 'package:travelsya/app/order/widgets/detail_order_split_data_widget.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class TopupDetailOrderSection extends StatelessWidget {
  final OrderDetailTopupModel data;
  const TopupDetailOrderSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              DetailOrderSplitDataWidget(
                title: 'Layanan',
                data: data.service.toUpperCase(),
              ),
              SizedBox(
                height: margin4,
              ),
              DetailOrderSplitDataWidget(
                title: 'Produk',
                data: data.product == null ? '-' : data.product!.description,
              ),
              SizedBox(
                height: margin4,
              ),
              data.service.toLowerCase() == 'listrik-token'
                  ? DetailOrderSplitDataWidget(
                      title: 'No Meter/IdPel',
                      data: data.noPhone,
                    )
                  : DetailOrderSplitDataWidget(
                      title: 'No Handphone',
                      data: data.noPhone,
                    ),
              data.voucherCode == null
                  ? Container()
                  : data.voucherCode!.isEmpty
                      ? Container()
                      : data.status.toLowerCase() == 'paid'
                          ? Container(
                              margin: EdgeInsets.only(top: margin16),
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  vertical: margin24, horizontal: margin24),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0xffF2F4FF)),
                              child: Column(
                                children: [
                                  Text(
                                    'Kode Voucher',
                                    style: mainBody4.copyWith(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: margin4,
                                  ),
                                  Text(
                                    data.voucherCode.toString(),
                                    style: mainBody4,
                                  ),
                                ],
                              ),
                            )
                          : Container()
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
                data: data.pointUsed == 0
                    ? '-'
                    : "-${moneyChanger(data.pointUsed, customLabel: '')}",
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
                                            '${moneyChanger(data.pointReceived, customLabel: '')} Poin ',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    const TextSpan(text: 'dari transaksi ini.'),
                                  ])),
                        ),
                        SizedBox(
                          height: margin16,
                        ),
                        FormHelper.elevatedButtonBasic(context,
                            enabled: true, onTap: () {}, title: 'Pesan Lagi'),
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
