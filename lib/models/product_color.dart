import 'package:flutter/foundation.dart';

class ProductColor {
  static const tblProductColor = 'productColor';
  static const colId = 'id';
  static const colName = 'name';

  String id = '';
  String name = "";
  String mobile = "";

  ProductColor({@required this.id, @required this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colId: id, colName: name};

    return map;
  }

  ProductColor.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
  }
}
