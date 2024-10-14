import 'package:flutter/material.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';

class CountPickerWidget extends StatefulWidget {
  final int? initialValue;
  final String title;
  const CountPickerWidget({super.key, this.initialValue, required this.title});

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
          width: MediaQuery.of(context).size.width * 0.8,
          padding: EdgeInsets.all(margin16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: mainFont.copyWith(
                    fontSize: 15,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: margin24 / 2),
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: selectedValue == 1
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
                        selectedValue.toString(),
                        style: mainFont.copyWith(
                            fontSize: 15, color: Colors.black87),
                      )),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedValue = selectedValue + 1;
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
                          Navigator.pop(context, selectedValue);
                        },
                        title: 'Simpan'),
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
