import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_cubit.dart';
import 'package:travelsya/app/rekreasi/cubits/recreation_state.dart';
import 'package:travelsya/app/rekreasi/models/recreation_model.dart';
import 'package:travelsya/shared/widgets/city_picker_bottomsheet.dart';

class RecreationMainVM extends BaseViewModel {
  RecreationCubit recreationCategoryCubit = RecreationCubit();
  RecreationCubit recreationPreviewCubit = RecreationCubit();
  RecreationCubit recreationCityCubit = RecreationCubit();

  int? selectedCategory;
  String? selectedCityName;
  RecreationCityModel? selectedCity;

  onChangeSelectedCity(BuildContext context) async {
    final RecreationCityModel? result = await showCityPicker<
        RecreationCityModel, RecreationCubit, RecreationState>(
      context,
      cubit: recreationCityCubit,
      fetchFunction: (cubit, BuildContext ctx) async {
        cubit.fetchRecreationAvailableCity(ctx);
      },
      isLoading: (state) => state is RecreationLoading,
      getCities: (state) => state is ListRecreationCityLoaded ? state.data : [],
      displayName: (item) => item.cityName,
    );
    if (result != null) {
      selectedCity = result;
      selectedCityName = result.cityName;
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
