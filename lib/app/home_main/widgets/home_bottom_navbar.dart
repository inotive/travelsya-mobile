import 'package:flutter/material.dart';
import 'package:travelsya/app/home_main/widgets/bottom_navbar_widget.dart';
import 'package:travelsya/shared/helper/const_helper.dart';

class HomeBottomNavbar extends StatelessWidget {
  final Function(int) onTap;
  final int selectedIndex;
  const HomeBottomNavbar(
      {Key? key, required this.onTap, required this.selectedIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: const Color(0xffF4F4F4),
          child: Row(children: [
            BottomNavbarWidget(
              title: 'Home',
              isActive: selectedIndex == 0,
              iconsAsset: ConstHelper.homeIcon,
              onTap: () {
                onTap(0);
              },
            ),
            BottomNavbarWidget(
              title: 'Pesanan',
              isActive: selectedIndex == 1,
              iconsAsset: ConstHelper.orderIcon,
              onTap: () {
                onTap(1);
              },
            ),
            BottomNavbarWidget(
              title: 'Qris',
              isActive: selectedIndex == 99,
              showIcon: false,
              iconsAsset: ConstHelper.homeIcon,
              onTap: () {
                onTap(2);
              },
            ),
            BottomNavbarWidget(
              title: 'Point',
              isActive: selectedIndex == 3,
              iconsAsset: ConstHelper.pointIcon,
              onTap: () {
                onTap(3);
              },
            ),
            BottomNavbarWidget(
              title: 'Profile',
              isActive: selectedIndex == 4,
              iconsAsset: ConstHelper.profileIcon,
              onTap: () {
                onTap(4);
              },
            ),
          ]),
        ),
      ],
    );
  }
}
