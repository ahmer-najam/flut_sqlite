import 'package:flut_sqlite/models/garment_type.dart';
import 'package:flut_sqlite/models/order_detail.dart';
import 'package:flut_sqlite/models/product.dart';
import 'package:flut_sqlite/models/product_color.dart';
import 'package:flut_sqlite/models/product_size.dart';
import 'package:flut_sqlite/models/treatment.dart';
import 'package:flut_sqlite/pages/order_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import '../models/customer.dart';
import '../utils/database_helper.dart';

class OrderDetailFormPage extends StatefulWidget {
  final String routeName = "/order-detail-form";

  @override
  _OrderDetailFormPageState createState() => _OrderDetailFormPageState();
}

class _OrderDetailFormPageState extends State<OrderDetailFormPage> {
  final _formKey = GlobalKey<FormState>();
  OrderDetail _orderDetail = OrderDetail(
    id: '',
    orderHeaderId: '',
    garmentTypeId: '',
    treatmentId: '',
    productId: '',
    productColorId: '',
    productSizeId: '',
    unitPrice: 0,
    qty: 0,
    total: 0,
  );

  final _productIdController = TextEditingController();
  final _garmentTypeIdController = TextEditingController();
  final _treatmentIdController = TextEditingController();
  final _productColorIdController = TextEditingController();
  final _productSizeIdController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _qtyController = TextEditingController();
  final _totalController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  OrderDetail _selectedOrderDetail;
  List<Product> _products;
  List<GarmentType> _garmentTypes;
  List<Treatment> _treatments;
  List<ProductColor> _productColors;
  List<ProductSize> _productSizes;
  String dropdownvalue;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;

    _refreshGarmentTypeList();
    _refreshTreatmentList();
    _refreshProductList();
    _refreshProductColorList();
    _refreshProductSizeList();

    _productIdController.text = "";
    _garmentTypeIdController.text = "";
    _treatmentIdController.text = "";
    _productSizeIdController.text = "";
    _productColorIdController.text = "";
    _unitPriceController.text = "0";
    _qtyController.text = "0";
    _totalController.text = "0";
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // _databaseHelper.getBrand().then((list) => _brands = list);

    _selectedOrderDetail =
        ModalRoute.of(context).settings.arguments as OrderDetail;

