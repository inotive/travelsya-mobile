import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/models/hotel_detail_model.dart';
import 'package:travelsya/app/hotel/widgets/hotel_filter_sheet.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

class HotelDetailVM extends BaseViewModel {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemScrollController tabScrollController = ItemScrollController();
  ScrollOffsetController offsetController = ScrollOffsetController();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();

  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  int selectedIndex = 0;
  bool showAppbar = false;

  late HotelSearchFilter searchFilter;

  HotelCubit hotelCubit = HotelCubit();

  List<String> dataAllImage(HotelDetailModel data) {
    List<String> dataFinal = [];

    if (data.image != null) {
      dataFinal.add(data.image!);
    }

    dataFinal.addAll(data.images);

    for (var i = 0; i < data.room.length; i++) {
      dataFinal.addAll(data.room[i].images);
    }

    return dataFinal;
  }

  onTabPressed(int index) async {
    await tabScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
    await itemScrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
    selectedIndex = index;
  }

  onInnerViewScrolled() async {
    var positions = itemPositionsListener.itemPositions.value;

    /// Target [ScrollView] is not attached to any views and/or has no listeners.
    if (positions.isEmpty) return;

    /// Capture the index of the first [ItemPosition]. If the saved index is same
    /// with the current one do nothing and return.
    var firstIndex =
        itemPositionsListener.itemPositions.value.elementAt(0).index;
    if (selectedIndex == firstIndex) return;

    /// A new index has been detected.
    await handleTabScroll(firstIndex);
  }

  Widget tabWidgetDummy(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index) {
            return GestureDetector(
                onTap: () {
                  onTabPressed(index);
                },
                child: Container(
                  height: 30,
                  margin: EdgeInsets.only(
                      left: index == 0 ? margin16 : margin4,
                      right: index == 4 ? margin16 : 0),
                  padding: EdgeInsets.symmetric(horizontal: margin16),
                  decoration: BoxDecoration(
                      color: index == selectedIndex
                          ? const Color(0xffFFEEF1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          color: index == selectedIndex
                              ? Theme.of(context).primaryColor
                              : const Color(0xffa5a5a5))),
                  alignment: Alignment.center,
                  child: Text(
                    getFilterData(index),
                    style: mainFont.copyWith(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: index == selectedIndex
                            ? Theme.of(context).primaryColor
                            : const Color(0xffa5a5a5)),
                  ),
                ));
          }),
        ));
  }

  Widget tabWidget() {
    return ScrollablePositionedList.builder(
      itemCount: 5,
      scrollDirection: Axis.horizontal,
      itemScrollController: tabScrollController,
      scrollOffsetController: offsetController,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            onTabPressed(index);
          },
          child: Container(
            height: 25,
            margin: EdgeInsets.only(
                left: index == 0 ? margin16 : margin4,
                right: index == 4 ? margin16 : 0),
            padding: EdgeInsets.symmetric(horizontal: margin16),
            decoration: BoxDecoration(
                color: index == selectedIndex
                    ? const Color(0xffFFEEF1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: index == selectedIndex
                        ? Theme.of(context).primaryColor
                        : const Color(0xffa5a5a5))),
            alignment: Alignment.center,
            child: Text(
              getFilterData(index),
              style: mainFont.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: index == selectedIndex
                      ? Theme.of(context).primaryColor
                      : const Color(0xffa5a5a5)),
            ),
          ),
        );
      },
    );
  }

  handleTabScroll(int index) async {
    selectedIndex = index;
    if (selectedIndex >= 1) {
      showAppbar = true;
    } else {
      showAppbar = false;
    }
    notifyListeners();

    await itemScrollController.scrollTo(
        index: selectedIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease);
  }

  String getReviewVal(double data) {
    double reviewVal = data;

    if (reviewVal <= 2) {
      return 'Kurang Baik';
    } else if (reviewVal <= 3) {
      return 'Cukup';
    } else if (reviewVal <= 4) {
      return 'Baik';
    } else if (reviewVal <= 5) {
      return 'Sangat Baik';
    } else {
      return '';
    }
  }

  fetchRoomData(BuildContext context,
      {required String id,
      required String startDate,
      required String endDate}) {
    hotelCubit.fetchDetailHotel(context,
        id: id, startDate: startDate, endDate: endDate);
  }

  onFilterChanged(BuildContext context, {required String id}) async {
    HotelSearchFilter? result = await showModalBottomSheet(
        context: context,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        builder: (context) {
          return HotelFilterSheet(
            data: searchFilter,
          );
        });

    if (result != null) {
      searchFilter.guessCount = result.guessCount;
      searchFilter.roomCount = result.roomCount;
      searchFilter.selectedTime = result.selectedTime;

      if (context.mounted) {
        BlocProvider.of<HotelFilterCubit>(context).onChangeState(searchFilter);

        fetchRoomData(context,
            id: id,
            startDate: DateFormat('yyyy-MM-dd')
                .format(searchFilter.selectedTime.startDate!),
            endDate: DateFormat('yyyy-MM-dd')
                .format(searchFilter.selectedTime.endDate!));
      }

      notifyListeners();
    }
  }

  onInit(BuildContext context, {required String id}) {
    HotelState state = BlocProvider.of<HotelFilterCubit>(context).state;
    if (state is HotelSearchFilter) {
      searchFilter = state;
      notifyListeners();
    }

    itemPositionsListener.itemPositions.addListener(onInnerViewScrolled);

    fetchRoomData(context,
        id: id,
        startDate: DateFormat('yyyy-MM-dd')
            .format(searchFilter.selectedTime.startDate!),
        endDate: DateFormat('yyyy-MM-dd')
            .format(searchFilter.selectedTime.endDate!));
  }

  String getFilterData(int index) {
    String returnValue = '';

    if (index == 0) {
      returnValue = 'Info Umum';
    } else if (index == 1) {
      returnValue = 'Fasilitas';
    } else if (index == 2) {
      returnValue = 'Lokasi';
    } else if (index == 3) {
      returnValue = 'Tipe Kamar';
    } else if (index == 4) {
      returnValue = 'Review';
    }

    return returnValue;
  }
}
