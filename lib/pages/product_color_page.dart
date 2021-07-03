import 'package:flutter/material.dart';
import '../models/product_color.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';

class ProductColorPage extends StatefulWidget {
  final String routeName = "/product-color";

  @override
  _ProductColorPageState createState() => _ProductColorPageState();
}

class _ProductColorPageState extends State<ProductColorPage> {
  // final String routeName = "/product";
  final _formKey = GlobalKey<FormState>();
  ProductColor _productProductColor = ProductColor(id: '', name: '');
  List<ProductColor> _productProductColorList = [];
  final _nameController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  var darkBlueColor = Color(0xff486579);

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshProductColorList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        // backgroundProductColor: ProductColors.grey[200],
        title: Center(
            child: Text(
          "Product Colors",
          // style: TextStyle(fontWeight: FontWeight.bold, productProductColor: darkBlueProductColor),
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
                    _productProductColor.name = val;
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
              itemCount: _productProductColorList.length,
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
                        _productProductColorList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _productProductColorList[index].id.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.delete_sweep,
                      //     productProductColor: darkBlueProductColor,
                      //   ),
                      //   onPressed: () async {
                      //     await _databaseHelper.deleteProductColor(_productProductColorList[index].id);
                      //     _resetForm();
                      //     _refreshProductColorList();
                      //   },
                      // ),
                      // onTap: () {
                      //   setState(() {
                      //     _productProductColor = this._productProductColorList[index];
                      //     _nameController.text = this._productProductColorList[index].name;
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

        if (this._productProductColor.id == null ||
            this._productProductColor.id == "") {
          await _databaseHelper.insertProductColor(_productProductColor);
        } else {
          await _databaseHelper.updateProductColor(_productProductColor);
        }

        _refreshProductColorList();
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
      _productProductColor.id = null;
    });
  }

  _refreshProductColorList() async {
    List<ProductColor> x = await _databaseHelper.getProductColor();
    setState(() {
      _productProductColorList = x;
    });
  }
}
