import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/pages/hostel_detail_page/hostel_detail_page.dart';
import 'package:travelsya/app/hostel/vm/hostel_vm.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';
import 'package:travelsya/shared/styles/font_style.dart';

class HostelListPage extends StatelessWidget {
  const HostelListPage({
    super.key,
  });

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
                      padding: EdgeInsets.symmetric(horizontal: margin16),
                      children: List.generate(10, (index) {
                        return PlaceHolder(
                          child: Container(
                            margin: EdgeInsets.only(top: margin32 / 3),
                            width: double.infinity,
                            height: 150,
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
                                  style: mainFont.copyWith(fontSize: 14),
                                ),
                              )
                            : ListView(
                                children:
                                    List.generate(state.data.length, (index) {
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
                                          top: index == 0
                                              ? margin16
                                              : margin24 / 2,
                                          bottom: index == state.data.length - 1
                                              ? margin32
                                              : 0),
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: margin16),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            border: Border.all(
                                                color: Colors.black12)),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 120,
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
                                              padding:
                                                  EdgeInsets.all(margin24 / 2),
                                              width: double.infinity,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    state.data[index].name,
                                                    style: mainFont.copyWith(
                                                        fontSize: 13,
                                                        color: Colors.black87,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: margin4,
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
                                                                fontSize: 13,
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
                                                          fontSize: 10,
                                                          color: const Color(
                                                              0xffa5a5a5),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: margin8,
                                                      ),
                                                      Text(
                                                        state.data[index]
                                                                .location ??
                                                            '-',
                                                        style: mainFont.copyWith(
                                                            fontSize: 12,
                                                            color: const Color(
                                                                0xffa5a5a5)),
                                                      )
                                                    ],
                                                  ),

                                                  SizedBox(
                                                    height: margin24 / 2,
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
                                                          fontSize: 14,
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
                                                          fontSize: 10,
                                                          color: const Color(
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
