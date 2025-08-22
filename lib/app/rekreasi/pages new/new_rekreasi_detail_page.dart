import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_cubit.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_state.dart';
import 'package:travelsya/app/rekreasi/pages%20new/new_rekreasi_package_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_info_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_location_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_package_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_review_section.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/loading_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class NewRekreasiDetailPage extends StatefulWidget {
  final String id;
  const NewRekreasiDetailPage({super.key, required this.id});

  @override
  State<NewRekreasiDetailPage> createState() => _NewRekreasiDetailPageState();
}

class _NewRekreasiDetailPageState extends State<NewRekreasiDetailPage> {
  final scrollController = ScrollController();
  final tabScrollController = ScrollController();
  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  late RecreationCubit recreationCubit;

  // GlobalKeys untuk setiap section
  final sectionKeys = List.generate(4, (_) => GlobalKey());

  @override
  void initState() {
    super.initState();
    recreationCubit = RecreationCubit()
      ..onLoadDetailRecreation(context, id: widget.id);
    scrollController.addListener(_onScroll);

    selectedIndex.addListener(() {
      _scrollTabToIndex(selectedIndex.value);
    });
  }

  void _onScroll() {
    for (int i = 0; i < sectionKeys.length; i++) {
      final ctx = sectionKeys[i].currentContext;
      if (ctx != null) {
        final box = ctx.findRenderObject() as RenderBox;
        final pos = box.localToGlobal(Offset.zero);
        if (pos.dy <= kToolbarHeight + 60 && pos.dy > -box.size.height / 2) {
          if (selectedIndex.value != i) {
            selectedIndex.value = i;
          }
        }
      }
    }
  }

  void _scrollTabToIndex(int index) {
    const tabWidth = 120.0;
    double offset = (index * tabWidth) - (tabWidth * 1.5);
    if (offset < 0) offset = 0;

    tabScrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _scrollToSection(int index) async {
    final ctx = sectionKeys[index].currentContext;
    if (ctx != null) {
      final box = ctx.findRenderObject() as RenderBox;
      final pos =
          box.localToGlobal(Offset.zero, ancestor: context.findRenderObject());
      double targetOffset = scrollController.offset + pos.dy - 50;

      if (targetOffset > scrollController.position.maxScrollExtent) {
        targetOffset = scrollController.position.maxScrollExtent;
      }

      await scrollController.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  String getFilterData(int index) {
    switch (index) {
      case 0:
        return 'Info Umum';
      case 1:
        return 'Lokasi';
      case 2:
        return 'Paket Tersedia';
      case 3:
        return 'Review';
      default:
        return '';
    }
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
              final data = state.data;

              return SafeArea(
                top: true,
                bottom: false,
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    // HEADER
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AspectRatio(
                            aspectRatio: 375 / 264,
                            child: Image.network(
                              data.images[0],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(margin16),
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xffFFEEF1),
                                    ),
                                    child: Icon(
                                      Icons.arrow_back,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: margin16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.category, style: mainBody5),
                                Text(
                                  data.name,
                                  style: mainBody3.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: margin8),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(Icons.star,
                                        color: Theme.of(context).primaryColor),
                                    Text(
                                      data.avgRating!.toStringAsFixed(1),
                                      style: mainBody3.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      '/5',
                                      style: mainBody4.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(' (${data.ratingCount})'),
                                    SizedBox(width: margin4),
                                    Text(
                                      data.city,
                                      style: mainBody4.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        decoration: TextDecoration.underline,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: margin16),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        height: 8,
                        color: const Color(0xfff4f4f4),
                      ),
                    ),
                    // STICKY TAB
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _TabBarDelegate(
                        child: Container(
                          color: Colors.white,
                          child: ValueListenableBuilder<int>(
                            valueListenable: selectedIndex,
                            builder: (context, idx, _) {
                              return SingleChildScrollView(
                                controller: tabScrollController,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(
                                    horizontal: margin16, vertical: margin8),
                                child: Row(
                                  children: List.generate(4, (index) {
                                    return GestureDetector(
                                      onTap: () async {
                                        await _scrollToSection(index);
                                        selectedIndex.value = index;
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: margin8),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: margin16, vertical: 8),
                                        decoration: BoxDecoration(
                                          color: idx == index
                                              ? const Color(0xffFFEEF1)
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          border: Border.all(
                                            color: idx == index
                                                ? Theme.of(context).primaryColor
                                                : const Color(0xffa5a5a5),
                                          ),
                                        ),
                                        child: Text(
                                          getFilterData(index),
                                          style: mainBody4.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: idx == index
                                                ? Theme.of(context).primaryColor
                                                : const Color(0xffa5a5a5),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        width: double.infinity,
                        height: 8,
                        color: const Color(0xfff4f4f4),
                      ),
                    ),
                    // SECTION 0
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            key: sectionKeys[0],
                            child: RekreasiInfoSection(data: data),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8,
                            color: const Color(0xfff4f4f4),
                          ),
                        ],
                      ),
                    ),

                    // SECTION 1
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            key: sectionKeys[1],
                            child: RekreasiLocationSection(data: data),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8,
                            color: const Color(0xfff4f4f4),
                          ),
                        ],
                      ),
                    ),

                    // SECTION 2
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            key: sectionKeys[2],
                            child: NewRekreasiPackageSection(
                              data: data.package,
                              dataDetail: data,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8,
                            color: const Color(0xfff4f4f4),
                          ),
                        ],
                      ),
                    ),

                    // SECTION 3
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Container(
                            key: sectionKeys[3],
                            child: RekreasiReviewSection(data: data),
                          ),
                          Container(
                            width: double.infinity,
                            height: 8,
                            color: const Color(0xfff4f4f4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: margin16),
                child: FailedRequestWidget(
                  onRetry: () => recreationCubit.onLoadDetailRecreation(context,
                      id: widget.id),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _TabBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  _TabBarDelegate({required this.child});

  @override
  double get minExtent => 50;
  @override
  double get maxExtent => 50;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
