import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:travelsya/app/ppob/cubits/ppob_cubit.dart';
import 'package:travelsya/app/ppob/cubits/ppob_state.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';

class PLNTypeBottomsheet extends StatefulWidget {
  const PLNTypeBottomsheet({super.key});

  @override
  State<PLNTypeBottomsheet> createState() => _PLNTypeBottomsheetState();
}

class _PLNTypeBottomsheetState extends State<PLNTypeBottomsheet> {
  List<String> typeData = ['Token Listrik', 'Tagihan Listrik'];

  @override
  Widget build(BuildContext context) {
    return Column(
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
                Text('Jenis Produk Listrik',
                    style: mainBody3.copyWith(fontWeight: FontWeight.bold)),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close, color: Colors.black87))
              ],
            )),
        Expanded(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: margin24 / 2),
            children: List.generate(typeData.length, (index) {
              bool isShowdata = false;

              PPOBState state = BlocProvider.of<PPOBCubit>(context).state;
              if (state is PPOBLoaded) {
                if (index == 0) {
                  if (state.data.pln.isNotEmpty) {
                    isShowdata = true;
                  }
                } else {
                  if (state.data.plnPascaInquiry != null &&
                      state.data.plnPascabayar != null) {
                    isShowdata = true;
                  }
                }
              }

              return !isShowdata
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        Navigator.pop(context, index);
                      },
                      child: Container(
                        padding: EdgeInsets.all(margin16),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(color: neutral10Stroke))),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              typeData[index],
                              style: mainBody4.copyWith(
                                  fontWeight: FontWeight.bold),
                            )),
                            SizedBox(
                              width: margin8,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    );
            }),
          ),
        )),
      ],
    );
  }
}
