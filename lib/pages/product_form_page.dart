import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../utils/database_helper.dart';
import '../models/product.dart';
import '../models/brand.dart';
import '../pages/product_page.dart';

class ProductFormPage extends StatefulWidget {
  final String routeName = "/product-form";

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  Product _product = Product(id: '', name: '', brandId: '', barcode: '');
  final _nameController = TextEditingController();
  final _brandIdController = TextEditingController();
  final _barcodeController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  Product _selectedProduct;
  List<Brand> _brands;
  String dropdownvalue;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshBrandList();
  }

  @override
  Widget build(BuildContext context) {
    // _databaseHelper.getBrand().then((list) => _brands = list);

    _selectedProduct = ModalRoute.of(context).settings.arguments as Product;

    if (_selectedProduct != null) {
      this._product = _selectedProduct;
      _nameController.text = _product.name;
      _barcodeController.text = _product.barcode;

      //var _selectedBrand = _databaseHelper.getBrandById(_product.id);
      _databaseHelper
          .getBrandById(_product.brandId)
          .then((value) => _brandIdController.text = value);
    }

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Center(
            child: Text(
          "Product Form",
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
                    _product.name = val;
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
              TypeAheadFormField<Brand>(
                // debounceDuration: Duration(microseconds: 500),
                hideSuggestionsOnKeyboardHide: true,
                suggestionsCallback: suggestBrand,
                itemBuilder: (context, Brand suggestion) {
                  final brand = suggestion;

                  return ListTile(
                    title: Text(brand.name),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _brandIdController,
                    decoration: InputDecoration(
                        labelText: "Brand",
                        border: OutlineInputBorder(),
                        hintText: 'Search Brand',
                        prefixIcon: Icon(Icons.search))),
                onSuggestionSelected: (Brand suggestion) {
                  final brand = suggestion;
                  this._brandIdController.text = brand.name;
                  this._product.brandId = brand.id;
                  // this._brandIdController.value = brand.id;
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('Selected Brand ${brand.name}'),
                    ));
                },
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please select brand'
                    : null),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _product.barcode = val;
                  });
                },
                decoration: InputDecoration(
                    labelText: "Barcode",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Barcode'
                    : null),
                controller: _barcodeController,
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

        if (this._product.id == null || this._product.id == "") {
          await _databaseHelper.insertProduct(_product);
        } else {
          await _databaseHelper.updateProduct(_product);
        }

        Navigator.popAndPushNamed(context, ProductPage().routeName,
            arguments: _product);
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
      _nameController.clear();
      _product.id = null;
    });
  }

  _refreshBrandList() async {
    List<Brand> x = await _databaseHelper.getBrand();
    setState(() {
      _brands = x;
    });
  }

  Future<List<Brand>> suggestBrand(String query) async {
    return _brands
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
