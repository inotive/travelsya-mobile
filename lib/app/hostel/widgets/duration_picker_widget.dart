import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/function/show_snackbar.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class HostelDurationPickerWidget extends StatefulWidget {
  final int currentData;
  const HostelDurationPickerWidget({super.key, required this.currentData});

  @override
  State<HostelDurationPickerWidget> createState() =>
      _HostelDurationPickerWidgetState();
}

class _HostelDurationPickerWidgetState
    extends State<HostelDurationPickerWidget> {
  int data = 0;

  @override
  void initState() {
    setState(() {
      data = widget.currentData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          width: 70.0.w,
          padding: EdgeInsets.symmetric(horizontal: 5.0.w),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 5.0.w, vertical: 3.0.w),
                child: Text(
                  'Durasi Sewa',
                  style: mainFont.copyWith(
                      fontSize: 11.0.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: double.infinity,
                height: 1,
                color: Colors.black12,
              ),
              SizedBox(
                height: 5.0.w,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (data > 1) {
                        setState(() {
                          data = data - 1;
                        });
                      }
                    },
                    child: Container(
                      width: 10.0.w,
                      height: 10.0.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: data == 1
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
                        data.toString(),
                        style: mainFont.copyWith(
                            fontSize: 13.0.sp, color: Colors.black87),
                      )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          data = data + 1;
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
                      Navigator.pop(context, data);
                    }, title: 'Simpan'),
                  )
                ],
              ),
              SizedBox(
                height: 5.0.w,
              )
            ],
          ),
        ),
      ),
    );
  }
}
