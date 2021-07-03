import 'package:flutter/material.dart';
import '../models/order_header.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';
import '../pages/order_header_form_page.dart';

class OrderHeaderPage extends StatefulWidget {
  final String routeName = "/order-header";

  @override
  _OrderHeaderPageState createState() => _OrderHeaderPageState();
}

class _OrderHeaderPageState extends State<OrderHeaderPage> {
  final String routeName = "/orderHeader";
  final _formKey = GlobalKey<FormState>();
  OrderHeader _orderHeader = OrderHeader(
      id: '',
      orderNumber: '',
      orderDate: DateTime.now().toIso8601String(),
      customerId: '',
      orderAmount: 0);
  List<OrderHeader> _orderHeaderList = [];

  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  OrderHeader _updatedOrderHeader;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshOrderHeaderList();
  }

  @override
  Widget build(BuildContext context) {
    _updatedOrderHeader =
        ModalRoute.of(context).settings.arguments as OrderHeader;

    if (_updatedOrderHeader != null) {
      OrderHeader x = this._orderHeaderList.firstWhere(
          (orderHeader) => orderHeader.id == _updatedOrderHeader.id);

      if (x == null) {
        this._orderHeaderList.add(_updatedOrderHeader);
      } else {
        x.orderNumber = _updatedOrderHeader.orderNumber;
        x.customerId = _updatedOrderHeader.customerId;
        x.orderDate = _updatedOrderHeader.orderDate;
        x.orderAmount = _updatedOrderHeader.orderAmount;
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          // backgroundColor: Colors.grey[200],
          title: Center(
              child: Text(
            "OrderHeaders",
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
              Navigator.pushNamed(context, OrderHeaderFormPage().routeName)
                  .then((value) {
                if (value != null) {
                  this._orderHeader = value as OrderHeader;
                  this._orderHeaderList.add(_orderHeader);
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
              itemCount: _orderHeaderList.length,
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
                        _orderHeaderList[index].orderNumber.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _orderHeaderList[index].orderAmount.toString(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _orderHeader = this._orderHeaderList[index];
                        Navigator.of(context).pushNamed(
                            OrderHeaderFormPage().routeName,
                            arguments: (_orderHeader));
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

  _refreshOrderHeaderList() async {
    List<OrderHeader> x = await _databaseHelper.getOrderHeader();
    setState(() {
      _orderHeaderList = x;
    });
  }
}
