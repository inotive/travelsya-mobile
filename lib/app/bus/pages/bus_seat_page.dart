import 'package:flutter/material.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/pages/bus_checkout_page.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class BusSeatPage extends StatefulWidget {
  const BusSeatPage({super.key});

  @override
  State<BusSeatPage> createState() => _BusSeatPageState();
}

class _BusSeatPageState extends State<BusSeatPage> {
  String selectedPassenger = "Penumpang 1";

  final List<String> passengers = ["Penumpang 1", "Penumpang 2"];
  final List<String> columns = ["A", "B", "C", "D"];
  final int rows = 9;

  /// Multi seat selection
  final Set<String> selectedSeats = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color(0xfff5f5f5),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: margin16,
                right: margin16,
                top: margin16 + MediaQuery.of(context).padding.top,
                bottom: margin16),
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
                  'Pilih Tempat Duduk',
                  style: mainBody3.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
          SingleChildScrollView(
            padding:
                EdgeInsets.only(right: margin16, left: margin16, top: margin24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "AWR",
                  style: mainBody2.copyWith(
                      color: neutral501, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Padang -> Bukit Tinggi',
                  style: mainBody2.copyWith(
                      color: neutral501, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                const Divider(color: Colors.black, thickness: 1),
                const SizedBox(height: 12),
                Text(
                  'Ekonomi',
                  style:
                      secondaryBody5.copyWith(color: const Color(0XFF48464C)),
                ),
                const SizedBox(height: 4),
                Text(
                  'Kamis, 11 Sep 2025 - 08.30 - 3 Jam',
                  style:
                      secondaryBody5.copyWith(color: const Color(0XFF48464C)),
                ),
                const SizedBox(height: 12),

                // Dropdown
                DropdownButtonFormField<String>(
                  initialValue: selectedPassenger,
                  items: passengers
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (val) => setState(() => selectedPassenger = val!),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: margin16),

                // Legend
                Row(
                  children: [
                    _buildLegend(Colors.green, "Tersedia"),
                    SizedBox(width: margin16),
                    _buildLegend(Colors.red, "Dipilih"),
                    SizedBox(width: margin16),
                    _buildLegend(Colors.grey, "Tidak Tersedia"),
                  ],
                ),
                SizedBox(height: margin16),

                // Seat layout
                Table(
                  border: const TableBorder.symmetric(
                      inside: BorderSide(color: Colors.transparent)),
                  columnWidths: const {
                    0: FixedColumnWidth(30),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                    3: FlexColumnWidth(),
                    4: FlexColumnWidth(),
                  },
                  children: [
                    // Header
                    TableRow(
                      children: [
                        const SizedBox(),
                        ...columns.map((c) => Center(
                              child: Text(
                                c,
                                style: mainBody2,
                              ),
                            ))
                      ],
                    ),

                    // Rows
                    for (int r = 1; r <= rows; r++)
                      TableRow(
                        children: [
                          Center(child: Text(r.toString())),
                          ...columns.map((c) {
                            String seatId = "$c$r";
                            bool isUnavailable = (r == 1 && c == "D");
                            bool isSelected = selectedSeats.contains(seatId);

                            if (isUnavailable) {
                              return const Center(
                                child: Icon(Icons.directions_bus,
                                    color: Colors.black87),
                              );
                            }

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (isSelected) {
                                    selectedSeats.remove(seatId);
                                  } else {
                                    selectedSeats.add(seatId);
                                  }
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.all(4),
                                // width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: isSelected ? Colors.red : Colors.white,
                                  border: Border.all(
                                    color:
                                        isSelected ? Colors.red : Colors.black,
                                    width: 1,
                                  ),
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                  ],
                ),
                SizedBox(height: margin16),

                // Tombol Pesan
                ElevatedButtonWidget(
                    enabled: true,
                    onTap: () {
                      // final busFilter = state.data;

                      // if (busFilter.selectedCityOrigin == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //         backgroundColor: primaryColor,
                      //         content: const Text(
                      //             "Pilih kota asal terlebih dahulu")),
                      //   );
                      //   return;
                      // }

                      // if (busFilter.selectedCityDestination == null) {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //         backgroundColor: primaryColor,
                      //         content: const Text(
                      //             "Pilih kota tujuan terlebih dahulu")),
                      //   );
                      //   return;
                      // }
                      // BlocProvider.of<BusFilterCubit>(context).onSearch(context,
                      //     onSuccess: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (_) => const BusCheckoutPage(
                      //               goData: null,
                      //               backData: null,
                      //             )));
                      // });
                    },
                    title: 'Pesan')
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildLegend(Color color, String label) {
  return Row(
    children: [
      Container(
        width: 20,
        height: 20,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
      ),
      SizedBox(width: margin4),
      Text(label),
    ],
  );
}
