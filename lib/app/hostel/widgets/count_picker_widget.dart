import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class CountPickerWidget extends StatefulWidget {
  final int? initialValue;
  final String title;
  const CountPickerWidget({Key? key, this.initialValue, required this.title})
      : super(key: key);

  @override
  State<CountPickerWidget> createState() => _CountPickerWidgetState();
}

class _CountPickerWidgetState extends State<CountPickerWidget> {
  int selectedValue = 1;

  @override
  void initState() {
    setState(() {
      selectedValue = widget.initialValue ?? 1;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 80.0.w,
          padding: EdgeInsets.all(5.0.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: mainFont.copyWith(
                    fontSize: 13.0.sp,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 3.0.w),
                height: 1,
                width: double.infinity,
                color: Colors.black12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (selectedValue > 1) {
                        setState(() {
                          selectedValue = selectedValue - 1;
                        });
                      }
                    },
                    child: Container(
                      width: 10.0.w,
                      height: 10.0.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: selectedValue == 1
                              ? Colors.grey
                              : Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                      child: Text(
                        selectedValue.toString(),
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp, color: Colors.black87),
                      )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = selectedValue + 1;
                        });
                      },
                      child: Container(
                        width: 10.0.w,
                        height: 10.0.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: 5.0.w,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: FormHelper.borderButton(context, onTap: () {
                      Navigator.pop(context);
                    }, title: 'Batal'),
                  ),
                  SizedBox(
                    width: 3.0.w,
                  ),
                  Flexible(
                    flex: 1,
                    child: FormHelper.elevatedButtonBasic(context,
                        enabled: true, onTap: () {
                      Navigator.pop(context, selectedValue);
                    }, title: 'Simpan'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
