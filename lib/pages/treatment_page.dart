import 'package:flut_sqlite/models/treatment.dart';
import 'package:flutter/material.dart';
import '../utils/database_helper.dart';
import '../widget/drawer_main.dart';

class TreatmentPage extends StatefulWidget {
  final String routeName = "/treatment";

  @override
  _TreatmentPageState createState() => _TreatmentPageState();
}

class _TreatmentPageState extends State<TreatmentPage> {
  // final String routeName = "/garment-type";
  final _formKey = GlobalKey<FormState>();
  Treatment _productTreatment = Treatment(id: '', name: '');
  List<Treatment> _productTreatmentList = [];
  final _nameController = TextEditingController();
  DatabaseHelper _databaseHelper;
  String qrCode = "";
  var darkBlueColor = Color(0xff486579);

  @override
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper.instance;
    _refreshTreatmentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        // backgroundTreatment: Treatments.grey[200],
        title: Center(
            child: Text(
          "Treatment",
          // style: TextStyle(fontWeight: FontWeight.bold, productTreatment: darkBlueTreatment),
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
                    _productTreatment.name = val;
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
              itemCount: _productTreatmentList.length,
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
                        _productTreatmentList[index].name.toUpperCase(),
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        _productTreatmentList[index].id.toUpperCase(),
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(
                      //     Icons.delete_sweep,
                      //     productTreatment: darkBlueTreatment,
                      //   ),
                      //   onPressed: () async {
                      //     await _databaseHelper.deleteTreatment(_productTreatmentList[index].id);
                      //     _resetForm();
                      //     _refreshTreatmentList();
                      //   },
                      // ),
                      // onTap: () {
                      //   setState(() {
                      //     _productTreatment = this._productTreatmentList[index];
                      //     _nameController.text = this._productTreatmentList[index].name;
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

        if (this._productTreatment.id == null ||
            this._productTreatment.id == "") {
          await _databaseHelper.insertTreatment(_productTreatment);
        } else {
          await _databaseHelper.updateTreatment(_productTreatment);
        }

        _refreshTreatmentList();
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
      _productTreatment.id = null;
    });
  }

  _refreshTreatmentList() async {
    List<Treatment> x = await _databaseHelper.getTreatment();
    setState(() {
      _productTreatmentList = x;
    });
  }
}
