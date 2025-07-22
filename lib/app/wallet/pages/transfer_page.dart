import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(margin16),
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
                      width: margin24 / 2,
                    ),
                    Text(
                      'Transfer Bank',
                      style: mainFont.copyWith(
                          fontSize: 15,
                          color: neutral100,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: margin24 / 2,
                ),
                SizedBox(
                  child: RoundedTextfield(
                      controller: TextEditingController(),
                      hintText: 'Cari nama rekening',
                      suffixWidget: const Icon(Icons.search)),
                ),
              ],
            ),
          ),
          Expanded(
              child: ListView(
                  children: List.generate(5, (index) {
            return Container(
              padding: EdgeInsets.all(margin16),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: neutral30.withOpacity(0.3)))),
              child: Row(
                children: [
                  SizedBox(
                    width: 45,
                    child: Image.asset('assets/icons/image_16.png'),
                  ),
                  SizedBox(
                    width: margin24 / 2,
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: mainFont.copyWith(
                            fontSize: 13,
                            color: neutral100,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'BCA - 5271 2351 214',
                        style:
                            mainFont.copyWith(fontSize: 11, color: neutral30),
                      )
                    ],
                  )),
                  SizedBox(
                    width: margin24 / 2,
                  ),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: neutral30,
                    size: 15,
                  )
                ],
              ),
            );
          }))),
          Container(
            padding: EdgeInsets.all(margin16),
            decoration: BoxDecoration(
                border:
                    Border(top: BorderSide(color: neutral30.withOpacity(0.3)))),
            child: ElevatedButtonWidget(
                enabled: true, onTap: () {}, title: 'Tambah Rekening Baru'),
          )
        ],
      ),
    ));
  }
}
