import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
import '../utils/database_loader.dart';
import '../models/contact.dart';
import '../models/product_color.dart';
import '../models/city.dart';
import '../models/garment_type.dart';
import '../models/treatment.dart';
import '../models/brand.dart';
import '../models/product_size.dart';
import '../models/customer.dart';
import '../models/product.dart';
import '../models/order_header.dart';

class DatabaseHelper {
  static const _databaseName = "ContactData.db";
  static const _databaseVersion = 31;

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
        onUpgrade: DatabaseLoader().onUpgrade);
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
      Uuid uuid = new Uuid();

      db.execute("DROP TABLE IF EXISTS ${ProductSize.tblProductSize}");
      db.execute('''
          CREATE TABLE ${ProductSize.tblProductSize}(
        ${ProductSize.colId} TEXT PRIMARY KEY,
        ${ProductSize.colName} TEXT NOT NULL)
      ''');
      db.execute('''
          INSERT INTO ${ProductSize.tblProductSize} (${ProductSize.colId},${ProductSize.colName}) VALUES ('${uuid.v4()})','XS');
            ''');
      db.execute('''
          INSERT INTO ${ProductSize.tblProductSize} (${ProductSize.colId},${ProductSize.colName}) VALUES ('${uuid.v4()})','S');
            ''');
      db.execute('''
          INSERT INTO ${ProductSize.tblProductSize} (${ProductSize.colId},${ProductSize.colName}) VALUES ('${uuid.v4()})','M');
            ''');
      db.execute('''
          INSERT INTO ${ProductSize.tblProductSize} (${ProductSize.colId},${ProductSize.colName}) VALUES ('${uuid.v4()})','L');
            ''');
      db.execute('''
          INSERT INTO ${ProductSize.tblProductSize} (${ProductSize.colId},${ProductSize.colName}) VALUES ('${uuid.v4()})','XL');
            ''');
      db.execute('''
          INSERT INTO ${ProductSize.tblProductSize} (${ProductSize.colId},${ProductSize.colName}) VALUES ('${uuid.v4()})','XXL');
            ''');
      db.execute('''
          INSERT INTO ${ProductSize.tblProductSize} (${ProductSize.colId},${ProductSize.colName}) VALUES ('${uuid.v4()})','XXXL');
            ''');
    }
  }

