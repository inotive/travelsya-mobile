import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';

class EWalletProviderPicker extends StatefulWidget {
  const EWalletProviderPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<EWalletProviderPicker> createState() => _EWalletProviderPickerState();
}

class _EWalletProviderPickerState extends State<EWalletProviderPicker> {
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
                Text('Cari Penyedia E-Wallet',
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
            bloc: BlocProvider.of<PPOBCubit>(context),
            builder: (context, state) {
              if (state is PPOBLoading) {
                return Expanded(
                    child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ));
              } else if (state is PPOBLoaded) {
                List<PPOBModel> dataFinal = [];

                for (var i = 0; i < state.data.ewallet.length; i++) {
                  int? indexData;
                  for (var j = 0; j < dataFinal.length; j++) {
                    if (state.data.ewallet[i].operator ==
                        dataFinal[j].operator) {
                      indexData = j;
                    }
                  }

                  if (indexData == null) {
                    dataFinal.add(state.data.ewallet[i]);
                  }
                }

                return Expanded(
                    child: ListView(
                  children: List.generate(dataFinal.length, (index) {
                    bool isShow = dataFinal[index]
                        .operator
                        .toLowerCase()
                        .contains(searchValue.toLowerCase());

                    return isShow
                        ? GestureDetector(
                            onTap: () {
                              Navigator.pop(context, dataFinal[index]);
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: neutral10Stroke))),
                                padding: EdgeInsets.all(margin16),
                                child: Text(dataFinal[index].operator,
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
