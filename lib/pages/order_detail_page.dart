import 'package:flutter/material.dart';
import '../models/order_detail.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';
import '../pages/order_detail_form_page.dart';

class OrderDetailPage extends StatefulWidget {
  final String routeName = "/order-detail";

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  final String routeName = "/order-detail";
  final _formKey = GlobalKey<FormState>();
  OrderDetail _orderDetail = OrderDetail(
      id: '',
      orderHeaderId: '',
      garmentTypeId: '',
      treatmentId: '',
      productColorId: '',
      productSizeId: '',
      productId: '',
      unitPrice: 0,
      qty: 0,
      total: 0);

  List<OrderDetail> _orderDetailList = [];

  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  OrderDetail _updatedOrderDetail;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshOrderDetailList();
  }

  @override
  Widget build(BuildContext context) {
    _updatedOrderDetail =
        ModalRoute.of(context).settings.arguments as OrderDetail;

    if (_updatedOrderDetail != null) {
      OrderDetail x = this._orderDetailList.firstWhere(
          (orderDetail) => orderDetail.id == _updatedOrderDetail.id);

      if (x == null) {
        this._orderDetailList.add(_updatedOrderDetail);
      } else {
        x.orderHeaderId = _updatedOrderDetail.orderHeaderId;
        x.productId = _updatedOrderDetail.productId;
        x.garmentTypeId = _updatedOrderDetail.garmentTypeId;
        x.treatmentId = _updatedOrderDetail.treatmentId;
        x.productColorId = _updatedOrderDetail.productColorId;
        x.productSizeId = _updatedOrderDetail.productSizeId;
        x.unitPrice = _updatedOrderDetail.unitPrice;
        x.qty = _updatedOrderDetail.qty;
        x.total = _updatedOrderDetail.total;
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          // backgroundColor: Colors.grey[200],
          title: Center(
              child: Text(
            "OrderDetails",
            // style: TextStyle(fontWeight: FontWeight.bold, color: darkBlueColor),
          )),
        ),
        body: Container(
          child: Column(
            children: [
              _list(),
            ],
          ),
        ),
        drawer: DrawerMain(),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, OrderDetailFormPage().routeName)
                  .then((value) {
                if (value != null) {
                  this._orderDetail = value as OrderDetail;
                  this._orderDetailList.add(_orderDetail);
                  setState(() {});
                }
              });
            }));
  }

  _list() => Expanded(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _orderDetailList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        color: darkBlueColor,
                        size: 40,
                      ),
                      title: Text(
                        _orderDetailList[index].productId.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _orderDetailList[index].unitPrice.toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _orderDetail = this._orderDetailList[index];
                        Navigator.of(context).pushNamed(
                            OrderDetailFormPage().routeName,
                            arguments: (_orderDetail));
                      },
                    ),
                    Divider(
                      height: 5,
                    )
                  ],
                );
              }),
        ),
      );

  _refreshOrderDetailList() async {
    List<OrderDetail> x = await _databaseHelper.getOrderDetail();
    setState(() {
      _orderDetailList = x;
    });
  }
}
