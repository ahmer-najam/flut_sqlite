import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';
import '../pages/customer_form_page.dart';

class CustomerPage extends StatefulWidget {
  final String routeName = "/customer";

  @override
  _CustomerPageState createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final String routeName = "/customer";
  final _formKey = GlobalKey<FormState>();
  Customer _customer = Customer(
      id: '',
      name: '',
      phoneNo: '',
      email: '',
      storeName: '',
      billingAddress: '',
      shippingAddress: '');
  List<Customer> _customerList = [];
  final _nameController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  Customer _updatedCustomer;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshCustomerList();
  }

  @override
  Widget build(BuildContext context) {
    _updatedCustomer = ModalRoute.of(context).settings.arguments as Customer;

    if (_updatedCustomer != null) {
      Customer x = this
          ._customerList
          .firstWhere((customer) => customer.id == _updatedCustomer.id);

      if (x == null) {
        this._customerList.add(_updatedCustomer);
      } else {
        x.name = _updatedCustomer.name;
        x.phoneNo = _updatedCustomer.phoneNo;
        x.email = _updatedCustomer.email;
        x.storeName = _updatedCustomer.storeName;
        x.shippingAddress = _updatedCustomer.shippingAddress;
        x.billingAddress = _updatedCustomer.billingAddress;
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          // backgroundColor: Colors.grey[200],
          title: Center(
              child: Text(
            "Customers",
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
              Navigator.pushNamed(context, CustomerFormPage().routeName)
                  .then((value) {
                if (value != null) {
                  this._customer = value as Customer;
                  this._customerList.add(_customer);
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
              itemCount: _customerList.length,
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
                        _customerList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _customerList[index].id.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _customer = this._customerList[index];
                        Navigator.of(context).pushNamed(
                            CustomerFormPage().routeName,
                            arguments: (_customer));
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

  // onSubmit() async {
  //   try {
  //     var form = _formKey.currentState;

  //     if (form.validate()) {
  //       form.save();

  //       if (this._customer.id == null || this._customer.id == "") {
  //         await _databaseHelper.insertCustomer(_customer);
  //       } else {
  //         await _databaseHelper.updateCustomer(_customer);
  //       }

  //       _refreshCustomerList();
  //       _resetForm();
  //     }
  //   } on Exception catch (e) {
  //     _nameController.text = e.toString();
  //   }
  // }

  // _resetForm() {
  //   setState(() {
  //     _formKey.currentState.reset();
  //     _nameController.clear();
  //     _customer.id = null;
  //   });
  // }

  _refreshCustomerList() async {
    List<Customer> x = await _databaseHelper.getCustomer();
    setState(() {
      _customerList = x;
    });
  }
}
