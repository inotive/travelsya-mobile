import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelsya/app/hostel/widgets/count_picker_widget.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/multi_date_picker.dart';

class HotelFilterSheet extends StatefulWidget {
  final HotelSearchFilter data;
  const HotelFilterSheet({super.key, required this.data});

  @override
  State<HotelFilterSheet> createState() => _HotelFilterSheetState();
}

class _HotelFilterSheetState extends State<HotelFilterSheet> {
  late PickerDateRange selectedTime;
  late int roomCount;
  late int guessCount;

  @override
  void initState() {
    setState(() {
      selectedTime = widget.data.selectedTime;
      roomCount = widget.data.roomCount;
      guessCount = widget.data.guessCount;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(margin16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter',
                  style: mainFont.copyWith(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black54,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: Colors.black12,
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: margin16),
            children: [
              SizedBox(
                height: margin16,
              ),
              GestureDetector(
                onTap: () async {
                  PickerDateRange? result = await showDialog(
                      context: context,
                      builder: (context) {
                        return MultiDatePicker(
                          minDate: DateTime.now(),
                          selectedDate: selectedTime,
                        );
                      });

                  if (result != null) {
                    selectedTime = result;
                  }
                },
                child: FormHelper.dropdownForm(context,
                    customIcons: Icons.date_range,
                    data:
                        '${dateToReadable(DateFormat('yyyy-MM-dd').format(selectedTime.startDate!))} - ${dateToReadable(DateFormat('yyyy-MM-dd').format(selectedTime.endDate!))} (${selectedTime.endDate!.difference(selectedTime.startDate!).inDays} Hari)',
                    hintText: 'Tanggal Mengingap'),
              ),
              SizedBox(
                height: margin16,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        int? result = await showDialog(
                            context: context,
                            builder: (context) {
                              return CountPickerWidget(
                                title: 'Jumlah Kamar',
                                initialValue: roomCount,
                              );
                            });

                        if (result != null) {
                          setState(() {
                            roomCount = result;

                            if ((result * 3) < guessCount) {
                              guessCount = result * 3;
                            }
                          });
                        }
                      },
                      child: FormHelper.dropdownForm(context,
                          data: '$roomCount Kamar', hintText: 'Jumlah Kamar'),
                    ),
                  ),
                  SizedBox(
                    width: margin24 / 2,
                  ),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () async {
                        int? result = await showDialog(
                            context: context,
                            builder: (context) {
                              return CountPickerWidget(
                                title: 'Jumlah Tamu',
                                initialValue: guessCount,
                              );
                            });

                        if (result != null) {
                          setState(() {
                            guessCount = result;
                            int recommentGuessRoom = guessCount ~/ 3;
                            int peopleLeft =
                                (result) - (recommentGuessRoom * 3);
                            if (peopleLeft > 0) {
                              recommentGuessRoom = recommentGuessRoom + 1;
                            }

                            if (roomCount < recommentGuessRoom) {
                              roomCount = recommentGuessRoom;
                            }
                          });
                        }
                      },
                      child: FormHelper.dropdownForm(context,
                          data: '$guessCount Tamu', hintText: 'Jumlah Tamu'),
                    ),
                  ),
                ],
              ),
            ],
          )),
          Container(
            padding: EdgeInsets.all(margin16),
            child: ElevatedButtonWidget(
                enabled: true,
                onTap: () {
                  Navigator.pop(
                      context,
                      HotelSearchFilter(
                          guessCount: guessCount,
                          roomCount: roomCount,
                          selectedTime: selectedTime,
                          selectedLocation: ''));
                },
                title: 'Simpan'),
          )
        ],
      ),
    );
  }
}
