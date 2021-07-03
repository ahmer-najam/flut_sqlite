import 'package:flutter/material.dart';
import '../models/garment_type.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';

class GarmentTypePage extends StatefulWidget {
  final String routeName = "/garment-type";

  @override
  _GarmentTypePageState createState() => _GarmentTypePageState();
}

class _GarmentTypePageState extends State<GarmentTypePage> {
  // final String routeName = "/garment-type";
  final _formKey = GlobalKey<FormState>();
  GarmentType _productGarmentType = GarmentType(id: '', name: '');
  List<GarmentType> _productGarmentTypeList = [];
  final _nameController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  var darkBlueColor = Color(0xff486579);

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshGarmentTypeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        // backgroundGarmentType: GarmentTypes.grey[200],
        title: Center(
            child: Text(
          "Garment Types",
          // style: TextStyle(fontWeight: FontWeight.bold, productGarmentType: darkBlueGarmentType),
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
                    _productGarmentType.name = val;
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
              itemCount: _productGarmentTypeList.length,
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
                        _productGarmentTypeList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _productGarmentTypeList[index].id.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.delete_sweep,
                      //     productGarmentType: darkBlueGarmentType,
                      //   ),
                      //   onPressed: () async {
                      //     await _databaseHelper.deleteGarmentType(_productGarmentTypeList[index].id);
                      //     _resetForm();
                      //     _refreshGarmentTypeList();
                      //   },
                      // ),
                      // onTap: () {
                      //   setState(() {
                      //     _productGarmentType = this._productGarmentTypeList[index];
                      //     _nameController.text = this._productGarmentTypeList[index].name;
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

        if (this._productGarmentType.id == null ||
            this._productGarmentType.id == "") {
          await _databaseHelper.insertGarmentType(_productGarmentType);
        } else {
          await _databaseHelper.updateGarmentType(_productGarmentType);
        }

        _refreshGarmentTypeList();
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
      _productGarmentType.id = null;
    });
  }

  _refreshGarmentTypeList() async {
    List<GarmentType> x = await _databaseHelper.getGarmentType();
    setState(() {
      _productGarmentTypeList = x;
    });
  }
}
