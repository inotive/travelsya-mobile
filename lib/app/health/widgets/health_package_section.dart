import 'package:flutter/material.dart';
import 'package:travelsya/app/health/models/health_model.dart';
import 'package:travelsya/app/health/pages/health_checkout_page.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class HealthPackageSection extends StatelessWidget {
  final HealthDetailModel data;
  const HealthPackageSection({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xfff8f3f2),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.all(margin16),
            child: Text(
              'Paket',
              style: mainBody2.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(margin16),
            child: Column(
              children: List.generate(data.packages.length, (index) {
                HealthPackageModel pkg = data.packages[index];
                return Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(margin16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nama Paket
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                pkg.name,
                                style: mainBody4.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: margin16),

                        // Info package
                        Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset('assets/icons/refund.png'),
                                ),
                                SizedBox(width: margin8),
                                Expanded(
                                  child: Text(
                                    'Tidak bisa refund',
                                    style: mainBody5,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child:
                                      Image.asset('assets/icons/calendar.png'),
                                ),
                                SizedBox(width: margin8),
                                Expanded(
                                  child: Text(
                                    'Pesan tiket untuk hari ini',
                                    style: mainBody5,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset('assets/new/clock.png'),
                                ),
                                SizedBox(width: margin8),
                                Expanded(
                                  child: Text(
                                    'Berlaku hingga ${pkg.expiredDate} hari sejak dibeli',
                                    style: mainBody5,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Image.asset('assets/new/clock.png'),
                                ),
                                SizedBox(width: margin8),
                                Expanded(
                                  child: Text(
                                    'Reservasi paling lambat 1 hari sebelumnya',
                                    style: mainBody5,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: margin24),

                        // Harga & Button Pilih
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Harga sebelum diskon
                                // Text(
                                //   moneyChanger(pkg.unitPrice,
                                //       customLabel: 'IDR '),
                                //   style: mainBody5.copyWith(
                                //     color: const Color(0xffa5a5a5),
                                //     decorationColor: const Color(0xffa5a5a5),
                                //     decoration: TextDecoration.lineThrough,
                                //   ),
                                // ),
                                // SizedBox(height: margin4),
                                // Harga diskon
                                Text(
                                  moneyChanger(pkg.price, customLabel: 'IDR '),
                                  style: mainBody4.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              ],
                            ),

                            // Tombol Pilih Paket
                            GestureDetector(
                              onTap: () {
                                needLoginFeature(context, () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => HealthCheckoutPage(
                                        dataPackage: pkg,
                                        dataDetail: data,
                                        items: [
                                          CheckoutItem(
                                            package: pkg,
                                            quantity: 1,
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: margin8,
                                  horizontal: margin16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  'Pilih Paket',
                                  style: mainBody4.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
