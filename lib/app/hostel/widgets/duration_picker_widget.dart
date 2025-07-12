import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

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
          width: MediaQuery.of(context).size.width * 0.7,
          padding: EdgeInsets.symmetric(horizontal: margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: margin16, vertical: margin24 / 2),
                child: Text(
                  'Durasi Sewa',
                  style: mainFont.copyWith(
                      fontSize: 13,
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
                height: margin16,
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: data == 1
                              ? Colors.grey
                              : Theme.of(context).primaryColor),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: margin16),
                      child: Text(
                        data.toString(),
                        style: mainFont.copyWith(
                            fontSize: 15, color: Colors.black87),
                      )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          data = data + 1;
                        });
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Theme.of(context).primaryColor),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
              SizedBox(
                height: margin16,
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
                    width: margin24 / 2,
                  ),
                  Flexible(
                    flex: 1,
                    child: ElevatedButtonWidget(
                        enabled: true,
                        onTap: () {
                          Navigator.pop(context, data);
                        },
                        title: 'Simpan'),
                  )
                ],
              ),
              SizedBox(
                height: margin16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
