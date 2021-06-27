import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/contact.dart';

class DatabaseHelper {
  static const _databaseName = "ContactData.db";
  static const _databaseVersion = 5;

  static final DatabaseHelper instance = DatabaseHelper._();
  //single ton class
  DatabaseHelper._();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    return _database = await _initDatabase();
  }

  _initDatabase() async {
    Directory _directory = await getApplicationDocumentsDirectory();
    String dbPath = join(_directory.path, _databaseName);
    return await openDatabase(dbPath,
        version: _databaseVersion,
        onCreate: _onCreateDb,
        onUpgrade: _onUpgrade);
  }

  _onCreateDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${Contact.tblContact}(
        ${Contact.colId} TEXT PRIMARY KEY,
        ${Contact.colName} TEXT NOT NULL,
        ${Contact.colMobile} TEXT NOT NULL
      )
    ''');
    // UPGRADE DATABASE TABLES
  }

  _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (newVersion > oldVersion) {
      db.execute("DROP TABLE ${Contact.tblContact}");
      db.execute('''
          CREATE TABLE ${Contact.tblContact}(
        ${Contact.colId} TEXT PRIMARY KEY,
        ${Contact.colName} TEXT NOT NULL,
        ${Contact.colMobile} TEXT NOT NULL)
      ''');
    }

    // await db.execute('''DROP TABLE IF EXISTS ${Contact.tblContact}''');
    // await db.execute('''
    //   CREATE TABLE ${Contact.tblContact}(
    //     ${Contact.colId} TEXT PRIMARY KEY,
    //     ${Contact.colName} TEXT NOT NULL,
    //     ${Contact.colMobile} TEXT NOT NULL
    //   )
    // ''');
  }

  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    return await db.insert(Contact.tblContact, contact.toMap());
  }

  Future<int> getNewId() async {
    Database db = await database;
    List<Map> list =
        await db.rawQuery("SELECT MAX(id) FROM ${Contact.tblContact}");
    return int.parse(list[0][0]);
  }

  Future<List<Contact>> getContact() async {
    Database db = await database;
    List<Map> contacts = await db.query(Contact.tblContact);
    return contacts.length == 0
        ? []
        : contacts.map((e) => Contact.fromMap(e)).toList();
  }
}
