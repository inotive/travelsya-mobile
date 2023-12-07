import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class PlaneCheckoutPage extends StatelessWidget {
  const PlaneCheckoutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(5.0.w),
              color: Theme.of(context).primaryColor,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 3.0.w,
                  ),
                  Text(
                    'Informasi Pemesanan',
                    style: mainFont.copyWith(
                        fontSize: 13.0.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          children: [
                            Text(
                              'Surabaya ke Jakarta',
                              style: mainFont.copyWith(
                                  fontSize: 13.0.sp,
                                  color: neutral100,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 3.0.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: neutral10),
                              child: Text(
                                'Pergi',
                                style: mainFont.copyWith(
                                    fontSize: 8.0.sp, color: neutral30),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.0.w,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 2.0.w, horizontal: 4.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: neutral10),
                        child: Row(
                          children: [
                            Container(
                                width: 4.0.w,
                                height: 4.0.w,
                                child: Image.asset('assets/icons/users.png')),
                            SizedBox(
                              width: 2.0.w,
                            ),
                            Expanded(
                                child: Text(
                              '2 Penumpang | Ekonomi',
                              style: mainFont.copyWith(
                                  fontSize: 10.0.sp, color: neutral100),
                            )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  color: Color(0xffFFF6F6),
                  child: Column(
                    children: List.generate(2, (index) {
                      return Container(
                        padding: EdgeInsets.all(3.0.w),
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          bottom: index == 0 ? 3.0.w : 0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: neutral10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 1.0.w, horizontal: 3.0.w),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: neutral10),
                              child: Text(
                                'Pergi',
                                style: mainFont.copyWith(
                                    fontSize: 9.0.sp, color: neutral30),
                              ),
                            ),
                            SizedBox(
                              height: 2.0.w,
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: 30.0.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '06.00',
                                          style: mainFont.copyWith(
                                              fontSize: 15.0.sp,
                                              color: neutral100,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Sen,  11 Feb 2023',
                                          style: mainFont.copyWith(
                                              fontSize: 10.0.sp,
                                              color: neutral100),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.0.w),
                                    height: double.infinity,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 2.0.w,
                                          height: 2.0.w,
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        Expanded(
                                            child: Container(
                                          width: 1,
                                          height: double.infinity,
                                          color: Theme.of(context).primaryColor,
                                        ))
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                      child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Lempuyangan',
                                        style: mainFont.copyWith(
                                            fontSize: 11.0.sp,
                                            color: neutral100,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 2.0.w,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(3.0.w),
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border:
                                                Border.all(color: neutral10)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'JAKA TINGKIR 257A\nEkonomi (Subclass C)',
                                              style: mainFont.copyWith(
                                                  fontSize: 9.0.sp,
                                                  color: neutral30),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.watch_later_outlined,
                                                  color: neutral30,
                                                  size: 4.0.w,
                                                ),
                                                SizedBox(
                                                  width: 1.0.w,
                                                ),
                                                Text(
                                                  '1j 45mnt',
                                                  style: mainFont.copyWith(
                                                      fontSize: 9.0.sp,
                                                      color: neutral30),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 2.0.w,
                                            ),
                                            Text(
                                              'Lihat fasilitas',
                                              style: mainFont.copyWith(
                                                  fontSize: 9.0.sp,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3.0.w,
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    constraints:
                                        BoxConstraints(maxWidth: 30.0.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '07:45',
                                          style: mainFont.copyWith(
                                              fontSize: 15.0.sp,
                                              color: neutral100,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Sen, 11 Feb 2023',
                                          style: mainFont.copyWith(
                                              fontSize: 10.0.sp,
                                              color: neutral100),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 2.5.w),
                                    child: Container(
                                      width: 2.0.w,
                                      height: 2.0.w,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ),
                                  Text(
                                    'Jatinegara',
                                    style: mainFont.copyWith(
                                        fontSize: 11.0.sp,
                                        color: neutral100,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Pemesan',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Sama dengan pemilik akun',
                          onTap: () {},
                          status: true),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 3.0.w),
                        width: double.infinity,
                        height: 1,
                        color: neutral30.withOpacity(0.3),
                      ),
                      Row(
                        children: [
                          FormHelper.optionsCircle(context,
                              title: 'Tuan', onTap: () {}, status: false),
                          SizedBox(
                            width: 3.0.w,
                          ),
                          FormHelper.optionsCircle(context,
                              title: 'Nyonya', onTap: () {}, status: false),
                        ],
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.titleWithWidget(
                          title: 'Nama Lengkap',
                          widget: FormHelper.roundedTextfield(context,
                              hintText: 'Masukkan nama lengkap Anda',
                              controller: TextEditingController())),
                      SizedBox(
                        height: 1.0.w,
                      ),
                      Text(
                        'Seperti di KTP/SIM/Paspor.',
                        style: mainFont.copyWith(
                            fontSize: 8.0.sp, color: neutral30),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.titleWithWidget(
                          title: 'Nomor Handphone',
                          widget: FormHelper.roundedTextfield(context,
                              prefixIcon: Center(
                                widthFactor: 1,
                                child: Text(
                                  '+62',
                                  style: mainFont.copyWith(
                                      fontSize: 11.0.sp, color: Colors.black87),
                                ),
                              ),
                              controller: TextEditingController())),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.titleWithWidget(
                          title: 'Email',
                          widget: FormHelper.roundedTextfield(context,
                              hintText: 'Masukkan email Anda',
                              controller: TextEditingController())),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2.0.w,
                  color: neutral10,
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detail Penampung',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 6.0.w,
                              height: 6.0.w,
                              child: Image.asset('assets/icons/users.png')),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text(
                            '0/3 Detail penumpang terisi',
                            style: mainFont.copyWith(
                                fontSize: 9.0.sp,
                                color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            width: 1.0.w,
                          ),
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).primaryColor,
                            size: 4.0.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.borderButton(context,
                          onTap: () {}, title: 'Lengkapi Detail Penumpang')
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 2.0.w,
                  color: neutral10,
                ),
                Container(
                  padding: EdgeInsets.all(5.0.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kursi Pesawat',
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5.0.w,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Pilih Secara Acak',
                          onTap: () {},
                          status: false),
                      SizedBox(
                        height: 2.0.w,
                      ),
                      FormHelper.optionsCircle(context,
                          title: 'Pilih sendiri kursi yang tersedia',
                          onTap: () {},
                          customDetailWidget: Row(
                            children: [
                              Text(
                                'Ekonomi 2 /3D ',
                                style: mainFont.copyWith(
                                    fontSize: 10.0.sp, color: neutral30),
                              ),
                              Text(
                                'Ganti Kursi',
                                style: mainFont.copyWith(
                                    fontSize: 10.0.sp,
                                    color: Theme.of(context).primaryColor,
                                    decoration: TextDecoration.underline),
                              )
                            ],
                          ),
                          status: true),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0.w,
                )
              ],
            )),
            Container(
              padding: EdgeInsets.all(5.0.w),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: neutral30.withOpacity(0.3)))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Biaya',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp, color: neutral100),
                      ),
                      Text(
                        'IDR 1,561,000',
                        style: mainFont.copyWith(
                            fontSize: 12.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.w,
                  ),
                  FormHelper.elevatedButtonBasic(context,
                      enabled: true,
                      onTap: () {},
                      title: 'Lanjutkan ke Pembayaran')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
