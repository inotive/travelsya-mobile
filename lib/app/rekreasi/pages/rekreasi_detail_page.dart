import 'package:flutter/material.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_info_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_location_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_package_section.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_review_section.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

class RekreasiDetailPage extends StatefulWidget {
  const RekreasiDetailPage({super.key});

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

  @override
  void initState() {
    itemPositionsListener.itemPositions.addListener(_onInnerViewScrolled);
    scrollController.addListener(() {
      scrollProgress.value =
          scrollController.offset < 1000 ? scrollController.offset / 1000 : 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatusbarWidget(
      customBrightness: Brightness.dark,
      child: Scaffold(
          body: NestedScrollView(
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
                      decoration: const BoxDecoration(
                          color: Colors.blue,
                          image: DecorationImage(
                              image: AssetImage(ConstHelper.helperPhoto),
                              fit: BoxFit.cover),
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.white, width: 3))),
                    )),
                Row(
                    children: List.generate(3, (index) {
                  return Flexible(
                    flex: 1,
                    child: AspectRatio(
                      aspectRatio: 123 / 74,
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: index == 0
                            ? const BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: AssetImage(ConstHelper.helperPhoto),
                                    fit: BoxFit.cover),
                              )
                            : const BoxDecoration(
                                color: Colors.blue,
                                image: DecorationImage(
                                    image: AssetImage(ConstHelper.helperPhoto),
                                    fit: BoxFit.cover),
                                border: Border(
                                    left: BorderSide(
                                        color: Colors.white, width: 3))),
                        child: index == 2
                            ? Container(
                                width: double.infinity,
                                height: double.infinity,
                                color: Colors.black38,
                                alignment: Alignment.center,
                                child: Text(
                                  '+34 Lainnya',
                                  style: mainBody4.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              )
                            : Container(),
                      ),
                    ),
                  );
                })),
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
                              shape: BoxShape.circle, color: Color(0xffFFEEF1)),
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
                            shape: BoxShape.circle, color: Color(0xffFFEEF1)),
                        child: Icon(
                          Icons.share,
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: margin16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Spa & Kecantikan',
                        style: mainBody5.copyWith(color: neutral30),
                      ),
                      Text(
                        'Meiso Kelapa Gading',
                        style: mainBody3.copyWith(
                            color: Colors.black87, fontWeight: FontWeight.bold),
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
                            '4,7',
                            style: mainBody3.copyWith(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            ' (12)',
                            style: mainBody4.copyWith(
                                color: const Color(0xffa5a5a5)),
                          ),
                          SizedBox(
                            width: margin4,
                          ),
                          Text(
                            'Jakarta Utara',
                            style: mainBody4.copyWith(
                                color: Theme.of(context).primaryColor,
                                decoration: TextDecoration.underline),
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
                          duration: const Duration(milliseconds: 400),
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
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width: margin24 / 2,
                                      ),
                                      Expanded(
                                          child: Text(
                                        'Nama Rekreasi',
                                        style: mainBody3.copyWith(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      SizedBox(
                                        width: margin24 / 2,
                                      ),
                                      Icon(
                                        Icons.share,
                                        color: Theme.of(context).primaryColor,
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
                                  left: index == 0 ? margin16 : margin4,
                                  right: index == 3 ? margin16 : 0),
                              padding:
                                  EdgeInsets.symmetric(horizontal: margin16),
                              decoration: BoxDecoration(
                                  color: index == idx
                                      ? const Color(0xffFFEEF1)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                      color: index == idx
                                          ? Theme.of(context).primaryColor
                                          : const Color(0xffa5a5a5))),
                              alignment: Alignment.center,
                              child: Text(
                                getFilterData(index),
                                style: mainBody4.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: index == idx
                                        ? Theme.of(context).primaryColor
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
                    return const RekreasiInfoSection();
                  } else if (index == 1) {
                    return const RekreasiLocationSection();
                  } else if (index == 2) {
                    return const RekreasiPackageSection();
                  } else if (index == 3) {
                    return const RekreasiReviewSection();
                  }

                  return Container();
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
