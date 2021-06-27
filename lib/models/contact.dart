import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class Contact {
  static const tblContact = 'contacts';
  static const colId = 'id';
  static const colName = 'name';
  static const colMobile = 'mobile';

  String id = '';
  String name = "";
  String mobile = "";

  Contact({@required this.id, @required this.name, @required this.mobile});

  Map<String, dynamic> toMap() {
    if (id == null || id.isEmpty || id == "") {
      var uuid = new Uuid();
      id = uuid.v1();
    }

    var map = <String, dynamic>{colId: id, colName: name, colMobile: mobile};

    // if (id != null) map[colId] = id;
    return map;
  }

  Contact.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
    mobile = map[colMobile];
  }
}
