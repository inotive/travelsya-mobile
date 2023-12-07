part of 'hotel_search_page.dart';

class _HotelSearchFilterSection extends StatelessWidget {
  final HotelVM model;
  const _HotelSearchFilterSection({required this.model});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HotelFilterCubit, HotelState>(
      bloc: BlocProvider.of<HotelFilterCubit>(context),
      builder: (context, state) {
        if (state is HotelSearchFilter) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            child: Column(
              children: [
                IntrinsicHeight(
                  child: Row(
                    children: [
                      Expanded(
                        child: TitleWithWidget(
                          title: 'Lokasi Hotel',
                          child: GestureDetector(
                            onTap: () {
                              model.onLocationPicker(context);
                            },
                            child: FormHelper.dropdownForm(context,
                                data: state.selectedLocation.isEmpty
                                    ? 'Semua Lokasi'
                                    : state.selectedLocation,
                                hintText: 'Lokasi Penginapan'),
                          ),
                        ),
                      ),
                      SizedBox(
                        width:
                            state.selectedLocation.isEmpty ? 0 : margin24 / 2,
                      ),
                      state.selectedLocation.isEmpty
                          ? const SizedBox()
                          : AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                onTap: () {
                                  model.onLocationPickerRemove(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.red),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                  ),
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
                  title: 'Tanggal Menginap',
                  child: GestureDetector(
                    onTap: () {
                      model.onDateTap(context);
                    },
                    child: FormHelper.dropdownForm(context,
                        customIcons: Icons.date_range,
                        data:
                            '${dateToReadable(DateFormat('yyyy-MM-dd').format(state.selectedTime.startDate!))} - ${dateToReadable(DateFormat('yyyy-MM-dd').format(state.selectedTime.endDate!))} (${state.selectedTime.endDate!.difference(state.selectedTime.startDate!).inDays} Hari)',
                        hintText: 'Tanggal Mengingap'),
                  ),
                ),
                SizedBox(
                  height: margin16,
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: TitleWithWidget(
                        title: 'Jumlah Kamar',
                        child: GestureDetector(
                          onTap: () {
                            model.onRoomCountChanged(context);
                          },
                          child: FormHelper.dropdownForm(context,
                              data: '${state.roomCount} Kamar',
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
                        title: 'Jumlah Tamu',
                        child: GestureDetector(
                          onTap: () {
                            model.onGuessChanged(context);
                          },
                          child: FormHelper.dropdownForm(context,
                              data: '${state.guessCount} Tamu',
                              hintText: 'Jumlah Tamu'),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: margin16,
                ),
                FormHelper.elevatedButtonBasic(context, enabled: true,
                    onTap: () {
                  model.onSearchHotel(context);
                }, title: 'Cari Hotel')
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
