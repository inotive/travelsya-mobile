import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:travelsya/shared/styles/font_style.dart';

class DateSinglePicker extends StatefulWidget {
  final DateTime? selectedDate;
  final DateTime? minDate;
  final DateTime? maxDate;
  const DateSinglePicker(
      {Key? key, this.selectedDate, this.minDate, this.maxDate})
      : super(key: key);

  @override
  _DateSinglePickerState createState() => _DateSinglePickerState();
}

class _DateSinglePickerState extends State<DateSinglePicker> {
  DateRangePickerController dateController = DateRangePickerController();
  DateTime? selectedDate;

  @override
  void initState() {
    if (widget.selectedDate != null) {
      setState(() {
        selectedDate = widget.selectedDate;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
    return Center(
      child: Container(
          width: 85.0.w,
          padding: EdgeInsets.all(5.0.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Pilih Tanggal',
                    style: mainFont.copyWith(
                        fontSize: 12.0.sp,
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
                      ))
                ],
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black12,
                margin: EdgeInsets.symmetric(vertical: 3.0.w),
              ),
              SfDateRangePicker(
                controller: dateController,
                selectionMode: DateRangePickerSelectionMode.single,
                minDate: widget.minDate ??
                    DateTime.now().add(const Duration(days: (-360 * 15))),
                maxDate: widget.maxDate ??
                    DateTime.now().add(const Duration(days: (360 * 15))),
                onSelectionChanged:
                    (DateRangePickerSelectionChangedArgs value) {
                  setState(() {
                    selectedDate = value.value;
                  });

                  // if (endDaysOff != null) {
                  //   Duration duration = endDaysOff!.difference(startDaysOff!);
                  //   print(duration.inDays);
                  //   if (duration.inDays > 10) {
                  //     Fluttertoast.showToast(msg: 'Maksimal 10 Hari');
                  //     setState(() {
                  //       endDaysOff = null;
                  //       dateController.selectedRange =
                  //           PickerDateRange(startDaysOff, endDaysOff);
                  //     });
                  //   }
                  // }
                },
              ),
              SizedBox(height: 5.0.w),
              Row(children: [
                Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 3.0.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                                color: Theme.of(context).primaryColor)),
                        child: Text(
                          'Batal',
                          style: mainFont.copyWith(
                              fontSize: 12.0.sp,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
                SizedBox(width: 2.0.w),
                Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (selectedDate != null) {
                          Navigator.pop(context, selectedDate);
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 3.0.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: selectedDate == null
                                ? Colors.grey
                                : Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: Text(
                          'Pilih',
                          style: mainFont.copyWith(
                              fontSize: 12.0.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )),
              ])
            ],
          )),
    );
  }
}
