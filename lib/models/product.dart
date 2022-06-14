// ignore: file_names
class Product {
  late String? id;
  late String? name;
  late String? descrition;
  late int? qnt;
  late double? price;

  Product({this.name, this.descrition, this.qnt, this.price, this.id});

  Product.fromMap(Map<String, dynamic> map)
      : name = map["name"],
        descrition = map["descrition"],
        qnt = map["qnt"],
        price = map["price"];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "descrition": descrition,
      "qnt": qnt,
      "price": price,
    };
  }
}
