import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_cubit.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_cubit.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_state.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_state.dart';
import 'package:travelsya/app/rental_mobil/viewmodel/rental_mobil_search_vm.dart';
import 'package:travelsya/app/rental_mobil/widgets/rental_option_dialog.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class RentalDetailPage extends StatefulWidget {
  const RentalDetailPage({super.key});

  @override
  State<RentalDetailPage> createState() => _RentalDetailPageState();
}

class _RentalDetailPageState extends State<RentalDetailPage> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RentalMobilSearchVM>.reactive(viewModelBuilder: () {
      return RentalMobilSearchVM();
    }, onViewModelReady: (model) {
      model.rentalCubit.searchRentalMobil(context);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: BlocBuilder<RentalMobilFilterCubit, RentalMobilFilterState>(
            bloc: BlocProvider.of<RentalMobilFilterCubit>(context),
            builder: (context, state) {
              if (state is RentalMobilFilterLoaded) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(margin16),
                      color: Theme.of(context).primaryColor,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: margin24 / 2,
                          ),
                          Text(
                            state.data.selectedLocation == null
                                ? 'Rental Mobil'
                                : 'Rental di ${state.data.selectedLocation}',
                            style: mainBody3.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(margin16),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              bottom: BorderSide(
                                  color: neutral50.withOpacity(0.3)))),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: margin8,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: neutral10),
                            child: Row(
                              children: [
                                Icon(Icons.date_range,
                                    color: neutral50, size: 20),
                                SizedBox(
                                  width: margin8,
                                ),
                                Expanded(
                                    child: Text(
                                  '${dateToReadable(DateFormat('yyyy-MM-dd').format(state.data.selectedDate))} | ${state.data.duration} Hari | ${state.data.isWithDriver ? 'Dengan Sopir' : 'Lepas Kunci'}',
                                  style: mainBody4.copyWith(color: neutral100),
                                )),
                                SizedBox(
                                  width: margin8,
                                ),
                                Text(
                                  'Ubah',
                                  style: mainBody5.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: margin16),
                        child: Row(
                            children: List.generate(model.dataTransmisi.length,
                                (index) {
                          return GestureDetector(
                            onTap: () {
                              model.onChangeIndexFilter(context, index);
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  left: index == 0 ? margin16 : margin4,
                                  right: 0),
                              padding: EdgeInsets.symmetric(
                                  vertical: margin4, horizontal: margin16),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: index == model.selectedIndexFilter
                                      ? const Color(0xffFFEEF1)
                                      : Colors.transparent,
                                  border: Border.all(
                                      color: index == model.selectedIndexFilter
                                          ? Theme.of(context).primaryColor
                                          : const Color(0xffA5A5A5))),
                              child: Text(
                                model.dataTransmisi[index],
                                style: mainBody5.copyWith(
                                    color: index == model.selectedIndexFilter
                                        ? Theme.of(context).primaryColor
                                        : const Color(0xffA5A5A5)),
                              ),
                            ),
                          );
                        }))),
                    Expanded(
                        child: Container(
                      color: Colors.white,
                      child: BlocBuilder<RentalMobilCubit, RentalMobilState>(
                          bloc: model.rentalCubit,
                          builder: (context, stateData) {
                            if (stateData is RentalMobilLoading) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: Theme.of(context).primaryColor,
                                ),
                              );
                            } else if (stateData is RentalMobilSearchLoaded) {
                              return ListView(
                                padding:
                                    EdgeInsets.symmetric(horizontal: margin16),
                                children: List.generate(stateData.data.length,
                                    (index) {
                                  return GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    topRight:
                                                        Radius.circular(10))),
                                            backgroundColor: Colors.transparent,
                                            constraints: BoxConstraints(
                                                minHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.7,
                                                maxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.7),
                                            builder: (context) {
                                              return RentalOptionDialog(
                                                data: stateData.data[index],
                                              );
                                            });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            bottom: index == 4 ? margin32 : 0,
                                            top: index == 0
                                                ? margin16
                                                : margin24 / 2),
                                        padding: EdgeInsets.all(margin16),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: neutral40)),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  stateData.data[index].brand,
                                                  style: mainBody4.copyWith(
                                                      color: neutral100,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(
                                                  height: margin8,
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                        width: margin16,
                                                        height: margin16,
                                                        child: Image.asset(
                                                            'assets/icons/users.png')),
                                                    SizedBox(
                                                      width: margin4,
                                                    ),
                                                    Text(
                                                      '${stateData.data[index].seats} Orang',
                                                      style: mainBody4.copyWith(
                                                          color: neutral50),
                                                    ),
                                                    SizedBox(
                                                      width: margin24 / 2,
                                                    ),
                                                    SizedBox(
                                                        width: margin16,
                                                        height: margin16,
                                                        child: Image.asset(
                                                            'assets/icons/users.png')),
                                                    SizedBox(
                                                      width: margin4,
                                                    ),
                                                    Text(
                                                      stateData.data[index]
                                                          .transmision,
                                                      style: mainBody5.copyWith(
                                                          color: neutral50),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: margin24 / 2,
                                                ),
                                                Text(
                                                  'mulai dari',
                                                  style: mainBody5.copyWith(
                                                      color: neutral50),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      moneyChanger(stateData
                                                          .data[index].price),
                                                      style: mainBody3.copyWith(
                                                          color:
                                                              Theme.of(context)
                                                                  .primaryColor,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      ' /hari',
                                                      style: mainBody4.copyWith(
                                                          color: neutral50),
                                                    )
                                                  ],
                                                )
                                              ],
                                            )),
                                            SizedBox(
                                              width: margin24 / 2,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              height: 60,
                                              child: (stateData.data[index]
                                                      .image.isNotEmpty)
                                                  ? Image.network(
                                                      stateData
                                                          .data[index].image,
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        return const Center(
                                                          child: Text(
                                                            'Gambar tidak tersedia',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 10,
                                                                color: Colors
                                                                    .grey),
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  : const Center(
                                                      child: Text(
                                                        'Gambar tidak tersedia',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            color: Colors.grey),
                                                      ),
                                                    ),
                                            )

                                            // SizedBox(
                                            //   width: 60,
                                            //   height: 60,
                                            //   child: Image.network(
                                            //       stateData.data[index].image),
                                            // )
                                          ],
                                        ),
                                      ));
                                }),
                              );
                            } else {
                              return Container();
                            }
                          }),
                    )),
                  ],
                );
              }

              return Container();
            }),
      ));
    });
  }
}
