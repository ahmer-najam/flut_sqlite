import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import '../models/order_header.dart';
import '../models/customer.dart';
import '../utils/database_helper.dart';
import '../pages/order_header_page.dart';

class OrderHeaderFormPage extends StatefulWidget {
  final String routeName = "/orderHeader-form";

  @override
  _OrderHeaderFormPageState createState() => _OrderHeaderFormPageState();
}

class _OrderHeaderFormPageState extends State<OrderHeaderFormPage> {
  final _formKey = GlobalKey<FormState>();
  OrderHeader _orderHeader = OrderHeader(
      id: '',
      orderNumber: '',
      customerId: '',
      orderDate: DateTime.now().toIso8601String(),
      orderAmount: 0);
  final _orderNumberController = TextEditingController();
  final _customerIdController = TextEditingController();
  final _orderDateController = TextEditingController();
  final _orderAmountController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  OrderHeader _selectedOrderHeader;
  List<Customer> _customers;
  String dropdownvalue;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;

    _refreshCustomerList();
    _orderAmountController.text = "0";
    _orderDateController.text = DateTime.now().toIso8601String();
    _orderNumberController.text = "0";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // _databaseHelper.getBrand().then((list) => _brands = list);

    _selectedOrderHeader =
        ModalRoute.of(context).settings.arguments as OrderHeader;

    if (_selectedOrderHeader != null) {
      this._orderHeader = _selectedOrderHeader;
      _orderNumberController.text = _orderHeader.orderNumber;
      _orderDateController.text = _orderHeader.orderDate;
      _customerIdController.text = _orderHeader.customerId;
      _orderAmountController.text = _orderHeader.orderAmount.toString();

      //var _selectedBrand = _databaseHelper.getBrandById(_orderHeader.id);
      _databaseHelper
          .getCustomerById(_orderHeader.customerId)
          .then((value) => _customerIdController.text = value);
    } else {}

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Center(
            child: Text(
          "OrderHeader Form",
        )),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
              child: _form(),
            ))
          ],
        ),
      ),
    );
  }

  _form() => Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TypeAheadFormField<Customer>(
                // debounceDuration: Duration(microseconds: 500),
                hideSuggestionsOnKeyboardHide: true,
                suggestionsCallback: suggestCustomer,
                itemBuilder: (context, Customer suggestion) {
                  final customer = suggestion;

                  return ListTile(
                    title: Text(customer.name),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _customerIdController,
                    decoration: InputDecoration(
                        labelText: "Customer",
                        border: OutlineInputBorder(),
                        hintText: 'Search Customer',
                        prefixIcon: Icon(Icons.search))),
                onSuggestionSelected: (Customer suggestion) {
                  final customer = suggestion;
                  this._customerIdController.text = customer.name;
                  this._orderHeader.customerId = customer.id;
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('Selected Customer ${customer.name}'),
                    ));
                },
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please select Customer'
                    : null),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _orderHeader.orderNumber = val;
                  });
                },
                decoration: InputDecoration(
                    enabled: false,
                    labelText: "Order Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Order Number'
                    : null),
                controller: _orderNumberController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _orderHeader.orderDate = DateTime.now().toIso8601String();
                  });
                },
                decoration: InputDecoration(
                    enabled: false,
                    labelText: "Order Date",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Order Date'
                    : null),
                controller: _orderDateController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _orderHeader.orderAmount = 0;
                  });
                },
                decoration: InputDecoration(
                    enabled: false,
                    labelText: "Order Amount",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Amount'
                    : null),
                controller: _orderAmountController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        onSubmit();
                      },
                      child: Text("Save")))
            ],
          ),
        ),
      );

  onSubmit() async {
    try {
      var form = _formKey.currentState;

      if (form.validate()) {
        form.save();

        if (this._orderHeader.id == null || this._orderHeader.id == "") {
          _orderHeader.orderNumber = 'ORD-10001';
          await _databaseHelper.insertOrderHeader(_orderHeader);
        } else {
          await _databaseHelper.updateOrderHeader(_orderHeader);
        }

        Navigator.popAndPushNamed(context, OrderHeaderPage().routeName,
            arguments: _orderHeader);
        // _resetForm();
      } else {
        SnackBar(content: Text("Please input correct data"));
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _orderNumberController.clear();
      _orderDateController.clear();
      _customerIdController.clear();
      _orderAmountController.clear();
      _orderHeader.id = null;
    });
  }

  Future<List<Customer>> suggestCustomer(String query) async {
    return _customers
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  _refreshCustomerList() async {
    List<Customer> x = await _databaseHelper.getCustomer();
    setState(() {
      _customers = x;
    });
  }
}
