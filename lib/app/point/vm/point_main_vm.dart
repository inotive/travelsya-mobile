import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/point/pages/point_history_section.dart';
import 'package:travelsya/app/point/pages/redeem_section.dart';
import 'package:travelsya/shared/styles/font_style.dart';

class PointMainVM extends BaseViewModel {
  List<String> filterData = ['Redeem', 'Riwayat'];
  int selectedIndex = 0;
  List<Widget> listPointWidget = [
    const RedeemSection(),
    const PointHistorySection()
  ];

  onChangeIndex(int value) {
    selectedIndex = value;
    notifyListeners();
  }

  Widget getProfileInfoWidget(BuildContext context, ProfileState state) {
    if (state is ProfileLoading) {
      return Center(
        child: SizedBox(
          width: 25,
          height: 25,
          child:
              CircularProgressIndicator(color: Theme.of(context).primaryColor),
        ),
      );
    } else if (state is ProfileLoaded) {
      return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.data.user.name,
              style: mainBody5.copyWith(
                  color: Colors.black87, fontWeight: FontWeight.bold),
            ),
            Text(
              'Phone Number: ${state.data.user.phone ?? '-'}',
              style: mainBody5.copyWith(
                color: Colors.black54,
              ),
            )
          ],
        ),
      );
    } else {
      return GestureDetector(
          onTap: () {
            BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
          },
          child: Center(
              child: Text(
            'Coba Lagi',
            style: mainBody4.copyWith(color: Theme.of(context).primaryColor),
          )));
    }
  }
}
