import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/hostel/cubits/hostel_cubit.dart';
import 'package:travelsya/app/hostel/cubits/hostel_state.dart';
import 'package:travelsya/app/hostel/models/hostel_detail_model.dart';
import 'package:travelsya/app/hostel/vm/hostel_form_vm.dart';
import 'package:travelsya/shared/api/api_connection.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';
import 'package:travelsya/shared/cubits/point/point_cubit.dart';
import 'package:travelsya/shared/cubits/point/point_state.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_horizontal_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/photo_view_list_page.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';
import 'package:travelsya/shared/widgets/statusbar_widget.dart';

part '_hostel_checkout_info_section.dart';
part '_hostel_checkout_form_section.dart';
part '_hostel_checkout_action_section.dart';
part '_hostel_checkout_invoice_section.dart';

class HostelCheckoutPage extends StatelessWidget {
  final HostelDetailModel data;
  final HostelRoom selectedRoom;
  const HostelCheckoutPage(
      {super.key, required this.data, required this.selectedRoom});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HostelFormVM>.reactive(viewModelBuilder: () {
      return HostelFormVM();
    }, onViewModelReady: (model) {
      model.onInit(context, roomId: selectedRoom.id.toString());
    }, builder: (context, model, child) {
      return StatusbarWidget(
        child: Scaffold(
          appBar: appbarWidget(context, title: 'Ringkasan Pesanan'),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  _HostelCheckoutInfoSection(
                    data: data,
                    model: model,
                    selectedRoom: selectedRoom,
                  ),
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: neutral30,
                  ),
                  _HostelCheckoutFormSection(
                      data: data, selectedRoom: selectedRoom, model: model),
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: neutral10Stroke,
                  ),
                  _HostelCheckoutInvoiceSection(
                      data: data, selectedRoom: selectedRoom, model: model),
                  SizedBox(
                    height: margin32,
                  )
                ],
              )),
              _HostelCheckoutActionSection(
                  data: data, selectedRoom: selectedRoom, model: model)
            ],
          ),
        ),
      );
    });
  }
}
