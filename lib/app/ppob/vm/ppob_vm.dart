import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:travelsya/app/ppob/models/ppob_model.dart';

enum PPOBTYPE {
  pdam,
  tvinternet,
  bpjs,
  pln,
  samsat,
}

class PPOBVM extends BaseViewModel {
  TextEditingController controller = TextEditingController();
  String searchValue = '';

  List<PPOBModel> getDataPPOBFromType(PPOBTYPE type,
      {required PPOBGroup data}) {
    if (type == PPOBTYPE.pdam) {
      return data.pdam;
    } else if (type == PPOBTYPE.tvinternet) {
      return data.tvInternet;
    } else if (type == PPOBTYPE.bpjs) {
      return data.bpjs;
    } else if (type == PPOBTYPE.pln) {
      return data.pln;
    } else if (type == PPOBTYPE.samsat) {
      return data.samsat;
    } else {
      List<PPOBModel> dataTemp = [];
      return dataTemp;
    }
  }

  onSearchChanged(String value) {
    searchValue = value;
    notifyListeners();
  }

  List<PPOBModel> listDataFilter(List<PPOBModel> data) {
    List<PPOBModel> dataFinal = [];

    for (var i = 0; i < data.length; i++) {
      if (data[i]
          .description
          .toLowerCase()
          .contains(searchValue.toLowerCase())) {
        dataFinal.add(data[i]);
      }
    }

    return dataFinal;
  }
}
