import 'package:flutter/foundation.dart';

class Treatment {
  static const tblTreatment = 'treatment';
  static const colId = 'id';
  static const colName = 'name';

  String id = '';
  String name = "";
  String mobile = "";

  Treatment({@required this.id, @required this.name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{colId: id, colName: name};

    return map;
  }

  Treatment.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
  }
}
