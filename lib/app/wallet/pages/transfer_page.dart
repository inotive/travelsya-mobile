import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5.0.w),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: Column(
              children: [
                Row(
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
                      width: 3.0.w,
                    ),
                    Text(
                      'Transfer Bank',
                      style: mainFont.copyWith(
                          fontSize: 13.0.sp,
                          color: neutral100,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 3.0.w,
                ),
                Container(
                  child: FormHelper.roundedTextfield(context,
                      controller: TextEditingController(),
                      hintText: 'Cari nama rekening',
                      suffixWidget: Icon(Icons.search)),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
                  children: List.generate(5, (index) {
            return Container(
              padding: EdgeInsets.all(5.0.w),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
              child: Row(
                children: [
                  SizedBox(
                    width: 15.0.w,
                    child: Image.asset('assets/icons/image 16.png'),
                  ),
                  SizedBox(
                    width: 3.0.w,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: mainFont.copyWith(
                            fontSize: 11.0.sp,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'BCA - 5271 2351 214',
                        style: mainFont.copyWith(
                            fontSize: 9.0.sp, color: neutral30),
                      )
                    ],
                  )),
                  SizedBox(
                    width: 3.0.w,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: neutral30,
                    size: 4.0.w,
                  )
                ],
              ),
            );
          }))),
          Container(
            padding: EdgeInsets.all(5.0.w),
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: FormHelper.elevatedButtonBasic(context,
                enabled: true, onTap: () {}, title: 'Tambah Rekening Baru'),
          )
        ],
      ),
    ));
  }
}
