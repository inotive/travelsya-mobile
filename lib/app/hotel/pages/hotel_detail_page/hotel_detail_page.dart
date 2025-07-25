import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/models/hotel_detail_model.dart';
import 'package:travelsya/app/hotel/pages/hotel_checkout/hotel_checkout_page.dart';
import 'package:travelsya/app/hotel/vm/hotel_detail_vm.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/function/need_login_function.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';

import 'package:travelsya/shared/styles/font_style.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/photo_view_list_page.dart';
import 'package:url_launcher/url_launcher.dart';

part '_hotel_detail_info_section.dart';
part '_hotel_detail_general_info_section.dart';
part '_hotel_detail_facility_section.dart';
part '_hotel_detail_location_section.dart';
part '_hotel_detail_room_section.dart';
part '_hotel_detail_review_section.dart';

class HotelDetailPage extends StatelessWidget {
  final String id;
  const HotelDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HotelDetailVM>.reactive(viewModelBuilder: () {
      return HotelDetailVM();
    }, onViewModelReady: (model) {
      model.onInit(context, id: id);
    }, builder: (context, model, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<HotelCubit, HotelState>(
              bloc: model.hotelCubit,
              builder: (context, state) {
                if (state is HotelDetailLoaded) {
                  HotelDetailModel data = state.data;

                  return Stack(
                    children: [
                      ScrollablePositionedList.builder(
                        itemScrollController: model.itemScrollController,
                        itemPositionsListener: model.itemPositionsListener,
                        scrollOffsetListener: model.scrollOffsetListener,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _HotelDetailInfoSection(
                              data: data,
                              id: id,
                              model: model,
                            );
                          } else if (index == 1) {
                            return _HotelDetailGeneralInfoSection(data: data);
                          } else if (index == 2) {
                            return _HotelDetailFacilitySection(
                              data: data,
                            );
                          } else if (index == 3) {
                            return _HotelDetailLocationSection(
                              data: data,
                            );
                          } else if (index == 4) {
                            return _HotelDetailRoomSection(data: data);
                          } else if (index == 5) {
                            return _HotelDetailReviewSection(
                              data: data,
                              model: model,
                            );
                          }

                          return Container();
                        },
                      ),
                      SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              height: model.showAppbar ? 88 : 0,
                              width: double.infinity,
                              color: Colors.white,
                              child: !model.showAppbar
                                  ? Container()
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: margin4,
                                        ),
                                        Container(
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
                                                data.name,
                                                style: mainFont.copyWith(
                                                    fontSize: 15,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              SizedBox(
                                                width: margin24 / 2,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  showSnackbar(context,
                                                      data: 'Coming Soon',
                                                      colors: Theme.of(context)
                                                          .primaryColor);
                                                },
                                                child: Icon(
                                                  Icons.share,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: margin24 / 2,
                                        ),
                                        SizedBox(
                                            height: 25,
                                            child: model.tabWidget()),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is HotelLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: margin16),
                    child: FailedRequestWidget(onRetry: () {
                      model.fetchRoomData(context,
                          id: id,
                          startDate: DateFormat('yyyy-MM-dd').format(
                              model.searchFilter.selectedTime.startDate!),
                          endDate: DateFormat('yyyy-MM-dd').format(
                              model.searchFilter.selectedTime.endDate!));
                    }),
                  );
                }
              }));
    });
  }
}
