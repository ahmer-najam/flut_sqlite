import 'package:flutter/foundation.dart';

class OrderDetail {
  static const tblOrderDetail = 'orderDetail';
  static const colId = 'id';
  static const colOrderHeaderId = 'orderHeaderId';
  static const colProductId = 'productId';
  static const colGarmentTypeId = 'garmentTypeId';
  static const colTreatmentId = 'treatmentId';
  static const colProductColorId = 'productColorId';
  static const colProductSizeId = 'productSizeId';
  static const colUnitPrice = 'unitPrice';
  static const colQty = 'qty';
  static const colTotal = 'total';

  String id = '';
  String orderHeaderId = '';
  String productId = '';
  String garmentTypeId = '';
  String treatmentId = '';
  String productColorId = '';
  String productSizeId = '';
  double unitPrice = 0;
  double qty = 0;
  double total = 0;

  OrderDetail(
      {@required this.id,
      @required this.orderHeaderId,
      @required this.productId,
      @required this.garmentTypeId,
      @required this.treatmentId,
      @required this.productColorId,
      @required this.productSizeId,
      @required this.unitPrice,
      @required this.qty,
      @required this.total});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      colId: id,
      colOrderHeaderId: orderHeaderId,
      colProductId: productId,
      colGarmentTypeId: garmentTypeId,
      colTreatmentId: treatmentId,
      colProductColorId: productColorId,
      colProductSizeId: productSizeId,
      colUnitPrice: unitPrice,
      colQty: qty,
      colTotal: total
    };

    return map;
  }

  OrderDetail.fromMap(Map<dynamic, dynamic> map) {
    id = map[colId];
    orderHeaderId = map[colOrderHeaderId];
    productId = map[colProductId];
    garmentTypeId = map[colGarmentTypeId];
    treatmentId = map[colTreatmentId];
    productColorId = map[colProductColorId];
    productSizeId = map[colProductSizeId];
    unitPrice = map[colUnitPrice];
    qty = map[colQty];
    total = map[colTotal];
  }
}