// Contacts
  Future<int> insertContact(Contact contact) async {
    Database db = await database;
    var uuid = new Uuid();
    contact.id = uuid.v4();

    return await db.insert(Contact.tblContact, contact.toMap());
  }

  Future<int> updateContact(Contact contact) async {
    Database db = await database;
    return await db.update(Contact.tblContact, contact.toMap(),
        where: '${Contact.colId}=?', whereArgs: [contact.id]);
  }

  Future<int> deleteContact(String id) async {
    Database db = await database;
    return await db.delete(Contact.tblContact,
        where: '${Contact.colId}=?', whereArgs: [id]);
  }

  Future<List<Contact>> getContact() async {
    Database db = await database;
    List<Map> contacts = await db.query(Contact.tblContact);
    return contacts.length == 0
        ? []
        : contacts.map((e) => Contact.fromMap(e)).toList();
  }

  // Cities
  Future<int> insertCity(City city) async {
    Database db = await database;
    var uuid = new Uuid();
    city.id = uuid.v4();

    return await db.insert(City.tblCity, city.toMap());
  }

  Future<int> updateCity(City city) async {
    Database db = await database;
    return await db.update(City.tblCity, city.toMap(),
        where: '${City.colId}=?', whereArgs: [city.id]);
  }

  Future<int> deleteCity(String id) async {
    Database db = await database;
    return await db
        .delete(City.tblCity, where: '${City.colId}=?', whereArgs: [id]);
  }

  Future<List<City>> getCity() async {
    Database db = await database;
    List<Map> cities = await db.query(City.tblCity);
    return cities.length == 0
        ? []
        : cities.map((e) => City.fromMap(e)).toList();
  }

  // ProductColor
  Future<int> insertProductColor(ProductColor productColor) async {
    Database db = await database;
    var uuid = new Uuid();
    productColor.id = uuid.v4();

    return await db.insert(ProductColor.tblProductColor, productColor.toMap());
  }

  Future<int> updateProductColor(ProductColor productColor) async {
    Database db = await database;
    return await db.update(ProductColor.tblProductColor, productColor.toMap(),
        where: '${ProductColor.colId}=?', whereArgs: [productColor.id]);
  }

  Future<int> deleteProductColor(String id) async {
    Database db = await database;
    return await db.delete(ProductColor.tblProductColor,
        where: '${ProductColor.colId}=?', whereArgs: [id]);
  }

  Future<List<ProductColor>> getProductColor() async {
    Database db = await database;
    List<Map> productColors = await db.query(ProductColor.tblProductColor);
    return productColors.length == 0
        ? []
        : productColors.map((e) => ProductColor.fromMap(e)).toList();
  }

  // GarmentType
  Future<int> insertGarmentType(GarmentType garmentType) async {
    Database db = await database;
    var uuid = new Uuid();
    garmentType.id = uuid.v4();

    return await db.insert(GarmentType.tblGarmentType, garmentType.toMap());
  }

  Future<int> updateGarmentType(GarmentType garmentType) async {
    Database db = await database;
    return await db.update(GarmentType.tblGarmentType, garmentType.toMap(),
        where: '${GarmentType.colId}=?', whereArgs: [garmentType.id]);
  }

  Future<int> deleteGarmentType(String id) async {
    Database db = await database;
    return await db.delete(GarmentType.tblGarmentType,
        where: '${GarmentType.colId}=?', whereArgs: [id]);
  }

  Future<List<GarmentType>> getGarmentType() async {
    Database db = await database;
    List<Map> garmentTypes = await db.query(GarmentType.tblGarmentType);
    return garmentTypes.length == 0
        ? []
        : garmentTypes.map((e) => GarmentType.fromMap(e)).toList();
  }

  // Treatment
  Future<int> insertTreatment(Treatment treatment) async {
    Database db = await database;
    var uuid = new Uuid();
    treatment.id = uuid.v4();

    return await db.insert(Treatment.tblTreatment, treatment.toMap());
  }

  Future<int> updateTreatment(Treatment treatment) async {
    Database db = await database;
    return await db.update(Treatment.tblTreatment, treatment.toMap(),
        where: '${Treatment.colId}=?', whereArgs: [treatment.id]);
  }

  Future<int> deleteTreatment(String id) async {
    Database db = await database;
    return await db.delete(Treatment.tblTreatment,
        where: '${Treatment.colId}=?', whereArgs: [id]);
  }

  Future<List<Treatment>> getTreatment() async {
    Database db = await database;
    List<Map> treatments = await db.query(Treatment.tblTreatment);
    return treatments.length == 0
        ? []
        : treatments.map((e) => Treatment.fromMap(e)).toList();
  }

  // Brand
  Future<int> insertBrand(Brand brand) async {
    Database db = await database;
    var uuid = new Uuid();
    brand.id = uuid.v4();

    return await db.insert(Brand.tblBrand, brand.toMap());
  }

  Future<int> updateBrand(Brand brand) async {
    Database db = await database;
    return await db.update(Brand.tblBrand, brand.toMap(),
        where: '${Brand.colId}=?', whereArgs: [brand.id]);
  }

  Future<int> deleteBrand(String id) async {
    Database db = await database;
    return await db
        .delete(Brand.tblBrand, where: '${Brand.colId}=?', whereArgs: [id]);
  }

  Future<dynamic> getBrandById(String id) async {
    Database db = await database;
    List<Map> x = await db
        .query(Brand.tblBrand, where: '${Brand.colId}=?', whereArgs: [id]);
    String result = "";

    if (x.length == 0) {
      result = "";
    } else {
      List<Brand> brands = x.map((e) => Brand.fromMap(e)).toList();
      result = brands[0].name;
    }
    return result;
  }

  Future<List<Brand>> getBrand() async {
    Database db = await database;
    List<Map> brands = await db.query(Brand.tblBrand);
    return brands.length == 0
        ? []
        : brands.map((e) => Brand.fromMap(e)).toList();
  }

  // ProductSize
  Future<int> insertProductSize(ProductSize productSize) async {
    Database db = await database;
    var uuid = new Uuid();
    productSize.id = uuid.v4();

    return await db.insert(ProductSize.tblProductSize, productSize.toMap());
  }

  Future<int> updateProductSize(ProductSize productSize) async {
    Database db = await database;
    return await db.update(ProductSize.tblProductSize, productSize.toMap(),
        where: '${ProductSize.colId}=?', whereArgs: [productSize.id]);
  }

  Future<int> deleteProductSize(String id) async {
    Database db = await database;
    return await db.delete(ProductSize.tblProductSize,
        where: '${ProductSize.colId}=?', whereArgs: [id]);
  }

  Future<List<ProductSize>> getProductSize() async {
    Database db = await database;
    List<Map> productSizes = await db.query(ProductSize.tblProductSize);
    return productSizes.length == 0
        ? []
        : productSizes.map((e) => ProductSize.fromMap(e)).toList();
  }

  // Customer
  Future<dynamic> getCustomerById(String id) async {
    Database db = await database;
    List<Map> x = await db.query(Customer.tblCustomer,
        where: '${Customer.colId}=?', whereArgs: [id]);
    String result = "";

    if (x.length == 0) {
      result = "";
    } else {
      List<Customer> customers = x.map((e) => Customer.fromMap(e)).toList();
      result = customers[0].name;
    }
    return result;
  }

  Future<int> insertCustomer(Customer customer) async {
    Database db = await database;
    var uuid = new Uuid();
    customer.id = uuid.v4();

    return await db.insert(Customer.tblCustomer, customer.toMap());
  }

  Future<int> updateCustomer(Customer customer) async {
    Database db = await database;
    return await db.update(Customer.tblCustomer, customer.toMap(),
        where: '${Customer.colId}=?', whereArgs: [customer.id]);
  }

  Future<int> deleteCustomer(String id) async {
    Database db = await database;
    return await db.delete(Customer.tblCustomer,
        where: '${Customer.colId}=?', whereArgs: [id]);
  }

  Future<List<Customer>> getCustomer() async {
    Database db = await database;
    List<Map> customers = await db.query(Customer.tblCustomer);
    return customers.length == 0
        ? []
        : customers.map((e) => Customer.fromMap(e)).toList();
  }

  // Product
  Future<int> insertProduct(Product product) async {
    Database db = await database;
    var uuid = new Uuid();
    product.id = uuid.v4();

    return await db.insert(Product.tblProduct, product.toMap());
  }

  Future<int> updateProduct(Product product) async {
    Database db = await database;
    return await db.update(Product.tblProduct, product.toMap(),
        where: '${Product.colId}=?', whereArgs: [product.id]);
  }

  Future<int> deleteProduct(String id) async {
    Database db = await database;
    return await db.delete(Product.tblProduct,
        where: '${Product.colId}=?', whereArgs: [id]);
  }

  Future<List<Product>> getProduct() async {
    Database db = await database;
    List<Map> products = await db.query(Product.tblProduct);
    return products.length == 0
        ? []
        : products.map((e) => Product.fromMap(e)).toList();
  }

  // OrderHeader
  Future<int> insertOrderHeader(OrderHeader orderHeader) async {
    Database db = await database;
    var uuid = new Uuid();
    orderHeader.id = uuid.v4();

    return await db.insert(OrderHeader.tblOrderHeader, orderHeader.toMap());
  }

  Future<int> updateOrderHeader(OrderHeader orderHeader) async {
    Database db = await database;
    return await db.update(OrderHeader.tblOrderHeader, orderHeader.toMap(),
        where: '${OrderHeader.colId}=?', whereArgs: [orderHeader.id]);
  }

  Future<int> deleteOrderHeader(String id) async {
    Database db = await database;
    return await db.delete(OrderHeader.tblOrderHeader,
        where: '${OrderHeader.colId}=?', whereArgs: [id]);
  }

  Future<List<OrderHeader>> getOrderHeader() async {
    Database db = await database;
    List<Map> orderHeaders = await db.query(OrderHeader.tblOrderHeader);
    return orderHeaders.length == 0
        ? []
        : orderHeaders.map((e) => OrderHeader.fromMap(e)).toList();
  }
}
