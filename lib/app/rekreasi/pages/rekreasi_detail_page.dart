import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_cubit.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_state.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_info_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_location_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_package_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_review_section.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/loading_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class RekreasiDetailPage extends StatefulWidget {
  final String id;
  const RekreasiDetailPage({super.key, required this.id});

  @override
  State<RekreasiDetailPage> createState() => _RekreasiDetailPageState();
}

class _RekreasiDetailPageState extends State<RekreasiDetailPage> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemScrollController tabScrollController = ItemScrollController();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  ScrollController scrollController = ScrollController();
  ValueNotifier<double> scrollProgress = ValueNotifier(0);
  ValueNotifier<int> selectedIndex = ValueNotifier(0);

  void _onTabPressed(int index) async {
    await tabScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
    await itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
    selectedIndex.value = index;
  }

  String getFilterData(int index) {
    String returnValue = '';

    if (index == 0) {
      returnValue = 'Info Umum';
    } else if (index == 1) {
      returnValue = 'Lokasi';
    } else if (index == 2) {
      returnValue = 'Paket Tersedia';
    } else if (index == 3) {
      returnValue = 'Review';
    }

    return returnValue;
  }

  void _onInnerViewScrolled() async {
    var positions = itemPositionsListener.itemPositions.value;

    /// Target [ScrollView] is not attached to any views and/or has no listeners.
    if (positions.isEmpty) return;

    /// Capture the index of the first [ItemPosition]. If the saved index is same
    /// with the current one do nothing and return.
    var firstIndex =
        itemPositionsListener.itemPositions.value.elementAt(0).index;
    if (selectedIndex.value == firstIndex) return;

    /// A new index has been detected.
    await _handleTabScroll(firstIndex);
  }

  Future<void> _handleTabScroll(int index) async {
    selectedIndex.value = index;
    await itemScrollController.scrollTo(
        index: selectedIndex.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  RecreationCubit recreationCubit = RecreationCubit();

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(_onInnerViewScrolled);
    scrollController.addListener(() {
      scrollProgress.value =
          scrollController.offset < 1000 ? scrollController.offset / 1000 : 1;
    });
    recreationCubit.onLoadDetailRecreation(context, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatusbarWidget(
      customBrightness: Brightness.dark,
      child: Scaffold(
          body: BlocBuilder<RecreationCubit, RecreationState>(
              bloc: recreationCubit,
              builder: (context, state) {
                if (state is RecreationLoading) {
                  return const LoadingWidget();
                } else if (state is RecreationDetailLoaded) {
                  RecreationDetailModel data = state.data;
                  return NestedScrollView(
                    controller: scrollController,
                    headerSliverBuilder: (context, _) {
                      return [
                        SliverList(
                          delegate: SliverChildListDelegate([
                            AspectRatio(
                                aspectRatio: 375 / 264,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              state.data.images[0]),
                                          fit: BoxFit.cover),
                                      border: const Border(
                                          bottom: BorderSide(
                                              color: Colors.white, width: 3))),
                                )),
                            Container(
                              padding: EdgeInsets.all(margin16),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 45,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFFEEF1)),
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: margin24 / 2,
                                  ),
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffFFEEF1)),
                                    child: Icon(
                                      Icons.share,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding:
                                  EdgeInsets.symmetric(horizontal: margin16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.category,
                                    style: mainBody5.copyWith(color: neutral30),
                                  ),
                                  Text(
                                    data.name,
                                    style: mainBody3.copyWith(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: margin8,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                      Text(
                                        data.avgRating.toStringAsFixed(1),
                                        style: mainBody3.copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        ' (${data.ratingCount})',
                                        style: mainBody4.copyWith(
                                            color: const Color(0xffa5a5a5)),
                                      ),
                                      SizedBox(
                                        width: margin4,
                                      ),
                                      Text(
                                        data.city,
                                        style: mainBody4.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                            decoration:
                                                TextDecoration.underline),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: margin16,
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: margin8,
                                    color: const Color(0xfff4f4f4),
                                  )
                                ],
                              ),
                            )
                          ]),
                        ),
                      ];
                    },
                    body: Column(
                      children: [
                        ValueListenableBuilder(
                            valueListenable: scrollProgress,
                            builder: (context, double progress, _) {
                              return SafeArea(
                                child: Column(
                                  children: [
                                    AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      height: progress <= 0.5 ? 0 : margin40,
                                      width: double.infinity,
                                      child: progress <= 0.5
                                          ? Container()
                                          : Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: margin16),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Icon(
                                                      Icons.arrow_back,
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: margin24 / 2,
                                                  ),
                                                  Expanded(
                                                      child: Text(
                                                    state.data.name,
                                                    style: mainBody3.copyWith(
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  SizedBox(
                                                    width: margin24 / 2,
                                                  ),
                                                  Icon(
                                                    Icons.share,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  )
                                                ],
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                        ValueListenableBuilder(
                            valueListenable: selectedIndex,
                            builder: (context, int idx, _) {
                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.only(bottom: margin16),
                                child: SizedBox(
                                  height: 30,
                                  child: ScrollablePositionedList.builder(
                                    itemCount: 4,
                                    scrollDirection: Axis.horizontal,
                                    itemScrollController: tabScrollController,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          _onTabPressed(index);
                                        },
                                        child: Container(
                                          height: 30,
                                          margin: EdgeInsets.only(
                                              left: index == 0
                                                  ? margin16
                                                  : margin4,
                                              right: index == 3 ? margin16 : 0),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: margin16),
                                          decoration: BoxDecoration(
                                              color: index == idx
                                                  ? const Color(0xffFFEEF1)
                                                  : Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              border: Border.all(
                                                  color: index == idx
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : const Color(
                                                          0xffa5a5a5))),
                                          alignment: Alignment.center,
                                          child: Text(
                                            getFilterData(index),
                                            style: mainBody4.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: index == idx
                                                    ? Theme.of(context)
                                                        .primaryColor
                                                    : const Color(0xffa5a5a5)),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            }),
                        Container(
                          width: double.infinity,
                          height: margin8,
                          color: const Color(0xfff4f4f4),
                        ),
                        Expanded(
                          child: ScrollablePositionedList.builder(
                            itemScrollController: itemScrollController,
                            itemPositionsListener: itemPositionsListener,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return RekreasiInfoSection(
                                  data: data,
                                );
                              } else if (index == 1) {
                                return RekreasiLocationSection(
                                  data: data,
                                );
                              } else if (index == 2) {
                                return RekreasiPackageSection(
                                  data: data.package,
                                  dataDetail: data,
                                );
                              } else if (index == 3) {
                                return RekreasiReviewSection(
                                  data: data,
                                );
                              }

                              return Container();
                            },
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: margin16),
                    child: FailedRequestWidget(onRetry: () {
                      recreationCubit.onLoadDetailRecreation(context,
                          id: widget.id);
                    }),
                  );
                }
              })),
    );
  }
}
