import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_cubit.dart';
import 'package:travelsya/app/rental_mobil/cubits/rental_mobil_filter_state.dart';
import 'package:travelsya/app/rental_mobil/pages/rental_mobil_background_section.dart';
import 'package:travelsya/app/rental_mobil/pages/rental_mobil_detail_page.dart';
import 'package:travelsya/app/rental_mobil/viewmodel/rental_mobil_search_vm.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class RentalSearchPage extends StatelessWidget {
  const RentalSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RentalMobilSearchVM>.reactive(viewModelBuilder: () {
      return RentalMobilSearchVM();
    }, onViewModelReady: (model) {
      BlocProvider.of<RentalMobilFilterCubit>(context).onResetData();
    }, builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          body: BlocBuilder<RentalMobilFilterCubit, RentalMobilFilterState>(
              bloc: BlocProvider.of<RentalMobilFilterCubit>(context),
              builder: (context, state) {
                if (state is RentalMobilFilterLoaded) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Stack(
                        children: [
                          const RentalMobilBackgroundSection(),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              width: double.infinity,
                              height: 20,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                  color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: margin16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Area Rental',
                              style: mainBody4.copyWith(color: neutral50),
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<RentalMobilFilterCubit>(context)
                                    .onPickCity(context);
                              },
                              child: FormHelper.dropdownForm(context,
                                  data: state.data.selectedLocation,
                                  // ??
                                  //     'Semua Lokasi',
                                  hintText: 'Area Rental'),
                            ),
                            SizedBox(
                              height: margin8,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tanggal Rental',
                                        style:
                                            mainBody4.copyWith(color: neutral50),
                                      ),
                                      SizedBox(
                                        height: margin8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<RentalMobilFilterCubit>(
                                                  context)
                                              .onPickDate(context);
                                        },
                                        child: FormHelper.dropdownForm(context,
                                            data: dateToReadable(
                                                DateFormat('yyyy-MM-dd').format(
                                                    state.data.selectedDate)),
                                            customIcons: Icons.date_range,
                                            hintText: 'Tanggal Rental'),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: margin24 / 2,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Jam Pengambilan',
                                        style:
                                            mainBody4.copyWith(color: neutral50),
                                      ),
                                      SizedBox(
                                        height: margin8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<RentalMobilFilterCubit>(
                                                  context)
                                              .onPickHour(context);
                                        },
                                        child: FormHelper.dropdownForm(context,
                                            customIcons:
                                                Icons.watch_later_outlined,
                                            data:
                                                '${state.data.selectedTime.hour.toString().padLeft(2, '0')}:${state.data.selectedTime.minute.toString().padLeft(2, '0')}',
                                            hintText: 'Jam Pengambilan'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: margin24 / 2,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Durasi Rental',
                                        style:
                                            mainBody4.copyWith(color: neutral50),
                                      ),
                                      SizedBox(
                                        height: margin8,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<RentalMobilFilterCubit>(
                                                  context)
                                              .onPickDuration(context);
                                        },
                                        child: FormHelper.dropdownForm(context,
                                            data: '${state.data.duration} Hari',
                                            hintText: ''),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: margin24 / 2,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: margin24,
                                        height: margin24,
                                        child: Checkbox(
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4)),
                                            value: state.data.isWithDriver,
                                            onChanged: (value) {
                                              BlocProvider.of<
                                                          RentalMobilFilterCubit>(
                                                      context)
                                                  .onChangeDriverStatus(value!);
                                            })),
                                    SizedBox(
                                      width: margin4,
                                    ),
                                    Text(
                                      'Dengan Sopir?',
                                      style:
                                          mainBody4.copyWith(color: neutral100),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: margin32,
                            ),
                            ElevatedButtonWidget(
                                enabled: true,
                                onTap: () {
                                  final filterCubit =
                                      BlocProvider.of<RentalMobilFilterCubit>(
                                          context);
                                  final selectedLocation =
                                      filterCubit.state is RentalMobilFilterLoaded
                                          ? (filterCubit.state
                                                  as RentalMobilFilterLoaded)
                                              .data
                                              .selectedLocation
                                          : null;
        
                                  if (selectedLocation == null ||
                                      selectedLocation.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: const Text('Area Rental wajib diisi'),
                                      backgroundColor: primaryColor,
                                    ));
                                    return;
                                  }
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const RentalDetailPage()));
                                },
                                title: 'Cari Mobil')
                          ],
                        ),
                      ),
                      SizedBox(
                        height: margin32,
                      )
                    ],
                  );
                }
        
                return Container();
              }),
        ),
      );
    });
  }
}
