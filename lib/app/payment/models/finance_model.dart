class ItemModel {
  late int id;
  late int price;
  late String phone;
  late String name;
  late String nameCek;
  late int qty;

  ItemModel(
      {required this.id,
      required this.price,
      required this.qty,
      this.nameCek = '',
      required this.phone,
      required this.name});
}
