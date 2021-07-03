import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/database_helper.dart';
import '../pages/product_color_page.dart';
import '../models/contact.dart';
import '../pages/garment_type_page.dart';
import '../pages/treatment_page.dart';
import '../pages/brand_page.dart';
import '../pages/product_size_page.dart';
import '../pages/customer_page.dart';
import '../pages/customer_form_page.dart';
import '../pages/order_header_form_page.dart';
import '../pages/order_header_page.dart';
import '../pages/product_form_page.dart';
import '../pages/product_page.dart';

const darkBlueColor = Color(0xff486579);
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      // home: CityPage(),
      initialRoute: "/",
      routes: {
        "/": (context) => GarmentTypePage(),
        ProductColorPage().routeName: (context) => ProductColorPage(),
        GarmentTypePage().routeName: (context) => GarmentTypePage(),
        TreatmentPage().routeName: (context) => TreatmentPage(),
        BrandPage().routeName: (context) => BrandPage(),
        ProductSizePage().routeName: (context) => ProductSizePage(),
        CustomerPage().routeName: (context) => CustomerPage(),
        CustomerFormPage().routeName: (context) => CustomerFormPage(),
        ProductPage().routeName: (context) => ProductPage(),
        ProductFormPage().routeName: (context) => ProductFormPage(),
        OrderHeaderPage().routeName: (context) => OrderHeaderPage(),
        OrderHeaderFormPage().routeName: (context) => OrderHeaderFormPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  Contact _contact = Contact(id: '', name: '', mobile: '');
  List<Contact> _contactList = [];
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshContactList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Center(
              child: Text(
            "Flutter Sqlite",
            style: TextStyle(fontWeight: FontWeight.bold, color: darkBlueColor),
          )),
        ),
        body: Container(
          child: Column(
            children: [
              _form(),
              _list(),
            ],
          ),
        ),
        floatingActionButton:
            FloatingActionButton(child: Icon(Icons.add), onPressed: () {}));
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
                    _contact.name = val;
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
                    _contact.mobile = val;
                  });
                },
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Mobile",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Mobile'
                    : null),
                controller: _mobileController,
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

  _list() => Expanded(
        child: Card(
          color: Colors.white,
          margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
          child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: _contactList.length,
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
                        _contactList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _contactList[index].mobile,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.delete_sweep,
                          color: darkBlueColor,
                        ),
                        onPressed: () async {
                          await _databaseHelper
                              .deleteContact(_contactList[index].id);
                          _resetForm();
                          _refreshContactList();
                        },
                      ),
                      onTap: () {
                        setState(() {
                          _contact = this._contactList[index];
                          _nameController.text = this._contactList[index].name;
                          _mobileController.text =
                              this._contactList[index].mobile;
                        });
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

  onSubmit() async {
    try {
      var form = _formKey.currentState;

      if (form.validate()) {
        form.save();

        if (this._contact.id == null || this._contact.id == "") {
          await _databaseHelper.insertContact(_contact);
        } else {
          await _databaseHelper.updateContact(_contact);
        }

        _refreshContactList();
        _resetForm();
      }
    } on Exception catch (e) {
      _nameController.text = e.toString();
    }
  }

  _resetForm() {
    setState(() {
      _formKey.currentState.reset();
      _nameController.clear();
      _mobileController.clear();
      _contact.id = null;
    });
  }

  _refreshContactList() async {
    List<Contact> x = await _databaseHelper.getContact();
    setState(() {
      _contactList = x;
    });
  }

  // Future<void> scanQRCode() async {
  //   try {
  //     final qrCode = await FlutterBarcodeScanner.scanBarcode(
  //       '#ff6666',
  //       'Cancel',
  //       true,
  //       ScanMode.DEFAULT,
  //     );

  //     if (!mounted) return "";

  //     setState(() {
  //       _resetForm();

  //       if (qrCode == '' || qrCode == "-1" || qrCode == null) {
  //         this._mobileController.text = "03001230000";
  //         this._nameController.text = qrCode;
  //       } else {
  //         this._mobileController.text = qrCode;
  //         this._nameController.selection;
  //       }
  //     });
  //   } on PlatformException {
  //     qrCode = 'Failed to get platform version.';
  //   }
  // }
}
