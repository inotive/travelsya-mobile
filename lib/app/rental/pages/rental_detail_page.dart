import 'package:flutter/material.dart';
import 'package:travelsya/app/bus/pages/bus_checkout_page.dart';
import 'package:travelsya/app/ka/pages/ka_checkout_page.dart';
import 'package:travelsya/app/plane/pages/plane_checkout_page.dart';
import 'package:travelsya/app/rental/widgets/rental_option_dialog.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:sizer/sizer.dart';

class RentalDetailPage extends StatefulWidget {
  const RentalDetailPage({Key? key}) : super(key: key);

  @override
  State<RentalDetailPage> createState() => _RentalDetailPageState();
}

class _RentalDetailPageState extends State<RentalDetailPage> {
  List<String> filterData = ['Semua', 'Otomatis', 'Manual'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xfff5f5f5),
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
                  'Rental di Jakarta',
                  style: mainFont.copyWith(
                      fontSize: 13.0.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(5.0.w),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 2.0.w, horizontal: 4.0.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: neutral10),
                  child: Row(
                    children: [
                      Container(
                          width: 4.0.w,
                          height: 4.0.w,
                          child: Icon(Icons.date_range,
                              color: neutral30, size: 4.0.w)),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Expanded(
                          child: Text(
                        '19 Feb 2023 | 1 Hari | Lepas Kunci',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp, color: neutral100),
                      )),
                      SizedBox(
                        width: 2.0.w,
                      ),
                      Text(
                        'Ubah',
                        style: mainFont.copyWith(
                            fontSize: 10.0.sp,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.symmetric(vertical: 4.0.w),
              child: Row(
                  children: List.generate(filterData.length, (index) {
                return Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? 5.0.w : 1.0.w,
                      right: index == 9 ? 5.0.w : 0),
                  padding:
                      EdgeInsets.symmetric(vertical: 1.0.w, horizontal: 5.0.w),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:
                          index == 0 ? Color(0xffFFEEF1) : Colors.transparent,
                      border: Border.all(
                          color: index == 0
                              ? Theme.of(context).primaryColor
                              : Color(0xffA5A5A5))),
                  child: Text(
                    filterData[index],
                    style: mainFont.copyWith(
                        fontSize: 10.0.sp,
                        color: index == 0
                            ? Theme.of(context).primaryColor
                            : Color(0xffA5A5A5)),
                  ),
                );
              }))),
          Expanded(
              child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 5.0.w),
              children: List.generate(5, (index) {
                return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          backgroundColor: Colors.transparent,
                          constraints: BoxConstraints(
                              minHeight: 70.0.h, maxHeight: 70.0.h),
                          builder: (context) {
                            return RentalOptionDialog();
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: index == 0 ? 5.0.w : 3.0.w),
                      padding: EdgeInsets.all(5.0.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: neutral10)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Toyota Grand New Avanza',
                                style: mainFont.copyWith(
                                    fontSize: 11.0.sp,
                                    color: neutral100,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 2.0.w,
                              ),
                              Row(
                                children: [
                                  Container(
                                      width: 5.0.w,
                                      height: 5.0.w,
                                      child: Image.asset(
                                          'assets/icons/users.png')),
                                  SizedBox(
                                    width: 1.0.w,
                                  ),
                                  Text(
                                    '6 Orang',
                                    style: mainFont.copyWith(
                                        fontSize: 10.0.sp, color: neutral30),
                                  ),
                                  SizedBox(
                                    width: 3.0.w,
                                  ),
                                  Container(
                                      width: 5.0.w,
                                      height: 5.0.w,
                                      child: Image.asset(
                                          'assets/icons/users.png')),
                                  SizedBox(
                                    width: 1.0.w,
                                  ),
                                  Text(
                                    'Otomatis',
                                    style: mainFont.copyWith(
                                        fontSize: 10.0.sp, color: neutral30),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 3.0.w,
                              ),
                              Text(
                                'mulai dari',
                                style: mainFont.copyWith(
                                    fontSize: 9.0.sp, color: neutral30),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'IDR 400,500',
                                    style: mainFont.copyWith(
                                        fontSize: 13.0.sp,
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' /hari',
                                    style: mainFont.copyWith(
                                        fontSize: 9.0.sp, color: neutral30),
                                  )
                                ],
                              )
                            ],
                          )),
                          SizedBox(
                            width: 3.0.w,
                          ),
                          Container(
                            width: 20.0.w,
                            height: 20.0.w,
                            child: Image.asset(
                                'assets/images/xenia miring depan 1.png'),
                          )
                        ],
                      ),
                    ));
              }),
            ),
          )),
        ],
      ),
    ));
  }
}
