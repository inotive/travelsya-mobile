import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/auth/cubits/profile_cubit.dart';
import 'package:travelsya/app/auth/cubits/profile_state.dart';
import 'package:travelsya/app/hotel/cubits/hotel_cubit.dart';
import 'package:travelsya/app/hotel/cubits/hotel_state.dart';
import 'package:travelsya/app/hotel/models/hotel_detail_model.dart';
import 'package:travelsya/app/hotel/vm/hotel_form_vm.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_cubit.dart';
import 'package:travelsya/shared/cubits/fee_admin/fee_admin_state.dart';
import 'package:travelsya/shared/function/date_to_readable_function.dart';
import 'package:travelsya/shared/helper/const_helper.dart';
import 'package:travelsya/shared/helper/function_helper.dart';
import 'package:travelsya/shared/styles/font_style.dart';
import 'package:travelsya/shared/styles/size_styles.dart';
import 'package:travelsya/shared/styles/theme_style.dart';
import 'package:travelsya/shared/widgets/appbar_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_horizontal_widget.dart';
import 'package:travelsya/shared/widgets/failed_request_widget.dart';
import 'package:travelsya/shared/widgets/form_helper.dart';
import 'package:travelsya/shared/widgets/form_helper/elevated_button_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/rounded_texfield_widget.dart';
import 'package:travelsya/shared/widgets/form_helper/title_with_widget.dart';
import 'package:travelsya/shared/widgets/photo_view_list_page.dart';
import 'package:travelsya/shared/widgets/placeholder_widget.dart';

part '_hotel_checkout_info_section.dart';
part '_hotel_checkout_form_section.dart';
part '_hotel_checkout_action_section.dart';
part '_hotel_checkout_invoice_section.dart';

class HotelCheckoutPage extends StatelessWidget {
  final HotelDetailModel data;
  final HotelRoom selectedRoom;
  const HotelCheckoutPage(
      {Key? key, required this.data, required this.selectedRoom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HotelFormVM>.reactive(viewModelBuilder: () {
      return HotelFormVM();
    }, onViewModelReady: (model) {
      model.onInit(context, roomId: selectedRoom.id.toString());
    }, builder: (context, model, child) {
      return SafeArea(
        child: Scaffold(
          appBar: appbarWidget(context, title: 'Ringkasan Pesanan'),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                  child: ListView(
                children: [
                  _HotelCheckoutInfoSection(
                    data: data,
                    model: model,
                    selectedRoom: selectedRoom,
                  ),
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: neutral30,
                  ),
                  _HotelCheckoutFormSection(
                      data: data, selectedRoom: selectedRoom, model: model),
                  Container(
                    width: double.infinity,
                    height: 8,
                    color: neutral10Stroke,
                  ),
                  _HotelCheckoutInvoiceSection(
                      data: data, selectedRoom: selectedRoom, model: model),
                  SizedBox(
                    height: margin32,
                  )
                ],
              )),
              _HotelCheckoutActionSection(
                  data: data, selectedRoom: selectedRoom, model: model)
            ],
          ),
        ),
      );
    });
  }
}
