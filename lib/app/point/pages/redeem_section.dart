import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/homepage/vm/beranda_vm.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RedeemSection extends StatefulWidget {
  const RedeemSection({Key? key}) : super(key: key);

  @override
  State<RedeemSection> createState() => _RedeemSectionState();
}

class _RedeemSectionState extends State<RedeemSection> {
  List<Map<String, dynamic>> dataMenu = [
    {'title': 'Hotel', 'assets': ConstHelper.hotelIcon, 'id': 1},
    {'title': 'Pesawat', 'assets': ConstHelper.planeIcon, 'id': 2},
    {'title': 'Kereta Api', 'assets': ConstHelper.kaIcon, 'id': 3},
    {'title': 'Bus & Travel', 'assets': ConstHelper.busIcon, 'id': 4},
    {'title': 'Rekreasi', 'assets': ConstHelper.rekreasiIcon, 'id': 5},
    {'title': 'Rental Mobil', 'assets': ConstHelper.carIcon, 'id': 6},
    {'title': 'Hostel', 'assets': ConstHelper.hostelIcon, 'id': 7},
    {'title': 'Health & Beauty', 'assets': ConstHelper.healthIcon, 'id': 8},
    {'title': 'PLN', 'assets': ConstHelper.plnIcon, 'id': 9},
    {'title': 'BPJS', 'assets': ConstHelper.bpjsIcon, 'id': 10},
    {'title': 'PDAM', 'assets': ConstHelper.pdamIcon, 'id': 11},
    {'title': 'Transfer Bank', 'assets': ConstHelper.transferIcon, 'id': 12},
    {'title': 'E-Wallet', 'assets': ConstHelper.ewalletIcon, 'id': 13},
    {'title': 'Pulsa & Data', 'assets': ConstHelper.pulsaIcon, 'id': 14},
    {'title': 'TV Berbayar', 'assets': ConstHelper.tvIcon, 'id': 15},
    {'title': 'Pajak', 'assets': ConstHelper.taxIcon, 'id': 16},
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
        BlocProvider.of<PointCubit>(context).fetchPoint(context);
      },
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            child: Text(
              'Redeem Poinmu Sekarang!',
              style: mainBody4.copyWith(
                  color: Colors.black87, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            child: Text(
              'Poin Anda akan mencapai kadaluwarsa pada 31 Mei 2023. Ayo gunakan segera!',
              style: mainBody5.copyWith(color: neutral70),
            ),
          ),
          Column(
            children: List.generate(dataMenu.length, (index) {
              return GestureDetector(
                onTap: () {
                  BerandaVM berandaVM = BerandaVM();
                  berandaVM.onMainMenuTap(context, dataMenu[index]['id']);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: margin16, horizontal: margin16),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: neutral10Stroke, width: 0.5))),
                  child: Row(
                    children: [
                      Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xfff3f3f3)),
                          child: SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset(dataMenu[index]['assets']))),
                      SizedBox(
                        width: margin24 / 2,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dataMenu[index]['title'],
                            style: mainBody3.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Pesan Sekarang',
                            style: mainBody5.copyWith(
                                color: Theme.of(context).primaryColor),
                          )
                        ],
                      )),
                      SizedBox(
                        width: margin16,
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: neutral10Stroke,
                        size: 20,
                      )
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}
