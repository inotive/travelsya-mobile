import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

class HostelCityPicker extends StatefulWidget {
  final HostelCubit dataCubit;

  const HostelCityPicker({Key? key, required this.dataCubit}) : super(key: key);

  @override
  State<HostelCityPicker> createState() => _HostelCityPickerState();
}

class _HostelCityPickerState extends State<HostelCityPicker> {
  String searchValue = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            width: 100.0.w,
            height: 7.0.h,
            padding: EdgeInsets.symmetric(horizontal: 5.0.w),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cari Kota',
                    style: mainFont.copyWith(
                        fontSize: 12.0.sp,
                        color: Colors.black87,
                        fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, color: Colors.black87))
              ],
            )),
        Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(vertical: 3.0.w, horizontal: 5.0.w),
          child: FormHelper.roundedTextfield(
            context,
            controller: controller,
            onChanged: (value) {
              setState(() {
                searchValue = value;
              });
            },
            prefixIcon: const Icon(Icons.search),
            hintText: 'Cari kota..',
          ),
        ),
        BlocBuilder<HostelCubit, HostelState>(
            bloc: widget.dataCubit,
            builder: (context, state) {
              if (state is HostelLoading) {
                return const Expanded(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              } else if (state is ListHostelCityLoaded) {
                return Expanded(
                    child: ListView(
                  children: List.generate(state.data.length, (index) {
                    bool isShow = state.data[index]
                        .toLowerCase()
                        .contains(searchValue.toLowerCase());

                    return isShow
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context, state.data[index]);
                                },
                                child: Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.all(5.0.w),
                                    width: 100.0.w,
                                    child: Text(state.data[index],
                                        style: mainFont.copyWith(
                                            fontSize: 11.0.sp,
                                            color: Colors.black87))),
                              ),
                              Container(
                                  width: 100.0.w,
                                  height: 0.3.w,
                                  color: Colors.black12)
                            ],
                          )
                        : Container();
                  }),
                ));
              }

              return Container();
            })
      ],
    );
  }
}
