import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/point/vm/point_main_vm.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class PointMainPage extends StatelessWidget {
  const PointMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PointMainVM>.reactive(
        viewModelBuilder: () {
          return PointMainVM();
        },
        onViewModelReady: (model) {},
        builder: (context, model, child) {
          return BlocBuilder<ProfileCubit, ProfileState>(
              bloc: BlocProvider.of<ProfileCubit>(context),
              builder: (context, state) {
                return Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 70),
                            padding: EdgeInsets.only(
                                top: margin16 +
                                    MediaQuery.of(context).padding.top,
                                left: margin16,
                                right: margin16,
                                bottom: 90),
                            decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [
                                  Color(0xffFFB1B1),
                                  Color(0xffFFE9E9)
                                ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight)),
                            child: Text(
                              'Points',
                              style: mainBody3.copyWith(
                                  fontWeight: FontWeight.bold),
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: CarouselSlider(
                              options: CarouselOptions(
                                  viewportFraction: 0.85,
                                  autoPlay: false,
                                  enableInfiniteScroll: false,
                                  onPageChanged: (value, _) {},
                                  height: 140),
                              items: List.generate(1, (index) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? 0 : margin4),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Container(
                                          padding: EdgeInsets.all(margin16),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                model.getProfileInfoWidget(
                                                    context, state),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      vertical: margin24 / 2),
                                                  width: double.infinity,
                                                  height: 1,
                                                  color: Colors.black12,
                                                ),
                                                IntrinsicHeight(
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Image.asset(
                                                              ConstHelper
                                                                  .coinIcon)),
                                                      SizedBox(
                                                          width: margin24 / 2),
                                                      Expanded(
                                                          child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Points Anda',
                                                            style: secondaryBody5
                                                                .copyWith(
                                                                    color: Colors
                                                                        .black87),
                                                          ),
                                                          BlocBuilder<
                                                                  PointCubit,
                                                                  PointState>(
                                                              bloc: BlocProvider
                                                                  .of<PointCubit>(
                                                                      context),
                                                              builder: (context,
                                                                  statePoint) {
                                                                if (statePoint
                                                                    is PointLoaded) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      BlocProvider.of<ProfileCubit>(
                                                                              context)
                                                                          .fetchProfile(
                                                                              context);
                                                                    },
                                                                    child: Text(
                                                                      moneyChanger(
                                                                          statePoint
                                                                              .data
                                                                              .currentPoint,
                                                                          customLabel:
                                                                              ''),
                                                                      style: mainBody2.copyWith(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  );
                                                                } else if (statePoint
                                                                    is PointLoading) {
                                                                  return SizedBox(
                                                                    width: 15,
                                                                    height: 15,
                                                                    child: CircularProgressIndicator(
                                                                        color: Theme.of(context)
                                                                            .primaryColor),
                                                                  );
                                                                } else {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      BlocProvider.of<PointCubit>(
                                                                              context)
                                                                          .fetchPoint(
                                                                              context);
                                                                    },
                                                                    child: Text(
                                                                      'Coba Lagi',
                                                                      style: mainBody4.copyWith(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                  );
                                                                }
                                                              })
                                                        ],
                                                      )),
                                                      SizedBox(
                                                        width: margin8,
                                                      ),
                                                      Container(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          '1 point senilai 1 IDR',
                                                          style: secondaryBody5
                                                              .copyWith(
                                                                  color:
                                                                      neutral80),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                        child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: margin16),
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(model.filterData.length,
                                    (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      model.onChangeIndex(index);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: index == 0 ? margin16 : margin4,
                                          right: index == 9 ? margin16 : 0),
                                      padding: EdgeInsets.symmetric(
                                          vertical: margin4,
                                          horizontal: margin16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: index == model.selectedIndex
                                              ? const Color(0xffFFEEF1)
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: index ==
                                                      model.selectedIndex
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : const Color(0xffA5A5A5))),
                                      child: Text(
                                        model.filterData[index],
                                        style: mainBody4.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: index == model.selectedIndex
                                                ? Theme.of(context).primaryColor
                                                : const Color(0xffA5A5A5)),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ),
                          Expanded(
                              child: model.listPointWidget[model.selectedIndex])
                        ],
                      ),
                    ))
                  ],
                );
              });
        });
  }
}
