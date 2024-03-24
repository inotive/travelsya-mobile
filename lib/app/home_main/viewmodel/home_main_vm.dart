import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/homepage/pages/home_page.dart';
import 'package:travelsya/app/order/pages/order_list_page.dart';
import 'package:travelsya/app/point/pages/point_main_page.dart';
import 'package:travelsya/app/profile/pages/profile_page.dart';
import 'package:travelsya/shared/cubits/main_index_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';

class HomeMainVM extends BaseViewModel {
  List<Widget> dataScreen = [
    const HomePage(),
    const OrderListPage(),
    Container(),
    const PointMainPage(),
    const ProfilePage(),
  ];

  onBottomNavBarTap(BuildContext context, int value) {
    needLoginFeature(context, () {
      BlocProvider.of<MainIndexCubit>(context).changeIndex(value);
      if (value == 4) {
        BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
        BlocProvider.of<PointCubit>(context).fetchPoint(context);
      }
      notifyListeners();
    });
  }

  onQrisTap(BuildContext context) {
    needLoginFeature(context, () {
      showSnackbar(context,
          data: 'Coming Soon', colors: Theme.of(context).primaryColor);
      // Navigator.push(
      //     context, MaterialPageRoute(builder: (_) => const QRISPage()));
    });
  }
}
