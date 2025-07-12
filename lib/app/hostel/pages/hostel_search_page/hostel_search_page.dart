import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_filter_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/vm/hostel_search_vm.dart';
import 'package:travelsya/app/hostel/widgets/hostel_preview_widget.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';

part '_hostel_search_background_section.dart';
part '_hostel_search_filter_section.dart';
part '_hostel_search_popular_section.dart';

class HostelSearchPage extends StatelessWidget {
  const HostelSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostelSearchVM>.reactive(viewModelBuilder: () {
      return HostelSearchVM();
    }, onViewModelReady: (model) {
      model.onInit(context);
    }, builder: (context, model, child) {
      return Scaffold(
        body: Stack(
          children: [
            const _HostelSearchBackgroundSection(),
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
                    _HostelSearchFilterSection(
                      model: model,
                    ),
                    SizedBox(
                      height: margin16,
                    ),
                    _HostelSearchPopularSection(model: model),
                    SizedBox(
                      height: margin32,
                    ),
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
