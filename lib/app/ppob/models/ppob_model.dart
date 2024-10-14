class PLNPostpaidInquiry {
  late double tagihan;
  late String noPelanggan;
  late String refId;
  late String name;
  late String periode;

  PLNPostpaidInquiry.fromJson(Map<String, dynamic> jsonMap) {
    tagihan = double.parse(jsonMap['tagihan'].toString());
    noPelanggan = jsonMap['no_pelanggan'];
    refId = jsonMap['ref_id'];
    name = jsonMap['nama_pelanggan'];
    periode = jsonMap['bulan_tahun_tagihan'];
  }
}

class PPOBModel {
  late int id;
  late String category;

  late String code;
  late String operator;
  late String description;
  late String price;
  late String isActive;

  PPOBModel.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap['id'];
    category = jsonMap['category'];
    code = jsonMap['kode'];
    operator = jsonMap['name'];
    description = jsonMap['description'];
    price = jsonMap['price'].toString();
    isActive = jsonMap['is_active'].toString();
  }
}

class PPOBGroup {
  List<PPOBModel> data = [];
  List<PPOBModel> pulsa = [];
  List<PPOBModel> pln = [];
  PPOBModel? plnPascabayar;
  PPOBModel? plnPascaInquiry;
  List<PPOBModel> finance = [];
  List<PPOBModel> bpjs = [];

  List<PPOBModel> tvInternet = [];
  List<PPOBModel> samsat = [];
  List<PPOBModel> pdam = [];
  List<PPOBModel> ewallet = [];

  List<PPOBModel> allData = [];

  PPOBGroup.fromJson(Map<String, dynamic> jsonMap) {
    for (var i = 0; i < jsonMap['data'].length; i++) {
      PPOBModel tempData = PPOBModel.fromJson(jsonMap['data'][i]);

      allData.add(tempData);

      if (tempData.category == 'data') {
        data.add(tempData);
      } else if (tempData.category == 'pulsa') {
        pulsa.add(tempData);
      } else if (tempData.category == 'finance') {
        finance.add(tempData);
      } else if (tempData.category == 'bpjs') {
        bpjs.add(tempData);
      } else if (tempData.category == 'tv-internet') {
        tvInternet.add(tempData);
      } else if (tempData.category == 'negara') {
        if (tempData.operator.toLowerCase() == 'pdam') {
          pdam.add(tempData);
        } else if (tempData.operator.toLowerCase() == 'samsat') {
          samsat.add(tempData);
        }
      } else if (tempData.category.toLowerCase() == 'pln') {
        if (tempData.code == 'CEKPLN') {
          plnPascaInquiry = tempData;
        } else if (tempData.code == 'PAYPLN') {
          plnPascabayar = tempData;
        } else {
          pln.add(tempData);
        }
      } else if (tempData.category.toLowerCase() == 'ewallet') {
        ewallet.add(tempData);
      }
    }
  }
}
