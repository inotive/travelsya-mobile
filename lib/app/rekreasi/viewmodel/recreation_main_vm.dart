import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_cubit.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';

class RecreationMainVM extends BaseViewModel {
  RecreationCubit recreationCategoryCubit = RecreationCubit();
  RecreationCubit recreationPreviewCubit = RecreationCubit();

  int? selectedCategory;

  String? selectedCity;

  onChangeSelectedCity(BuildContext context) async {
    String? result = await showCityPicker(context);

    if (result != null) {
      selectedCity = result;
      notifyListeners();
    }
  }

  onChangeIndexCategory(BuildContext context, int id) {
    selectedCategory = id;
    notifyListeners();
    recreationPreviewCubit.onLoadRecreationPreviewByCategory(context,
        id: id.toString());
  }

  onLoadCategory(BuildContext context) {
    recreationCategoryCubit.fetchRecreationCategory(context,
        onDataReady: (data) {
      selectedCategory = data[0].id;
      recreationPreviewCubit.onLoadRecreationPreviewByCategory(context,
          id: data[0].id.toString());
      notifyListeners();
    });
  }
}
