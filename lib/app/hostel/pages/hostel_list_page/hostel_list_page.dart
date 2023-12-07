import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/models/hostel_model.dart';
import 'package:travelsya/app/hostel/pages/hostel_detail_page/hostel_detail_page.dart';
import 'package:travelsya/app/hostel/vm/hostel_vm.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:sizer/sizer.dart';

class HostelListPage extends StatelessWidget {
  const HostelListPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostelListVM>.reactive(viewModelBuilder: () {
      return HostelListVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
        appBar: appbarWidget(context, title: 'Hasil Pencarian Hostel'),
        body: Column(
          children: [
            BlocBuilder<HostelCubit, HostelState>(
                bloc: model.hostelCubit,
                builder: (context, state) {
                  if (state is HostelLoading) {
                    return Expanded(
                        child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                      children: List.generate(10, (index) {
                        return PlaceHolder(
                          child: Container(
                            margin: EdgeInsets.only(top: 3.0.w),
                            width: 90.0.w,
                            height: 40.0.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                          ),
                        );
                      }),
                    ));
                  } else if (state is ListPreviewHostelLoaded) {
                    return Expanded(
                        child: state.data.isEmpty
                            ? Center(
                                child: Text(
                                  'Data Tidak Ditemukan',
                                  style: mainFont.copyWith(fontSize: 12.0.sp),
                                ),
                              )
                            : ListView(
                                children:
                                    List.generate(state.data.length, (index) {
                                  HostelPreviewModel data = state.data[index];

                                  List<Map<String, dynamic>> dataSearchMap = [
                                    {
                                      'icon': Icons.watch_later_outlined,
                                      'data': data.rentCategory == 'monthly'
                                          ? 'Bulanan'
                                          : 'Tahunan'
                                    },
                                    {
                                      'icon': Icons.location_city,
                                      'data': data.propertyType
                                    },
                                    {
                                      'icon': Icons.door_back_door,
                                      'data': data.roomType
                                    },
                                    {
                                      'icon': Icons.desk,
                                      'data': data.furnishType
                                    },
                                  ];

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => HostelDetailPage(
                                                  id: state.data[index].id
                                                      .toString())));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: index == 0 ? 5.0.w : 3.0.w,
                                          bottom: index == state.data.length - 1
                                              ? 10.0.w
                                              : 0),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5.0.w),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 45.0.w,
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                  color: Colors.black12,
                                                  image: state.data[index]
                                                              .image ==
                                                          null
                                                      ? const DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: AssetImage(
                                                              'assets/icons/logo.jpg'))
                                                      : DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(
                                                              state.data[index]
                                                                  .image!)),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  12),
                                                          topRight:
                                                              Radius.circular(
                                                                  12))),
                                            ),
                                            Container(
                                              padding: EdgeInsets.all(3.0.w),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.data[index].name,
                                                    style: mainFont.copyWith(
                                                        fontSize: 11.0.sp,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: 1.0.w,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star_rounded,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      Text(
                                                        '${state.data[index].ratingAvg.toStringAsFixed(1)} ',
                                                        style:
                                                            mainFont.copyWith(
                                                                fontSize:
                                                                    11.0.sp,
                                                                color: Colors
                                                                    .black87,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      Text(
                                                        '(${state.data[index].ratingCount})',
                                                        style:
                                                            mainFont.copyWith(
                                                          fontSize: 8.0.sp,
                                                          color:
                                                              Color(0xffa5a5a5),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 2.0.w,
                                                      ),
                                                      Text(
                                                        state.data[index]
                                                                .location ??
                                                            '-',
                                                        style: mainFont.copyWith(
                                                            fontSize: 10.0.sp,
                                                            color: const Color(
                                                                0xffa5a5a5)),
                                                      )
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: 3.0.w,
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment: MainAxisAlignment.end,
                                                  //   children: [
                                                  //     Text(
                                                  //       'mulai dari ',
                                                  //       style: mainFont.copyWith(
                                                  //           fontSize: 8.0.sp,
                                                  //           color: Color(0xffa5a5a5)),
                                                  //     ),
                                                  //     Text(
                                                  //       '500.000',
                                                  //       style: mainFont.copyWith(
                                                  //           fontSize: 8.0.sp,
                                                  //           decoration:
                                                  //               TextDecoration.lineThrough,
                                                  //           color: Color(0xffa5a5a5)),
                                                  //     )
                                                  //   ],
                                                  // ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      moneyChanger(
                                                          state.data[index]
                                                              .sellingPrice,
                                                          customLabel: 'IDR '),
                                                      style: mainFont.copyWith(
                                                          fontSize: 12.0.sp,
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Text(
                                                      '(Sudah Termasuk Pajak)',
                                                      style: mainFont.copyWith(
                                                          fontSize: 8.0.sp,
                                                          color: Color(
                                                              0xffa5a5a5)),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ));
                  } else {
                    return Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: margin16),
                      child: FailedRequestWidget(
                        onRetry: () {
                          model.onInit(context);
                        },
                      ),
                    );
                  }
                })
          ],
        ),
      ));
    });
  }
}
