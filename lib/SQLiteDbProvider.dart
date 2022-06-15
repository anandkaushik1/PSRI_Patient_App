import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Video_Call/GlobalVariable.dart';
import 'package:flutter_patient_app/Video_Call/pages/MySAWVideocallScreen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'Product.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null)
      return _database!;
    _database = await initDB();
    return _database!;
  }
  initDB() async {
    Directory documentsDirectory = await
    getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ProductDB.db");
    return await openDatabase(
        path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE Product ("
                  "id INTEGER PRIMARY KEY,"
                  "myAppointmentId TEXT,"
                  "myDoctorId TEXT,"
                  "doctorName TEXT,"
                  "patientName TEXT,"
                  "channelName TEXT,"
                  "price INTEGER,"
                  "image TEXT"")"
          );

          /*await db.execute(
              "INSERT INTO Product ('id', 'myAppointmentId', 'myDoctorId', 'doctorName', 'patientName', 'channelName', 'price', 'image')values(?, ?, ?, ?, ?, ?, ?, ?)",
          [1, "FirstTempValue", "iPhone is the stylist phone ever","","","", 1000, "iphone.png"]
          );*/

        }
    );
  }
  Future<List<Product>> getAllProducts() async {
    final db = await database;
    List<Map<String,dynamic>>? results = await db!.query(
        "Product", columns: Product.columns, orderBy: "id ASC"
    );
    List<Product>? products =  <Product>[];
    results.forEach((result) {
      Product product = Product.fromMap(result);
      print(product.id.toString()+"ASAASASASASAASASASS========="+product.myAppointmentId.toString());
      //if(product.id==1) {
        CommonStrAndKey.myCallProductdata = product;
     // print( CommonStrAndKey.myCallProductdata.id.toString()+" CommonStrAndKey.myCallProductdata ASAASASASASAASASASS========="+ CommonStrAndKey.myCallProductdata.name.toString());
     // }
      products.add(product);
    });
    return products;
  }
  Future<Product> getProductById(int id) async {
    final db = await database;
    var result = await db!.query("Product", where: "id = ", whereArgs: [id]);
    Product temp=Product(0,"","","","","",0,"");

    return result.isNotEmpty ? Product.fromMap(result.first) : temp;
  }
  insert(Product product) async {
    final db = await database;
    var maxIdResult = await db!.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
    var id = maxIdResult.first["last_inserted_id"];
    //var id = 1;

    var result = await db.rawInsert(
        "INSERT Into Product (id, myAppointmentId, myDoctorId, doctorName, patientName, channelName, price, image)"
            " VALUES (?, ?, ?, ?, ?, ?, ?, ?)",
        [id, product.myAppointmentId, product.myDoctorId, product.doctorName, product.patientName, product.channelName,  product.price, product.image]
    );
    return result;
  }
  update(Product product) async {
    final db = await database;
    var result = await db!.update(
        "Product", product.toMap(), where: "id = ?", whereArgs: [product.id]
    );
    return result;
  }
  delete(int id) async {
    final db = await database;
    db!.delete("Product", where: "id = ?", whereArgs: [id]);
  }
 /* deleteAllData() async {
    final db = await database;
    var maxIdResult = await db!.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Product");
    var max = maxIdResult.first["last_inserted_id"];
    int myMax=max as int;
    for(int i=1;i<=myMax;i++)
      {
        db!.delete("Product", where: "id = ?", whereArgs: [i]);
        print("delete==="+i.toString());
      }

  }*/
}