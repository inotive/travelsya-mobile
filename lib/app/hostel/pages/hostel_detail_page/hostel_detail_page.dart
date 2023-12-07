import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hostel/pages/hostel_checkout_page/hostel_checkout_page.dart';
import 'package:travelsya/app/hostel/vm/hostel_detail_vm.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travelsya/shared/api/api_connection.dart';
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

part '_hostel_detail_info_section.dart';
part '_hostel_detail_general_info_section.dart';
part '_hostel_detail_facility_section.dart';
part '_hostel_detail_location_section.dart';
part '_hostel_detail_room_section.dart';
part '_hostel_detail_review_section.dart';

class HostelDetailPage extends StatelessWidget {
  final String id;
  const HostelDetailPage({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostelDetailVM>.reactive(viewModelBuilder: () {
      return HostelDetailVM();
    }, onViewModelReady: (model) {
      model.onInit(
        context,
        id: id,
      );
    }, builder: (context, model, child) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: BlocBuilder<HostelCubit, HostelState>(
              bloc: model.hostelCubit,
              builder: (context, state) {
                if (state is DetailHostelLoaded) {
                  HostelDetailModel data = state.data;

                  return Stack(
                    children: [
                      ScrollablePositionedList.builder(
                        itemScrollController: model.itemScrollController,
                        itemPositionsListener: model.itemPositionsListener,
                        scrollOffsetListener: model.scrollOffsetListener,
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return _HostelDetailInfoSection(
                              data: data,
                              id: id,
                              model: model,
                            );
                          } else if (index == 1) {
                            return _HostelDetailGeneralInfoSection(data: data);
                          } else if (index == 2) {
                            return _HostelDetailFacilitySection(
                              data: data,
                            );
                          } else if (index == 3) {
                            return _HostelDetailLocationSection(
                              data: data,
                            );
                          } else if (index == 4) {
                            return _HostelDetailRoomSection(
                              data: data,
                              duration: model.searchFilter.selectedDuration,
                            );
                          } else if (index == 5) {
                            return _HostelDetailReviewSection(
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
                              height: model.showAppbar ? 22.0.w : 0,
                              width: 100.0.w,
                              color: Colors.white,
                              child: !model.showAppbar
                                  ? Container()
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 2.0.w,
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5.0.w),
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
                                                width: 3.0.w,
                                              ),
                                              Expanded(
                                                  child: Text(
                                                data.name,
                                                style: mainFont.copyWith(
                                                    fontSize: 13.0.sp,
                                                    color: Colors.black87,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              SizedBox(
                                                width: 3.0.w,
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
                                          height: 3.0.w,
                                        ),
                                        SizedBox(
                                            height: 8.0.w,
                                            child: model.tabWidget()),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (state is HostelLoading) {
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
                          durationType:
                              model.searchFilter.selectedDuration == 'Bulanan'
                                  ? 'monthly'
                                  : 'yearly');
                    }),
                  );
                }
              }));
    });
  }
}
