import 'package:flutter/foundation.dart';

class GarmentType {
  static const tblGarmentType = 'garmentType';
  static const colId = 'id';
  static const colName = 'name';

  String id = '';
  String name = "";
  String mobile = "";

  GarmentType({@required this.id, @required this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colId: id, colName: name};

    return map;
  }

  GarmentType.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
  }
}
