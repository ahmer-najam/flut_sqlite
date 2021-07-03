import 'package:flut_sqlite/pages/product_page.dart';
import 'package:flutter/material.dart';
import '../pages/product_color_page.dart';
import '../pages/garment_type_page.dart';
import '../pages/treatment_page.dart';
import '../pages/brand_page.dart';
import '../pages/product_size_page.dart';
import '../pages/customer_page.dart';

class DrawerMain extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function() tabHandler) {
    return ListTile(
      // leading: Icon(icon, size: 18, color: Colors.black),
      title: Text(title,
          style: TextStyle(
              // fontFamily: "RobotoCondensed",
              fontWeight: FontWeight.bold,
              fontSize: 20)),
      onTap: tabHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              "Cooking Up!",
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          buildListTile("Products", Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed(ProductPage().routeName);
          }),
          SizedBox(
            height: 5,
          ),
          buildListTile("Customers", Icons.restaurant, () {
            Navigator.of(context)
                .pushReplacementNamed(CustomerPage().routeName);
          }),
          Divider(
            thickness: 1,
          ),
          SizedBox(
            height: 5,
          ),
          buildListTile("Product Color", Icons.restaurant, () {
            Navigator.of(context)
                .pushReplacementNamed(ProductColorPage().routeName);
          }),
          SizedBox(
            height: 5,
          ),
          buildListTile("Garment Type", Icons.settings, () {
            Navigator.of(context)
                .pushReplacementNamed(GarmentTypePage().routeName);
          }),
          SizedBox(
            height: 5,
          ),
          buildListTile("Treatment", Icons.settings, () {
            Navigator.of(context)
                .pushReplacementNamed(TreatmentPage().routeName);
          }),
          SizedBox(
            height: 5,
          ),
          buildListTile("Brand", Icons.settings, () {
            Navigator.of(context).pushReplacementNamed(BrandPage().routeName);
          }),
          SizedBox(
            height: 5,
          ),
          buildListTile("Product Sizes", Icons.settings, () {
            Navigator.of(context)
                .pushReplacementNamed(ProductSizePage().routeName);
          }),
        ],
      ),
    );
  }
}
