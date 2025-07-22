import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class TopupPage extends StatelessWidget {
  const TopupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(margin16),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  width: margin24 / 2,
                ),
                Text(
                  'Topup E-Wallet',
                  style: mainFont.copyWith(
                      fontSize: 15,
                      color: neutral100,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(margin16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pilih Nominal',
                      style: mainFont.copyWith(
                          fontSize: 14,
                          color: neutral100,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: margin24 / 2,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        runSpacing: margin24 / 2,
                        children: List.generate(10, (index) {
                          return Stack(
                            children: [
                              Positioned(
                                top: 0,
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white),
                                  alignment: Alignment.topRight,
                                  child: SizedBox(
                                    width: 45,
                                    height: 45,
                                    child: Image.asset(
                                      'assets/icons/group_23.png',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.32,
                                child: Container(
                                  padding: EdgeInsets.all(margin24 / 2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: neutral30.withOpacity(0.3))),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '5,000',
                                        style: mainFont.copyWith(
                                            fontSize: 14,
                                            color: neutral100,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Bayar 6,000',
                                        style: mainFont.copyWith(
                                          fontSize: 11,
                                          color: neutral30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          );
                        }),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: margin16,
              ),
              Container(
                width: double.infinity,
                height: margin8,
                color: neutral10,
              ),
              Container(
                padding: EdgeInsets.all(margin16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Metode Pembayaran',
                      style: mainFont.copyWith(
                          fontSize: 15,
                          color: neutral100,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: FormHelper.optionsCircle(context,
                                title: 'Travelsya Pay',
                                isBold: true,
                                onTap: () {},
                                status: true,
                                customDetailWidget: Text(
                                  'Balance : Rp32,456',
                                  style: mainFont.copyWith(
                                      fontSize: 12, color: neutral100),
                                ))),
                        SizedBox(
                          width: margin24 / 2,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: margin8, horizontal: margin24 / 2),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xffffeef1)),
                          child: Text(
                            'Topup',
                            style: mainFont.copyWith(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: margin24 / 2,
                    ),
                    FormHelper.optionsCircle(context,
                        title: 'Metode Pembayaran Lain',
                        onTap: () {},
                        status: false)
                  ],
                ),
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.all(margin16),
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: ElevatedButtonWidget(
                enabled: true, onTap: () {}, title: 'Topup IDR 11,000'),
          )
        ],
      ),
    ));
  }
}
