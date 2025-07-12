import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';

class HostelCityPicker extends StatefulWidget {
  final HostelCubit dataCubit;

  const HostelCityPicker({super.key, required this.dataCubit});

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
            width: double.infinity,
            height: 30,
            padding: EdgeInsets.symmetric(horizontal: margin16),
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
        Container(
          color: Colors.white,
          margin: EdgeInsets.symmetric(
              vertical: margin24 / 2, horizontal: margin16),
          child: RoundedTextfield(
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
                                    padding: EdgeInsets.all(margin16),
                                    width: double.infinity,
                                    child: Text(state.data[index],
                                        style: mainFont.copyWith(
                                            fontSize: 13,
                                            color: Colors.black87))),
                              ),
                              Container(
                                  width: double.infinity,
                                  height: 3,
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
