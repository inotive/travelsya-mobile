import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/rekreasi/widgets/rekreasi_package_section.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class RekreasiDetailPage extends StatefulWidget {
  const RekreasiDetailPage({Key? key}) : super(key: key);

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
        duration: Duration(milliseconds: 300),
        curve: Curves.ease);
    await itemScrollController.scrollTo(
        index: index,
        duration: Duration(milliseconds: 300),
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
    if (positions == null || positions.isEmpty) return;

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
    return Scaffold(
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
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        image: DecorationImage(
                            image: AssetImage(ConstHelper.helperPhoto),
                            fit: BoxFit.cover),
                        border: Border(
                            bottom: BorderSide(color: Colors.white, width: 3))),
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
                          ? BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                  image: AssetImage(ConstHelper.helperPhoto),
                                  fit: BoxFit.cover),
                            )
                          : BoxDecoration(
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
                                style: mainFont.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10.0.sp,
                                    color: Colors.white),
                              ),
                            )
                          : Container(),
                    ),
                  ),
                );
              })),
              Container(
                padding: EdgeInsets.all(5.0.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 10.0.w,
                        height: 10.0.w,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffFFEEF1)),
                        child: Icon(
                          Icons.arrow_back,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 3.0.w,
                    ),
                    Container(
                      width: 10.0.w,
                      height: 10.0.w,
                      decoration: BoxDecoration(
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
                padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spa & Kecantikan',
                      style: mainFont.copyWith(
                          fontSize: 10.0.sp, color: neutral30),
                    ),
                    Text(
                      'Meiso Kelapa Gading',
                      style: mainFont.copyWith(
                          fontSize: 17.0.sp,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.0.w,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Theme.of(context).primaryColor,
                        ),
                        Text(
                          '4,7',
                          style: mainFont.copyWith(
                              fontSize: 13.0.sp,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' (12)',
                          style: mainFont.copyWith(
                              fontSize: 11.0.sp, color: Color(0xffa5a5a5)),
                        ),
                        SizedBox(
                          width: 1.0.w,
                        ),
                        Text(
                          'Jakarta Utara',
                          style: mainFont.copyWith(
                              fontSize: 12.0.sp,
                              color: Theme.of(context).primaryColor,
                              decoration: TextDecoration.underline),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5.0.w,
                    ),
                    Container(
                      width: double.infinity,
                      height: 2.0.w,
                      color: Color(0xfff4f4f4),
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
                        height: progress <= 0.5 ? 0 : 15.0.w,
                        width: 100.0.w,
                        child: progress <= 0.5
                            ? Container()
                            : Container(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 5.0.w),
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
                                      width: 3.0.w,
                                    ),
                                    Expanded(
                                        child: Text(
                                      'Nama Hotel',
                                      style: mainFont.copyWith(
                                          fontSize: 13.0.sp,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    SizedBox(
                                      width: 3.0.w,
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
                  width: 100.0.w,
                  padding: EdgeInsets.only(bottom: 5.0.w),
                  child: SizedBox(
                    height: 8.0.w,
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
                            height: 8.0.w,
                            margin: EdgeInsets.only(
                                left: index == 0 ? 5.0.w : 1.0.w,
                                right: index == 3 ? 5.0.w : 0),
                            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                            decoration: BoxDecoration(
                                color: index == idx
                                    ? Color(0xffFFEEF1)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                    color: index == idx
                                        ? Theme.of(context).primaryColor
                                        : Color(0xffa5a5a5))),
                            alignment: Alignment.center,
                            child: Text(
                              getFilterData(index),
                              style: mainFont.copyWith(
                                  fontSize: 11.0.sp,
                                  fontWeight: FontWeight.bold,
                                  color: index == idx
                                      ? Theme.of(context).primaryColor
                                      : Color(0xffa5a5a5)),
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
            height: 2.0.w,
            color: Color(0xfff4f4f4),
          ),
          Expanded(
            child: ScrollablePositionedList.builder(
              itemScrollController: itemScrollController,
              itemPositionsListener: itemPositionsListener,
              itemCount: 4,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // return   HotelDetailInfoSection();
                  return Container();
                } else if (index == 1) {
                  // return const HotelDetailLocationSection(
                  //   address: '',
                  //   latitude: '',
                  //   longitude: '',
                  // );
                  return Container();
                } else if (index == 2) {
                  return const RekreasiPackageSection();
                } else if (index == 3) {
                  return Container();
                }

                return Container();
              },
            ),
          )
        ],
      ),
    ));
  }
}
