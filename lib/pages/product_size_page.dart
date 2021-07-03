import 'package:flutter/material.dart';
import '../models/product_size.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';

class ProductSizePage extends StatefulWidget {
  final String routeName = "/product-size";

  @override
  _ProductSizePageState createState() => _ProductSizePageState();
}

class _ProductSizePageState extends State<ProductSizePage> {
  // final String routeName = "/garment-type";
  final _formKey = GlobalKey<FormState>();
  ProductSize _productProductSize = ProductSize(id: '', name: '');
  List<ProductSize> _productProductSizeList = [];
  final _nameController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  var darkBlueColor = Color(0xff486579);

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshProductSizeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        // backgroundProductSize: ProductSizes.grey[200],
        title: Center(
            child: Text(
          "Product Sizes",
          // style: TextStyle(fontWeight: FontWeight.bold, productProductSize: darkBlueProductSize),
        )),
      ),
      body: Container(
        child: Column(
          children: [
            // _form(),
            _list(),
          ],
        ),
      ),
      drawer: DrawerMain(),
      // floatingActionButton:
      //     FloatingActionButton(child: Icon(Icons.add), onPressed: () {})
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
                    _productProductSize.name = val;
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
              itemCount: _productProductSizeList.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: Icon(
                        Icons.ac_unit,
                        color: darkBlueColor,
                        size: 40,
                      ),
                      title: Text(
                        _productProductSizeList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _productProductSizeList[index].id.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.delete_sweep,
                      //     productProductSize: darkBlueProductSize,
                      //   ),
                      //   onPressed: () async {
                      //     await _databaseHelper.deleteProductSize(_productProductSizeList[index].id);
                      //     _resetForm();
                      //     _refreshProductSizeList();
                      //   },
                      // ),
                      // onTap: () {
                      //   setState(() {
                      //     _productProductSize = this._productProductSizeList[index];
                      //     _nameController.text = this._productProductSizeList[index].name;
                      //   });
                      // },
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

        if (this._productProductSize.id == null ||
            this._productProductSize.id == "") {
          await _databaseHelper.insertProductSize(_productProductSize);
        } else {
          await _databaseHelper.updateProductSize(_productProductSize);
        }

        _refreshProductSizeList();
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
      _productProductSize.id = null;
    });
  }

  _refreshProductSizeList() async {
    List<ProductSize> x = await _databaseHelper.getProductSize();
    setState(() {
      _productProductSizeList = x;
    });
  }
}
