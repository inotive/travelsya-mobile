import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class BusRouteTimelineCard extends StatelessWidget {
  final BusDataModel data;
  final DateTime selectedDate;
  final VoidCallback onTap;

  const BusRouteTimelineCard({
    super.key,
    required this.data,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
          // margin: EdgeInsets.only(top: margin16),
          padding: EdgeInsets.all(margin16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: neutral50.withOpacity(0.3)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              // Header: Business info + Price
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.bussinessName,
                          style: mainBody4.copyWith(
                            color: neutral100,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.kelas,
                          style: mainBody5.copyWith(color: neutral50),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${data.availableTicket} kursi tersedia',
                        style: mainBody5.copyWith(color: Colors.green),
                      ),
                      Row(
                        children: [
                          Text(
                            moneyChanger(data.price, customLabel: 'IDR '),
                            style: mainBody3.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' /pax',
                            style: mainBody5.copyWith(color: neutral50),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: margin16),
              // Timeline
              _buildTimeline(
                context,
                time: data.departureTime,
                date: selectedDate,
                point: data.departurePoint,
                isTop: true,
              ),
              _buildTimeline(
                context,
                time: data.arrivalTime,
                date: selectedDate,
                point: data.arrivalPoint,
                isTop: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeline(
    BuildContext context, {
    required String time,
    required DateTime date,
    required String point,
    required bool isTop,
  }) {
    String getDay(DateTime date) {
      const days = [
        'Minggu',
        'Senin',
        'Selasa',
        'Rabu',
        'Kamis',
        'Jumat',
        'Sabtu'
      ];
      return days[date.weekday % 7];
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Time & Date
          Container(
            // color: Colors.cyanAccent,
            constraints: const BoxConstraints(maxWidth: 90),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: mainBody3.copyWith(
                    color: neutral100,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${getDay(date)},\n${dateToReadable(DateFormat('yyyy-MM-dd').format(date))}',
                  style: mainBody4.copyWith(color: neutral100),
                ),
                SizedBox(
                  height: margin32,
                ),
              ],
            ),
          ),
          // Timeline line
          Container(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: Column(
              children: [
                Container(
                  width: margin8,
                  height: margin8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                if (isTop)
                  Expanded(
                    child: Container(
                      width: 1,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
              ],
            ),
          ),
          // City / Point
          Text(
            point,
            style: mainBody4.copyWith(color: neutral100),
          ),
        ],
      ),
    );
  }
}
