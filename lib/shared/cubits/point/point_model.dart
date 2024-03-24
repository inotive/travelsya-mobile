class PointModel {
  late double currentPoint;
  late double pointAvailable;

  PointModel.fromJson(Map<String, dynamic> jsonMap) {
    currentPoint = double.parse(jsonMap['currentPoint'].toString());
    pointAvailable = double.parse(jsonMap['totalPointAvailable'].toString());
  }
}
