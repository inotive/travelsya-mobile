import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/auth_cubit.dart';
import 'package:travelsya/app/auth/cubits/auth_state.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/profile/vm/profile_vm.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileVM>.reactive(
        viewModelBuilder: () {
          return ProfileVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    margin: const EdgeInsets.only(bottom: 30),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                'assets/images/rectangle_5636.png'))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocBuilder<AuthCubit, AuthState>(
                            bloc: BlocProvider.of<AuthCubit>(context),
                            builder: (context, state) {
                              return Column(
                                children: [
                                  state is AuthLoaded
                                      ? state.data.image == null
                                          ? const Icon(
                                              Icons.account_circle,
                                              size: 80,
                                              color: Colors.white,
                                            )
                                          : Container(
                                              width: 80,
                                              height: 80,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.white54,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      '$basePathUserUrl${state.data.image}'),
                                                ),
                                              ),
                                            )
                                      : const Icon(
                                          Icons.account_circle,
                                          size: 80,
                                          color: Colors.white,
                                        ),
                                  SizedBox(
                                    height: margin4,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: 'Hi, ',
                                        style: mainBody4.copyWith(
                                            color: Colors.white)),
                                    TextSpan(
                                        text: state is AuthLoaded
                                            ? state.data.name
                                            : '',
                                        style: mainBody4.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white))
                                  ])),
                                ],
                              );
                            })
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                          margin: EdgeInsets.symmetric(horizontal: margin16),
                          padding: EdgeInsets.all(margin16),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              border: Border.all(color: neutral10Stroke)),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child:
                                            Image.asset(ConstHelper.coinIcon),
                                      ),
                                      SizedBox(width: margin24 / 2),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Points Anda',
                                            style: mainBody4.copyWith(
                                                color: neutral100),
                                          ),
                                          BlocBuilder<PointCubit, PointState>(
                                              bloc: BlocProvider.of<PointCubit>(
                                                  context),
                                              builder: (context, stateProfile) {
                                                return stateProfile
                                                        is PointLoading
                                                    ? SizedBox(
                                                        width: 15,
                                                        height: 15,
                                                        child:
                                                            CircularProgressIndicator(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                        ))
                                                    : GestureDetector(
                                                        onTap: () {
                                                          if (stateProfile
                                                              is! PointLoaded) {
                                                            BlocProvider.of<
                                                                        PointCubit>(
                                                                    context)
                                                                .fetchPoint(
                                                                    context);
                                                          }
                                                        },
                                                        child: Text(
                                                          stateProfile
                                                                  is PointLoaded
                                                              ? moneyChanger(
                                                                  stateProfile
                                                                      .data
                                                                      .currentPoint
                                                                      .toDouble(),
                                                                  customLabel:
                                                                      '')
                                                              : 'Coba Lagi',
                                                          style: stateProfile
                                                                  is ProfileLoaded
                                                              ? mainBody4.copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      neutral100)
                                                              : mainBody5.copyWith(
                                                                  color: Theme.of(
                                                                          context)
                                                                      .primaryColor),
                                                        ),
                                                      );
                                              })
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: margin16),
                                  height: double.infinity,
                                  width: 1,
                                  color: neutral10Stroke,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child:
                                            Image.asset(ConstHelper.walletIcon),
                                      ),
                                      SizedBox(width: margin24 / 2),
                                      Expanded(
                                          child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Saldo Anda',
                                            style: mainBody4.copyWith(
                                                color: neutral100),
                                          ),
                                          BlocBuilder<ProfileCubit,
                                                  ProfileState>(
                                              bloc:
                                                  BlocProvider.of<ProfileCubit>(
                                                      context),
                                              builder: (context, state) {
                                                if (state is ProfileLoading) {
                                                  return SizedBox(
                                                    width: 15,
                                                    height: 15,
                                                    child:
                                                        CircularProgressIndicator(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor),
                                                  );
                                                } else {
                                                  return Text(
                                                    '0',
                                                    style: mainBody5.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Theme.of(context)
                                                            .primaryColor),
                                                  );
                                                }
                                              })
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                  )
                ],
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {
                  BlocProvider.of<ProfileCubit>(context).fetchProfile(context);
                },
                color: Theme.of(context).primaryColor,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: List.generate(model.dataMenu.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        model.onMenuTap(
                            context, int.parse(model.dataMenu[index]['id']!));
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: margin16),
                        margin: EdgeInsets.only(
                            top: index == 0 ? margin8 : 0,
                            bottom: index == model.dataMenu.length - 1
                                ? margin16
                                : 0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                model.dataMenu[index]['assets']!,
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(width: margin24 / 2),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: margin24 / 2),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: neutral10Stroke))),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      model.dataMenu[index]['title']!,
                                      style:
                                          mainBody4.copyWith(color: neutral90),
                                    )),
                                    SizedBox(width: margin24 / 2),
                                    const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15,
                                    ),
                                    SizedBox(
                                      width: margin16,
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ))
            ],
          );
        });
  }
}
