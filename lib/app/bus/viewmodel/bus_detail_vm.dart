import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/bus/cubits/bus_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_cubit.dart';
import 'package:travelsya/app/bus/cubits/bus_filter_state.dart';
import 'package:travelsya/app/bus/models/bus_model.dart';
import 'package:travelsya/app/bus/pages/bus_checkout_page.dart';
// import 'package:travelsya/app/bus/pages/bus_seat_page.dart';
import 'package:travelsya/shared/function/need_login_function.dart';

class BusDetailVM extends BaseViewModel {
  BusDataModel? goData;
  BusDataModel? backData;

  BusCubit busSearchCubit = BusCubit();

  onTapDetail(BuildContext context, BusDataModel data) {
    BusFilterState state = BlocProvider.of<BusFilterCubit>(context).state;
    if (state is BusFilterLoaded) {
      if (state.data.isWayBack) {
        if (goData == null) {
          goData = data;
          notifyListeners();
        } else {
          needLoginFeature(context, () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => BusCheckoutPage(
                          goData: goData!,
                          backData: data,
                        )));
          });
        }
      } else {
        needLoginFeature(context, () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => BusCheckoutPage(
                        goData: data,
                        backData: null,
                      )));
        });
      }
    }
  }

//   onTapDetail(BuildContext context, BusDataModel data) {
//   BusFilterState state = BlocProvider.of<BusFilterCubit>(context).state;
//   if (state is BusFilterLoaded) {
//     needLoginFeature(context, () async {
//       final result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (_) => BusSeatPage(
//             // data: data,
//             // selectedDate: state.data.isWayBack
//             //     ? state.data.selectedDateBack!
//             //     : state.data.selectedDateGo!,
//             // onSeatSelected: (selectedBus) {
//             //   // bisa dipakai kalau mau proses seat langsung di sini
//             // },
//           ),
//         ),
//       );

//       if (result != null && result is BusDataModel) {
//         if (state.data.isWayBack) {
//           if (goData == null) {
//             goData = result;
//             notifyListeners();
//           } else {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => BusCheckoutPage(
//                   goData: goData!,
//                   backData: result,
//                 ),
//               ),
//             );
//           }
//         } else {
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => BusCheckoutPage(
//                 goData: result,
//                 backData: null,
//               ),
//             ),
//           );
//         }
//       }
//     });
//   }
// }
}
