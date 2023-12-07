import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_filter_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/vm/hotel_vm.dart';
import 'package:travelsya/app/hotel/widgets/hotel_preview_widget.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

part '_hotel_search_background_section.dart';
part '_hotel_search_filter_section.dart';
part '_hotel_search_populer_section.dart';
part '_hotel_search_city_section.dart';

class HotelSearchPage extends StatelessWidget {
  const HotelSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HotelVM>.reactive(viewModelBuilder: () {
      return HotelVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return Scaffold(
        body: Stack(
          children: [
            const _HotelSearchBackgroundSection(),
            Positioned(
              bottom: 0,
              top: 170,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: ListView(
                  children: [
                    _HotelSearchFilterSection(
                      model: model,
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    _HotelSearchPopulerSection(model: model),
                    SizedBox(
                      height: margin16,
                    ),
                    _HotelSearchCitySection(model: model),
                    SizedBox(
                      height: margin32,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
