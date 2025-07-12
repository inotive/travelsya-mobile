part of 'hostel_search_page.dart';

class _HostelSearchFilterSection extends StatelessWidget {
  final HostelSearchVM model;
  const _HostelSearchFilterSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HostelFilterCubit, HostelState>(
      bloc: BlocProvider.of<HostelFilterCubit>(context),
      builder: (context, state) {
        if (state is HostelSearchFilter) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: TitleWithWidget(
                          title: 'Lokasi Hostel',
                          child: GestureDetector(
                            onTap: () {
                              model.onLocationPicker(context);
                            },
                            child: FormHelper.dropdownForm(context,
                                data: state.selectedCity.isEmpty
                                    ? 'Semua Lokasi'
                                    : state.selectedCity,
                                hintText: 'Lokasi Penginapan'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: state.selectedCity.isEmpty ? 0 : margin24 / 2,
                      ),
                      state.selectedCity.isEmpty
                          ? const SizedBox()
                          : GestureDetector(
                              onTap: () {
                                model.onLocationPickerRemove(context);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.red),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              ),
                            )
                    ],
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                TitleWithWidget(
                    title: 'Durasi Sewa',
                    customMargin: margin4,
                    child: Row(
                      children: [
                        SizedBox(
                            width: 100,
                            child: GestureDetector(
                              onTap: () {
                                model.onDurationTotalPicker(context);
                              },
                              child: FormHelper.dropdownForm(context,
                                  data: state.totalDuration.toString(),
                                  hintText: 'Durasi'),
                            )),
                        SizedBox(
                          width: margin24 / 2,
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              model.onDurationTypePicker(context);
                            },
                            child: FormHelper.dropdownForm(context,
                                data: state.selectedDuration,
                                hintText: 'Pilih Jenis Durasi'),
                          ),
                        ),
                      ],
                    )),
                SizedBox(
                  height: margin16,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TitleWithWidget(
                          title: 'Mulai Sewa',
                          child: GestureDetector(
                            onTap: () {
                              model.onStartDatePicker(context);
                            },
                            child: FormHelper.dropdownForm(context,
                                customIcons: Icons.date_range,
                                data: dateToReadable(DateFormat('yyyy-MM-dd')
                                    .format(state.startDate)),
                                hintText: 'Mulai Sewa'),
                          )),
                    ),
                    SizedBox(
                      width: margin24 / 2,
                    ),
                    Flexible(
                      flex: 1,
                      child: TitleWithWidget(
                          title: 'Sewa Berakhir',
                          child: FormHelper.dropdownForm(context,
                              customIcons: Icons.date_range,
                              customWidget: Text(model.getEndSewa(context),
                                  style: mainBody4.copyWith(
                                      color: Colors.black38)),
                              data: '',
                              hintText: 'Tanggal Mengingap')),
                    ),
                  ],
                ),
                SizedBox(
                  height: margin16,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TitleWithWidget(
                        title: 'Tipe Properti',
                        child: GestureDetector(
                          onTap: () {
                            model.onPropertyTypePicker(context);
                          },
                          child: FormHelper.dropdownForm(context,
                              data: state.propertyType,
                              hintText: 'Jumlah Kamar'),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: margin24 / 2,
                    ),
                    Flexible(
                      flex: 1,
                      child: TitleWithWidget(
                        title: 'Tipe Kamar',
                        child: GestureDetector(
                          onTap: () {
                            model.onRoomTypePicker(context);
                          },
                          child: FormHelper.dropdownForm(context,
                              data: state.roomType, hintText: 'Jumlah Kamar'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: margin24 / 2,
                ),
                TitleWithWidget(
                  title: 'Tipe Furnish',
                  child: GestureDetector(
                    onTap: () {
                      model.onFurnishPicker(context);
                    },
                    child: FormHelper.dropdownForm(context,
                        data: state.furnishType, hintText: 'Jumlah Kamar'),
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                ElevatedButtonWidget(
                    enabled: true,
                    onTap: () {
                      model.onSearchHostel(context);
                    },
                    title: 'Cari Hostel')
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