    if (_selectedOrderDetail != null) {
      this._orderDetail = _selectedOrderDetail;
      _productIdController.text = _orderDetail.productId;
      _garmentTypeIdController.text = _orderDetail.garmentTypeId;
      _treatmentIdController.text = _orderDetail.treatmentId;
      _productSizeIdController.text = _orderDetail.productSizeId;
      _productColorIdController.text = _orderDetail.productColorId;
      _unitPriceController.text = _orderDetail.unitPrice.toString();
      _qtyController.text = _orderDetail.qty.toString();
      _totalController.text = _orderDetail.total.toString();

      //var _selectedBrand = _databaseHelper.getBrandById(_orderDetail.id);
      _databaseHelper
          .getProductById(_orderDetail.productId)
          .then((value) => _productIdController.text = value);

      _databaseHelper
          .getGarmentTypeById(_orderDetail.garmentTypeId)
          .then((value) => _garmentTypeIdController.text = value);

      _databaseHelper
          .getTreatmentById(_orderDetail.treatmentId)
          .then((value) => _treatmentIdController.text = value);

      _databaseHelper
          .getProductColorById(_orderDetail.productColorId)
          .then((value) => _productColorIdController.text = value);

      _databaseHelper
          .getProductSizeById(_orderDetail.productColorId)
          .then((value) => _productSizeIdController.text = value);
    } else {}

    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Center(
            child: Text(
          "OrderDetail Form",
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
              TypeAheadFormField<Product>(
                hideSuggestionsOnKeyboardHide: true,
                suggestionsCallback: suggestProduct,
                itemBuilder: (context, Product suggestion) {
                  final product = suggestion;

                  return ListTile(
                    title: Text(product.name),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _productIdController,
                    decoration: InputDecoration(
                        labelText: "Product",
                        border: OutlineInputBorder(),
                        hintText: 'Search Product',
                        prefixIcon: Icon(Icons.search))),
                onSuggestionSelected: (Product suggestion) {
                  final product = suggestion;
                  this._productIdController.text = product.name;
                  this._orderDetail.productId = product.id;
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('Selected Product ${product.name}'),
                    ));
                },
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please select Product'
                    : null),
              ),
              SizedBox(
                height: 10,
              ),
              TypeAheadFormField<GarmentType>(
                hideSuggestionsOnKeyboardHide: true,
                suggestionsCallback: suggestGarmentType,
                itemBuilder: (context, GarmentType suggestion) {
                  final GarmentType = suggestion;

                  return ListTile(
                    title: Text(GarmentType.name),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _garmentTypeIdController,
                    decoration: InputDecoration(
                        labelText: "Garment Type",
                        border: OutlineInputBorder(),
                        hintText: 'Search Garment Type',
                        prefixIcon: Icon(Icons.search))),
                onSuggestionSelected: (GarmentType suggestion) {
                  final garmentType = suggestion;
                  this._garmentTypeIdController.text = garmentType.name;
                  this._orderDetail.garmentTypeId = garmentType.id;
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content:
                          Text('Selected Garment Type ${garmentType.name}'),
                    ));
                },
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please select Garment Type'
                    : null),
              ),
              SizedBox(
                height: 10,
              ),
              TypeAheadFormField<Treatment>(
                hideSuggestionsOnKeyboardHide: true,
                suggestionsCallback: suggestTreatment,
                itemBuilder: (context, Treatment suggestion) {
                  final treatment = suggestion;

                  return ListTile(
                    title: Text(treatment.name),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _treatmentIdController,
                    decoration: InputDecoration(
                        labelText: "Treatment",
                        border: OutlineInputBorder(),
                        hintText: 'Search Treatment Type',
                        prefixIcon: Icon(Icons.search))),
                onSuggestionSelected: (Treatment suggestion) {
                  final treatment = suggestion;
                  this._treatmentIdController.text = treatment.name;
                  this._orderDetail.treatmentId = treatment.id;
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content: Text('Selected Garment Type ${treatment.name}'),
                    ));
                },
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please select Treatment'
                    : null),
              ),
              SizedBox(
                height: 10,
              ),
              TypeAheadFormField<ProductColor>(
                hideSuggestionsOnKeyboardHide: true,
                suggestionsCallback: suggestProductColor,
                itemBuilder: (context, ProductColor suggestion) {
                  final productColor = suggestion;

                  return ListTile(
                    title: Text(productColor.name),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _productColorIdController,
                    decoration: InputDecoration(
                        labelText: "Product Color",
                        border: OutlineInputBorder(),
                        hintText: 'Search Product Color Type',
                        prefixIcon: Icon(Icons.search))),
                onSuggestionSelected: (ProductColor suggestion) {
                  final productColor = suggestion;
                  this._productColorIdController.text = productColor.name;
                  this._orderDetail.productColorId = productColor.id;
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content:
                          Text('Selected Garment Type ${productColor.name}'),
                    ));
                },
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please select Product Color'
                    : null),
              ),
              SizedBox(
                height: 10,
              ),
              TypeAheadFormField<ProductSize>(
                hideSuggestionsOnKeyboardHide: true,
                suggestionsCallback: suggestProductSize,
                itemBuilder: (context, ProductSize suggestion) {
                  final productSize = suggestion;

                  return ListTile(
                    title: Text(productSize.name),
                  );
                },
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _productSizeIdController,
                    decoration: InputDecoration(
                        labelText: "Product Size",
                        border: OutlineInputBorder(),
                        hintText: 'Search Product Size Type',
                        prefixIcon: Icon(Icons.search))),
                onSuggestionSelected: (ProductSize suggestion) {
                  final productSize = suggestion;
                  this._productSizeIdController.text = productSize.name;
                  this._orderDetail.productSizeId = productSize.id;
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(SnackBar(
                      content:
                          Text('Selected Garment Type ${productSize.name}'),
                    ));
                },
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please select Product Size'
                    : null),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _orderDetail.unitPrice = double.parse(val);
                  });
                },
                decoration: InputDecoration(
                    enabled: false,
                    labelText: "Unit Price",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Unit Price'
                    : null),
                controller: _unitPriceController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _orderDetail.qty = double.parse(val);
                  });
                },
                decoration: InputDecoration(
                    enabled: false,
                    labelText: "Qnatity",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Qnatity'
                    : null),
                controller: _qtyController,
                autofocus: true,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (val) {
                  setState(() {
                    _orderDetail.total = double.parse(val);
                  });
                },
                decoration: InputDecoration(
                    enabled: false,
                    labelText: "Total",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
                validator: (val) => (val.length == 0 || val.isEmpty
                    ? 'Please Input Total'
                    : null),
                controller: _totalController,
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

        if (this._orderDetail.id == null || this._orderDetail.id == "") {
          await _databaseHelper.insertOrderDetail(_orderDetail);
        } else {
          await _databaseHelper.updateOrderDetail(_orderDetail);
        }

        Navigator.popAndPushNamed(context, OrderDetailPage().routeName,
            arguments: _orderDetail);
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
      _productIdController.clear();
      _garmentTypeIdController.clear();
      _treatmentIdController.clear();
      _productColorIdController.clear();
      _productSizeIdController.clear();
      _unitPriceController.clear();
      _qtyController.clear();
      _totalController.clear();
      _orderDetail.id = null;
      _orderDetail.orderHeaderId = null;
    });
  }

  Future<List<Product>> suggestProduct(String query) async {
    return _products
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<GarmentType>> suggestGarmentType(String query) async {
    return _garmentTypes
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<Treatment>> suggestTreatment(String query) async {
    return _treatments
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<ProductColor>> suggestProductColor(String query) async {
    return _productColors
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<List<ProductSize>> suggestProductSize(String query) async {
    return _productSizes
        .where((element) =>
            element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  _refreshProductList() async {
    List<Product> x = await _databaseHelper.getProduct();
    setState(() {
      _products = x;
    });
  }

  _refreshGarmentTypeList() async {
    List<GarmentType> x = await _databaseHelper.getGarmentType();
    setState(() {
      _garmentTypes = x;
    });
  }

  _refreshTreatmentList() async {
    List<Treatment> x = await _databaseHelper.getTreatment();
    setState(() {
      _treatments = x;
    });
  }

  _refreshProductColorList() async {
    List<ProductColor> x = await _databaseHelper.getProductColor();
    setState(() {
      _productColors = x;
    });
  }

  _refreshProductSizeList() async {
    List<ProductSize> x = await _databaseHelper.getProductSize();
    setState(() {
      _productSizes = x;
    });
  }
}
