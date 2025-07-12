import 'package:flutter/material.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_checkout_page.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RekreasiPackageSection extends StatelessWidget {
  final List<RecreationPackageModel> data;
  final RecreationDetailModel dataDetail;
  const RekreasiPackageSection(
      {super.key, required this.data, required this.dataDetail});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding:
              EdgeInsets.only(top: margin16, left: margin16, right: margin16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Paket Tersedia',
                    style: mainBody4.copyWith(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                  // Text(
                  //   'Lihat Semua',
                  //   style: mainBody4.copyWith(
                  //       color: Theme.of(context).primaryColor,
                  //       fontWeight: FontWeight.bold),
                  // )
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: margin16,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            child: Column(
              children: List.generate(data.length, (index) {
                return Container(
                  padding: EdgeInsets.all(margin16),
                  margin: EdgeInsets.only(bottom: margin24 / 2),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: neutral50.withOpacity(0.3))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index].name,
                        style: mainBody4.copyWith(
                            color: neutral100, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${data[index].isRefundable == 1 ? 'Bisa' : 'Tidak Bisa'} refund dan ${data[index].isRescheduleable == 1 ? 'Bisa' : 'Tidak Bisa'} reschedule',
                        style: mainBody5.copyWith(color: neutral50),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: margin24 / 2),
                        width: double.infinity,
                        height: 1,
                        color: neutral50.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: RichText(
                                    text: TextSpan(
                                        style: mainBody5.copyWith(
                                            color: neutral50),
                                        children: [
                                      const TextSpan(text: 'mulai '),
                                      TextSpan(
                                          text: moneyChanger(data[index].price,
                                              customLabel: 'IDR '),
                                          style: mainBody4.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                    ])),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  '/orang (termasuk pajak)',
                                  style: mainBody5.copyWith(color: neutral50),
                                ),
                              )
                            ],
                          )),
                          SizedBox(
                            width: margin24 / 2,
                          ),
                          GestureDetector(
                            onTap: () {
                              needLoginFeature(context, () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => RekreasiCheckoutPage(
                                            package: data[index],
                                            data: dataDetail)));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: margin24 / 2, horizontal: margin16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                'Pesan',
                                style: mainBody4.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }),
            )),
        SizedBox(
          height: margin8,
        ),
        Container(
          width: double.infinity,
          height: margin8,
          color: const Color(0xfff4f4f4),
        ),
      ],
    );
  }
}
