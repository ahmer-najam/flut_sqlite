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
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    labelText: "Mobile",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5))),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: Text("Save")))
            ],
          ),
        ),
      );
}
