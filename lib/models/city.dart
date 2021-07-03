import 'package:flutter/foundation.dart';

class City {
  static const tblCity = 'city';
  static const colId = 'id';
  static const colName = 'name';

  String id = '';
  String name = "";
  String mobile = "";

  City({@required this.id, @required this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colId: id, colName: name};

    return map;
  }

  City.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
  }
}
