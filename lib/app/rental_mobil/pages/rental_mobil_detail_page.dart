import 'package:flutter/material.dart';
import 'package:travelsya/app/rental_mobil/widgets/rental_option_dialog.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RentalDetailPage extends StatefulWidget {
  const RentalDetailPage({super.key});

  @override
  State<RentalDetailPage> createState() => _RentalDetailPageState();
}

class _RentalDetailPageState extends State<RentalDetailPage> {
  List<String> filterData = ['Semua', 'Otomatis', 'Manual'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(margin16),
            color: Theme.of(context).primaryColor,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: margin24 / 2,
                ),
                Text(
                  'Rental di Jakarta',
                  style: mainBody3.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(margin16),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(color: neutral50.withOpacity(0.3)))),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: margin8,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: neutral10),
                  child: Row(
                    children: [
                      Icon(Icons.date_range, color: neutral50, size: 20),
                      SizedBox(
                        width: margin8,
                      ),
                      Expanded(
                          child: Text(
                        '19 Feb 2023 | 1 Hari | Lepas Kunci',
                        style: mainBody4.copyWith(color: neutral100),
                      )),
                      SizedBox(
                        width: margin8,
                      ),
                      Text(
                        'Ubah',
                        style: mainBody5.copyWith(
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
              padding: EdgeInsets.symmetric(vertical: margin16),
              child: Row(
                  children: List.generate(filterData.length, (index) {
                return Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? margin16 : margin4,
                      right: index == 9 ? margin16 : 0),
                  padding: EdgeInsets.symmetric(
                      vertical: margin4, horizontal: margin16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: index == 0
                          ? const Color(0xffFFEEF1)
                          : Colors.transparent,
                      border: Border.all(
                          color: index == 0
                              ? Theme.of(context).primaryColor
                              : const Color(0xffA5A5A5))),
                  child: Text(
                    filterData[index],
                    style: mainBody5.copyWith(
                        color: index == 0
                            ? Theme.of(context).primaryColor
                            : const Color(0xffA5A5A5)),
                  ),
                );
              }))),
          Expanded(
              child: Container(
            color: Colors.white,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: margin16),
              children: List.generate(5, (index) {
                return GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10))),
                          backgroundColor: Colors.transparent,
                          constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height * 0.7,
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.7),
                          builder: (context) {
                            return const RentalOptionDialog();
                          });
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          bottom: index == 4 ? margin32 : 0,
                          top: index == 0 ? margin16 : margin24 / 2),
                      padding: EdgeInsets.all(margin16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: neutral40)),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Toyota Grand New Avanza',
                                style: mainBody4.copyWith(
                                    color: neutral100,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: margin8,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                      width: margin16,
                                      height: margin16,
                                      child: Image.asset(
                                          'assets/icons/users.png')),
                                  SizedBox(
                                    width: margin4,
                                  ),
                                  Text(
                                    '6 Orang',
                                    style: mainBody4.copyWith(color: neutral50),
                                  ),
                                  SizedBox(
                                    width: margin24 / 2,
                                  ),
                                  SizedBox(
                                      width: margin16,
                                      height: margin16,
                                      child: Image.asset(
                                          'assets/icons/users.png')),
                                  SizedBox(
                                    width: margin4,
                                  ),
                                  Text(
                                    'Otomatis',
                                    style: mainBody5.copyWith(color: neutral50),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: margin24 / 2,
                              ),
                              Text(
                                'mulai dari',
                                style: mainBody5.copyWith(color: neutral50),
                              ),
                              Row(
                                children: [
                                  Text(
                                    'IDR 400,500',
                                    style: mainBody3.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    ' /hari',
                                    style: mainBody4.copyWith(color: neutral50),
                                  )
                                ],
                              )
                            ],
                          )),
                          SizedBox(
                            width: margin24 / 2,
                          ),
                          SizedBox(
                            width: 60,
                            height: 60,
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
