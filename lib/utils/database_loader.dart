import 'package:flut_sqlite/models/order_header.dart';
import 'package:flut_sqlite/models/product.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:uuid/uuid.dart';
import '../models/brand.dart';
import '../models/city.dart';
import '../models/customer.dart';
import '../models/garment_type.dart';
import '../models/product_size.dart';
import '../models/treatment.dart';
import '../models/product_color.dart';

class DatabaseLoader {
  onUpgrade(Database db, int oldVersion, int newVersion) async {
    _createTables(db);

    _insertProductColorRecords(db);
    _insertBrandRecords(db);
    _insertProductSizeRecords(db);
    _insertTreatmentRecords(db);
    _insertGarmentTypeRecords(db);
    _insertCustomereRecords(db);
  }

  _createTables(Database db) {
    db.execute("DROP TABLE IF EXISTS ${Brand.tblBrand}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${Brand.tblBrand}(
        ${Brand.colId} TEXT PRIMARY KEY,
        ${Brand.colName} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${ProductColor.tblProductColor}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${ProductColor.tblProductColor}(
        ${ProductColor.colId} TEXT PRIMARY KEY,
        ${ProductColor.colName} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${City.tblCity}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${City.tblCity}(
        ${City.colId} TEXT PRIMARY KEY,
        ${City.colName} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${GarmentType.tblGarmentType}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${GarmentType.tblGarmentType}(
        ${GarmentType.colId} TEXT PRIMARY KEY,
        ${GarmentType.colName} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${ProductSize.tblProductSize}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${ProductSize.tblProductSize}(
        ${ProductSize.colId} TEXT PRIMARY KEY,
        ${ProductSize.colName} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${Treatment.tblTreatment}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${Treatment.tblTreatment}(
        ${Treatment.colId} TEXT PRIMARY KEY,
        ${Treatment.colName} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${Customer.tblCustomer}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${Customer.tblCustomer}(
        ${Customer.colId} TEXT PRIMARY KEY,
        ${Customer.colName} TEXT NOT NULL,
        ${Customer.colPhoneNo} TEXT NOT NULL,
        ${Customer.colEmail} TEXT NOT NULL,
        ${Customer.colStoreName} TEXT NOT NULL,
        ${Customer.colBillingAddress} TEXT NOT NULL,
        ${Customer.colShippingAddress} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${Product.tblProduct}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${Product.tblProduct}(
        ${Product.colId} TEXT PRIMARY KEY,
        ${Product.colName} TEXT NOT NULL,
        ${Product.colBrandId} TEXT NOT NULL,
        ${Product.colBarCode} TEXT NOT NULL)
      ''');

    db.execute("DROP TABLE IF EXISTS ${OrderHeader.tblOrderHeader}");
    db.execute('''
          CREATE TABLE IF NOT EXISTS ${OrderHeader.tblOrderHeader}(
        ${OrderHeader.colId} TEXT PRIMARY KEY,
        ${OrderHeader.colOrderNumber} TEXT NOT NULL,
        ${OrderHeader.colOrderDate} TEXT NOT NULL,
        ${OrderHeader.colCustomerId} TEXT NOT NULL,
        ${OrderHeader.colOrderAmount} DOUBLE NOT NULL)
      ''');
  }

  _insertProductColorRecords(Database db) {
    Uuid uuid = new Uuid();

    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','RED');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','BLUE');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','BLACK');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','YELLOW');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','GREEN');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','WHITE');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','BROWN');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','PURPLE');
            ''');
    db.execute('''
          INSERT INTO ${ProductColor.tblProductColor} (${ProductColor.colId},${ProductColor.colName}) VALUES ('${uuid.v4()})','SOME COLOR');
            ''');
  }

  _insertBrandRecords(Database db) {
    Uuid uuid = new Uuid();

    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Tultex');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','BC');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Delta');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','NL');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Anvil');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','USA Blank');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Gildan');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','CC');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Other');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Alt Apparel');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Lane 7');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Just Hoods');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','NV');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','J America');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Port & Co');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Hanes Comfort Wash');
            ''');
    db.execute('''
          INSERT INTO ${Brand.tblBrand} (${Brand.colId},${Brand.colName}) VALUES ('${uuid.v4()})','Kavio');
            ''');
  }

  _insertProductSizeRecords(Database db) {
    Uuid uuid = new Uuid();
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

  _insertTreatmentRecords(Database db) {
    Uuid uuid = new Uuid();
    db.execute('''
          INSERT INTO ${Treatment.tblTreatment} (${Treatment.colId},${Treatment.colName}) VALUES ('${uuid.v4()})','Splatter');
            ''');
    db.execute('''
          INSERT INTO ${Treatment.tblTreatment} (${Treatment.colId},${Treatment.colName}) VALUES ('${uuid.v4()})','Patch');
            ''');
    db.execute('''
          INSERT INTO ${Treatment.tblTreatment} (${Treatment.colId},${Treatment.colName}) VALUES ('${uuid.v4()})','Dip');
            ''');
    db.execute('''
          INSERT INTO ${Treatment.tblTreatment} (${Treatment.colId},${Treatment.colName}) VALUES ('${uuid.v4()})','Invert');
            ''');
    db.execute('''
          INSERT INTO ${Treatment.tblTreatment} (${Treatment.colId},${Treatment.colName}) VALUES ('${uuid.v4()})','Crop');
            ''');
    db.execute('''
          INSERT INTO ${Treatment.tblTreatment} (${Treatment.colId},${Treatment.colName}) VALUES ('${uuid.v4()})','DTG');
            ''');
    db.execute('''
          INSERT INTO ${Treatment.tblTreatment} (${Treatment.colId},${Treatment.colName}) VALUES ('${uuid.v4()})','Screen Print');
            ''');
  }

  _insertGarmentTypeRecords(Database db) {
    Uuid uuid = new Uuid();
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','T Shirt Crew Neck');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','T Shirt V Neck');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Sweatshirt');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Hoodie');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Tank top');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Crop Top');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Long Sleeve Tee');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Scoop Neck');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Joggers');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','Some type');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','JEANS');
            ''');
    db.execute('''
          INSERT INTO ${GarmentType.tblGarmentType} (${GarmentType.colId},${GarmentType.colName}) VALUES ('${uuid.v4()})','DENIUM CLOTHING');
            ''');
  }

  _insertCustomereRecords(Database db) {
    Uuid uuid = new Uuid();
    db.execute('''
          INSERT INTO ${Customer.tblCustomer} (${Customer.colId},${Customer.colName},
          ${Customer.colPhoneNo},${Customer.colEmail},${Customer.colStoreName},
          ${Customer.colBillingAddress},${Customer.colShippingAddress}) 
          VALUES ('${uuid.v4()})','Customer-001','','','Store-001','Main Road NY','Main Road NY');
            ''');
  }
}
