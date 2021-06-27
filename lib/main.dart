import 'package:flut_sqlite/models/contact.dart';
import 'package:flut_sqlite/utils/database_helper.dart';
import 'package:flutter/material.dart';

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
      home: MyHomePage(),
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
    var form = _formKey.currentState;

    if (form.validate()) {
      form.save();
      await _databaseHelper.insertContact(_contact);
      // _contactList.add(Contact(
      //     id: _contact.id, name: _contact.name, mobile: _contact.mobile));
      form.reset();
      _refreshContactList();
      // form.reset();
      print(_contact.mobile);
    }
  }

  _refreshContactList() async {
    List<Contact> x = await _databaseHelper.getContact();
    setState(() {
      _contactList = x;
    });
  }
}
