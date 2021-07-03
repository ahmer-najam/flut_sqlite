import 'package:flutter/foundation.dart';

class OrderHeader {
  static const tblOrderHeader = 'orderHeader';
  static const colId = 'id';
  static const colOrderNumber = 'orderNumber';
  static const colOrderDate = 'orderDate';
  static const colCustomerId = 'customerId';
  static const colOrderAmount = 'orderAmount';

  String id = '';
  String orderNumber = "";
  String orderDate = '';
  String customerId = "";
  double orderAmount = 0;

  OrderHeader(
      {@required this.id,
      @required this.orderNumber,
      @required this.orderDate,
      @required this.customerId,
      @required this.orderAmount});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colId: id,
      colOrderNumber: orderNumber,
      colOrderDate: orderDate,
      colCustomerId: customerId,
      colOrderAmount: orderAmount
    };

    return map;
  }

  OrderHeader.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    orderNumber = map[colOrderNumber];
    orderDate = map[colOrderDate];
    customerId = map[colCustomerId];
    orderAmount = map[colOrderAmount];
  }
}
