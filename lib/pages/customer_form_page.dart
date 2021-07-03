import 'package:flut_sqlite/pages/customer_page.dart';
import 'package:flutter/material.dart';
import '../models/customer.dart';
import '../utils/database_helper.dart';

class CustomerFormPage extends StatefulWidget {
  final String routeName = "/customer-form";

  @override
  _CustomerFormPageState createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final _formKey = GlobalKey<FormState>();
  Customer _customer = Customer(
      id: '',
      name: '',
      phoneNo: '',
      email: '',
      storeName: '',
      billingAddress: '',
      shippingAddress: '');
  final _nameController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _emailController = TextEditingController();
  final _storeNameController = TextEditingController();
  final _billingAddressController = TextEditingController();
  final _shippingAddressController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  Customer _selectedCustomer;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
  }

  @override
  Widget build(BuildContext context) {
    _selectedCustomer = ModalRoute.of(context).settings.arguments as Customer;

    if (_selectedCustomer != null) {
      this._customer = _selectedCustomer;
      _nameController.text = _customer.name;
      _phoneNoController.text = _customer.phoneNo;
      _emailController.text = _customer.email;
      _storeNameController.text = _customer.storeName;
      _shippingAddressController.text = _customer.shippingAddress;
      _billingAddressController.text = _customer.billingAddress;
    }

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Center(
            child: Text(
          "Customer Form",
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
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _customer.name = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Name'
                    : null),
                controller: _nameController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _customer.phoneNo = val;
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Phone No",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Phone No'
                    : null),
                controller: _phoneNoController,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _customer.email = val;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Email'
                    : null),
                controller: _emailController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _customer.storeName = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Store Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Store Name'
                    : null),
                controller: _storeNameController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _customer.billingAddress = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Billing Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Billing Address'
                    : null),
                controller: _billingAddressController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _customer.shippingAddress = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Shipping Address",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Shipping Address'
                    : null),
                controller: _shippingAddressController,
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

        if (this._customer.id == null || this._customer.id == "") {
          await _databaseHelper.insertCustomer(_customer);
        } else {
          await _databaseHelper.updateCustomer(_customer);
        }

        Navigator.popAndPushNamed(context, CustomerPage().routeName,
            arguments: _customer);
        // _resetForm();
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _nameController.clear();
      _customer.id = null;
    });
  }
}
