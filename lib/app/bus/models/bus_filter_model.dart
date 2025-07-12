class BusFilterModel {
  String? selectedCityOrigin;
  String? selectedCityDestination;
  DateTime? selectedDateGo;
  DateTime? selectedDateBack;
  bool isWayBack = false;
  int totalPassanger = 1;

  BusFilterModel(
      {this.selectedCityOrigin,
      this.selectedCityDestination,
      this.selectedDateGo,
      this.selectedDateBack,
      this.isWayBack = false,
      this.totalPassanger = 1});
}
