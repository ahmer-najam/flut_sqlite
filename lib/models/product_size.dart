import 'package:flutter/foundation.dart';

class ProductSize {
  static const tblProductSize = 'productSize';
  static const colId = 'id';
  static const colName = 'name';

  String id = '';
  String name = "";
  String mobile = "";

  ProductSize({@required this.id, @required this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colId: id, colName: name};

    return map;
  }

  ProductSize.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
  }
}
