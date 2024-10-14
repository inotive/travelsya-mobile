import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/vm/hotel_list_vm.dart';
import 'package:travelsya/app/hotel/widgets/hotel_preview_widget.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';
import 'package:travelsya/shared/styles/font_style.dart';

class HotelListPage extends StatelessWidget {
  const HotelListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HotelListVM>.reactive(viewModelBuilder: () {
      return HotelListVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return SafeArea(
          child: Scaffold(
              appBar: appbarWidget(context, title: 'Hasil Pencarian Hotel'),
              body: BlocBuilder<HotelCubit, HotelState>(
                  bloc: model.hotelCubit,
                  builder: (context, state) {
                    if (state is HotelLoading) {
                      return ListView(
                        padding: EdgeInsets.symmetric(horizontal: margin16),
                        children: List.generate(10, (index) {
                          return PlaceHolder(
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: margin24 / 2,
                                  left: margin16,
                                  right: margin16),
                              width: double.infinity,
                              height: 100,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                            ),
                          );
                        }),
                      );
                    } else if (state is PreviewHotelListLoaded) {
                      return state.data.isEmpty
                          ? Center(
                              child: Text(
                                'Data Tidak Ditemukan',
                                style: mainFont.copyWith(fontSize: 14),
                              ),
                            )
                          : RefreshIndicator(
                              onRefresh: () async {
                                model.onInit(context);
                              },
                              color: Theme.of(context).primaryColor,
                              child: ListView(
                                children:
                                    List.generate(state.data.length, (index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        top: index == 0 ? margin16 : 0),
                                    child: HotelPreviewCard(
                                        data: state.data[index]),
                                  );
                                }),
                              ),
                            );
                    } else {
                      return FailedRequestWidget(
                        onRetry: () {
                          model.onInit(context);
                        },
                      );
                    }
                  })));
    });
  }
}
