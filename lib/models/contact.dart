import 'package:flutter/foundation.dart';

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
    var map = <String, dynamic>{colId: id, colName: name, colMobile: mobile};

    return map;
  }

  Contact.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
    mobile = map[colMobile];
  }
}
