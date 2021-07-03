import 'package:flutter/material.dart';
import '../models/brand.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';

class BrandPage extends StatefulWidget {
  final String routeName = "/brand";

  @override
  _BrandPageState createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  // final String routeName = "/garment-type";
  final _formKey = GlobalKey<FormState>();
  Brand _productBrand = Brand(id: '', name: '');
  List<Brand> _productBrandList = [];
  final _nameController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  var darkBlueColor = Color(0xff486579);

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshBrandList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        // backgroundBrand: Brands.grey[200],
        title: Center(
            child: Text(
          "Brands",
          // style: TextStyle(fontWeight: FontWeight.bold, productBrand: darkBlueBrand),
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
                    _productBrand.name = val;
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
              itemCount: _productBrandList.length,
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
                        _productBrandList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _productBrandList[index].id.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.delete_sweep,
                      //     productBrand: darkBlueBrand,
                      //   ),
                      //   onPressed: () async {
                      //     await _databaseHelper.deleteBrand(_productBrandList[index].id);
                      //     _resetForm();
                      //     _refreshBrandList();
                      //   },
                      // ),
                      // onTap: () {
                      //   setState(() {
                      //     _productBrand = this._productBrandList[index];
                      //     _nameController.text = this._productBrandList[index].name;
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

        if (this._productBrand.id == null || this._productBrand.id == "") {
          await _databaseHelper.insertBrand(_productBrand);
        } else {
          await _databaseHelper.updateBrand(_productBrand);
        }

        _refreshBrandList();
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
      _productBrand.id = null;
    });
  }

  _refreshBrandList() async {
    List<Brand> x = await _databaseHelper.getBrand();
    setState(() {
      _productBrandList = x;
    });
  }
}
