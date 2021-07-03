import 'package:flutter/foundation.dart';

class Product {
  static const tblProduct = 'product';
  static const colId = 'id';
  static const colName = 'name';
  static const colBrandId = 'brandId';

  String id = '';
  String name = "";
  String brandId = "";

  Product({@required this.id, @required this.name, @required this.brandId});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colId: id, colName: name, colBrandId: brandId};

    return map;
  }

  Product.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
    brandId = map[colBrandId];
  }
}
