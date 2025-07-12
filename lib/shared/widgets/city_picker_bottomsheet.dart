import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';

Future<String?> showCityPicker(BuildContext context,
    {CityPickerType type = CityPickerType.hotel}) async {
  String? result = await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      builder: (context) {
        return CityPickerBottomsheet(
          type: type,
        );
      });

  return result;
}

enum CityPickerType { hotel, bus }

class CityPickerBottomsheet extends StatefulWidget {
  final CityPickerType type;
  const CityPickerBottomsheet({super.key, this.type = CityPickerType.hotel});

  @override
  State<CityPickerBottomsheet> createState() => _CityPickerBottomsheetState();
}

class _CityPickerBottomsheetState extends State<CityPickerBottomsheet> {
  HotelCubit cityCubit = HotelCubit();

  @override
  void initState() {
    cityCubit.fetchHotelAvailableCity(context, type: widget.type);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            padding: EdgeInsets.only(
                left: margin16,
                right: margin16,
                top: margin16,
                bottom: margin8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Pilih Kota',
                    style: mainFont.copyWith(
                        fontSize: 14,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, color: Colors.black87))
              ],
            )),
        Expanded(
            child: BlocBuilder<HotelCubit, HotelState>(
                bloc: cityCubit,
                builder: (context, state) {
                  if (state is HotelLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (state is ListHotelCityLoaded) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      children: List.generate(state.data.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, state.data[index]);
                          },
                          child: Container(
                            padding: EdgeInsets.all(margin16),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(color: Colors.black12)),
                            ),
                            child: Text(
                              state.data[index],
                              style: mainBody4.copyWith(color: Colors.black87),
                            ),
                          ),
                        );
                      }),
                    );
                  }

                  return Container();
                })),
      ],
    );
  }
}
