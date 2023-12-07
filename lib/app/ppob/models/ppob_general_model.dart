class PPOBInquiryGeneralModel {
  late String name;
  late double tagihan;
  late Map<String, dynamic> rawData;

  PPOBInquiryGeneralModel.fromJson(Map<String, dynamic> jsonMap) {
    name = jsonMap['nama_pelanggan'];
    tagihan = double.parse(jsonMap['tagihan'].toString());
    rawData = jsonMap;
  }
}
