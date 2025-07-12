import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_cubit.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_state.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_detail_page.dart';
import 'package:travelsya/app/rekreasi/pages/rekreasi_search_result_page.dart';
import 'package:travelsya/app/rekreasi/viewmodel/recreation_main_vm.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/no_data_widget.dart';

class RekreasiSearchPage extends StatelessWidget {
  const RekreasiSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RecreationMainVM>.reactive(viewModelBuilder: () {
      return RecreationMainVM();
    }, onViewModelReady: (model) {
      model.onLoadCategory(context);
    }, builder: (context, model, child) {
      return Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 200,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/edvin-johansson-rlwE8f8anOc-unsplash 1 (1).png'))),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: Colors.black45,
                  ),
                ),
                Positioned(
                  left: margin16,
                  top: MediaQuery.of(context).padding.top + margin24,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          width: 37,
                          height: 37,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 16,
                            height: 16,
                            child: Image.asset('assets/new/back.png'),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: margin48,
                      ),
                      Text(
                        'Rekreasi',
                        style: mainBody3.copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    height: 20,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                        color: Colors.white),
                  ),
                )
              ],
            ),
            SizedBox(
              height: margin16,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: margin16),
              child: GestureDetector(
                onTap: () async {
                  model.onChangeSelectedCity(context);
                },
                child: FormHelper.dropdownForm(context,
                    data: model.selectedCity ?? 'Semua Lokasi',
                    hintText: 'Kota Reservasi'),
              ),
            ),
            SizedBox(
              height: margin16,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: margin16),
                child: ElevatedButtonWidget(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => RekreasiSearchResultPage(
                                  city: model.selectedCity,
                                )));
                  },
                  title: 'Cari Sekarang',
                )),
            SizedBox(
              height: margin16,
            ),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: margin16),
                    child: Text(
                      'Apa yang ingin kamu lakukan?',
                      style: mainBody3.copyWith(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: margin24 / 2,
                  ),
                  BlocBuilder<RecreationCubit, RecreationState>(
                      bloc: model.recreationCategoryCubit,
                      builder: (context, stateCategory) {
                        if (stateCategory is RecreationLoading) {
                          return Container(
                            margin: EdgeInsets.only(left: margin16),
                            width: 25,
                            height: 25,
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        } else if (stateCategory is RecreationCategoryLoaded) {
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: List.generate(
                                        stateCategory.data.length, (index) {
                                      return GestureDetector(
                                        onTap: () {
                                          model.onChangeIndexCategory(context,
                                              stateCategory.data[index].id);
                                        },
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: index == 0
                                                  ? margin16
                                                  : margin4,
                                              right: index ==
                                                      stateCategory
                                                              .data.length -
                                                          1
                                                  ? margin16
                                                  : 0),
                                          padding: EdgeInsets.symmetric(
                                              vertical: margin4,
                                              horizontal: margin16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: stateCategory
                                                          .data[index].id ==
                                                      model.selectedCategory
                                                  ? const Color(0xffFFEEF1)
                                                  : Colors.transparent,
                                              border: Border.all(
                                                  color: stateCategory
                                                              .data[index].id ==
                                                          model.selectedCategory
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : const Color(
                                                          0xffA5A5A5))),
                                          child: Text(
                                            stateCategory.data[index].name,
                                            style: mainBody4.copyWith(
                                                color: stateCategory
                                                            .data[index].id ==
                                                        model.selectedCategory
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : const Color(0xffA5A5A5)),
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: margin16,
                              ),
                              BlocBuilder<RecreationCubit, RecreationState>(
                                  bloc: model.recreationPreviewCubit,
                                  builder: (context, state) {
                                    if (state is RecreationLoading) {
                                      return Container(
                                        margin: EdgeInsets.only(top: margin24),
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      );
                                    } else if (state
                                        is RecreationPreviewListLoaded) {
                                      if (state.data.isEmpty) {
                                        return const NoDataWidget();
                                      }

                                      return Column(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: margin16),
                                            width: double.infinity,
                                            child: Wrap(
                                              alignment:
                                                  WrapAlignment.spaceBetween,
                                              children: List.generate(
                                                  state.data.length, (index) {
                                                RecreationPreviewModel data =
                                                    state.data[index];
                                                return FractionallySizedBox(
                                                  widthFactor: 0.49,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  const RekreasiDetailPage(
                                                                    id: '1',
                                                                  )));
                                                    },
                                                    child: Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8)),
                                                      child: Column(
                                                        children: [
                                                          AspectRatio(
                                                            aspectRatio:
                                                                167 / 100,
                                                            child: Container(
                                                              width: double
                                                                  .infinity,
                                                              height: double
                                                                  .infinity,
                                                              decoration: BoxDecoration(
                                                                  borderRadius: const BorderRadius
                                                                      .only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              8),
                                                                      topRight:
                                                                          Radius.circular(
                                                                              8)),
                                                                  image: DecorationImage(
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      image: NetworkImage(
                                                                          data.image))),
                                                            ),
                                                          ),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    margin24 /
                                                                        2),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  data.name,
                                                                  maxLines: 2,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: mainBody4.copyWith(
                                                                      color: Colors
                                                                          .black87,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                Text(
                                                                  data.location,
                                                                  style: mainBody5
                                                                      .copyWith(
                                                                          color:
                                                                              const Color(0xffa5a5a5)),
                                                                ),
                                                                SizedBox(
                                                                  height:
                                                                      margin8,
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      'mulai dari ',
                                                                      style: mainBody5.copyWith(
                                                                          color:
                                                                              const Color(0xffa5a5a5)),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  moneyChanger(
                                                                      data.price),
                                                                  style: mainBody4.copyWith(
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                                SizedBox(
                                                                    height:
                                                                        margin8),
                                                                Row(
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .primaryColor,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          margin4,
                                                                    ),
                                                                    Text(
                                                                      '${data.avgRating} ',
                                                                      style: mainBody4.copyWith(
                                                                          color: Colors
                                                                              .black87,
                                                                          fontWeight:
                                                                              FontWeight.bold),
                                                                    ),
                                                                    Text(
                                                                      '(${data.ratingCount})',
                                                                      style: mainBody5
                                                                          .copyWith(
                                                                        color: const Color(
                                                                            0xffa5a5a5),
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: margin16,
                                          // ),
                                          // Container(
                                          //   padding: EdgeInsets.symmetric(
                                          //       horizontal: margin16),
                                          //   child: FormHelper.borderButton(
                                          //       context,
                                          //       onTap: () {},
                                          //       title: 'Lihat Semua'),
                                          // )
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  }),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      }),
                ],
              ),
            ),
            SizedBox(
              height: margin32,
            )
          ],
        ),
      );
    });
  }
}
