import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import '../models/contact.dart';
import '../utils/database_helper.dart';

class ContactData {
  Future<Database> dataHandler;
  get database => DatabaseHelper.instance.database;

  // Future<int> insertContact(Contact contact) async {
  //   Database db = await DatabaseHelper.instance.database;
  //   var uuid = new Uuid();
  //   contact.id = uuid.v4();

  //   return await db.insert(Contact.tblContact, contact.toMap());
  // }

  // Future<int> updateContact(Contact contact) async {
  //   Database db = await DatabaseHelper.instance.database;
  //   return await db.update(Contact.tblContact, contact.toMap(),
  //       where: '${Contact.colId}=?', whereArgs: [contact.id]);
  // }

  Future<List<Contact>> getContact() async {
    Database db = await DatabaseHelper.instance.database;
    List<Contact> contacts = [];

    await db.query(Contact.tblContact).then((value) => contacts);
  }
}
