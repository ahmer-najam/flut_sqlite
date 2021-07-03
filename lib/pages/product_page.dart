import 'package:flutter/material.dart';
import '../models/product.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';
import '../pages/product_form_page.dart';

class ProductPage extends StatefulWidget {
  final String routeName = "/product";

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final String routeName = "/product";
  final _formKey = GlobalKey<FormState>();
  Product _product = Product(id: '', name: '', brandId: '');
  List<Product> _productList = [];
  final _nameController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  final darkBlueColor = Color(0xff486579);
  Product _updatedProduct;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshProductList();
  }

  @override
  Widget build(BuildContext context) {
    _updatedProduct = ModalRoute.of(context).settings.arguments as Product;

    if (_updatedProduct != null) {
      Product x = this
          ._productList
          .firstWhere((product) => product.id == _updatedProduct.id);

      if (x == null) {
        this._productList.add(_updatedProduct);
      } else {
        x.name = _updatedProduct.name;
        x.brandId = _updatedProduct.brandId;
      }
    }

    return Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          // backgroundColor: Colors.grey[200],
          title: Center(
              child: Text(
            "Products",
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
              Navigator.pushNamed(context, ProductFormPage().routeName)
                  .then((value) {
                if (value != null) {
                  this._product = value as Product;
                  this._productList.add(_product);
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
              itemCount: _productList.length,
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
                        _productList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _productList[index].brandId.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      onTap: () {
                        _product = this._productList[index];
                        Navigator.of(context).pushNamed(
                            ProductFormPage().routeName,
                            arguments: (_product));
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

  //       if (this._product.id == null || this._product.id == "") {
  //         await _databaseHelper.insertProduct(_product);
  //       } else {
  //         await _databaseHelper.updateProduct(_product);
  //       }

  //       _refreshProductList();
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
  //     _product.id = null;
  //   });
  // }

  _refreshProductList() async {
    List<Product> x = await _databaseHelper.getProduct();
    setState(() {
      _productList = x;
    });
  }
}
