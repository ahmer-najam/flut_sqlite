import 'package:flutter/foundation.dart';

class Customer {
  static const tblCustomer = 'customers';
  static const colId = 'id';
  static const colName = 'name';
  static const colPhoneNo = 'phoneNo';
  static const colEmail = 'email';
  static const colStoreName = 'storeName';
  static const colBillingAddress = 'billingAddress';
  static const colShippingAddress = 'shippingAddress';

  String id = '';
  String name = "";
  String phoneNo = "";
  String email = "";
  String storeName = "";
  String billingAddress = "";
  String shippingAddress = "";

  Customer(
      {@required this.id,
      @required this.name,
      @required this.phoneNo,
      @required email,
      @required storeName,
      @required billingAddress,
      @required shippingAddress});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colId: id,
      colName: name,
      colPhoneNo: phoneNo,
      colEmail: email,
      colStoreName: storeName,
      colBillingAddress: billingAddress,
      colShippingAddress: shippingAddress
    };

    return map;
  }

  Customer.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    name = map[colName];
    phoneNo = map[colPhoneNo];
    email = map[colEmail];
    storeName = map[colStoreName];
    billingAddress = map[colBillingAddress];
    shippingAddress = map[colShippingAddress];
  }
}
