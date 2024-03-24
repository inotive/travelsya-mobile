import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';

class PajakProviderPicker extends StatefulWidget {
  final PPOBCubit pajakCubit;
  const PajakProviderPicker({Key? key, required this.pajakCubit})
      : super(key: key);

  @override
  State<PajakProviderPicker> createState() => _PajakProviderPickerState();
}

class _PajakProviderPickerState extends State<PajakProviderPicker> {
  String searchValue = '';
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: margin16, vertical: margin24 / 2),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Cari Penyedia Pajak',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, color: Colors.black87))
              ],
            )),
        Container(
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
            hintText: 'Cari Penyedia..',
          ),
        ),
        BlocBuilder<PPOBCubit, PPOBState>(
            bloc: widget.pajakCubit,
            builder: (context, state) {
              if (state is PPOBLoading) {
                return Expanded(
                    child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ));
              } else if (state is PajakPPOBLoaded) {
                return Expanded(
                    child: ListView(
                  children: List.generate(state.data.length, (index) {
                    bool isShow = state.data[index].description
                        .toLowerCase()
                        .contains(searchValue.toLowerCase());

                    return isShow
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context, state.data[index]);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: neutral10Stroke))),
                                padding: EdgeInsets.all(margin16),
                                child: Text(state.data[index].description,
                                    style: mainBody4)),
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
