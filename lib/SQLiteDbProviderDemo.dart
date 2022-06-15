import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_patient_app/CommonClass/CommonStrAndKey.dart';
import 'package:flutter_patient_app/Video_Call/GlobalVariable.dart';
import 'package:flutter_patient_app/Video_Call/pages/MySAWVideocallScreen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'ProductDemo.dart';

class SQLiteDbProviderDemo {
  SQLiteDbProviderDemo._();
  static final SQLiteDbProviderDemo db = SQLiteDbProviderDemo._();
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
    String path = join(documentsDirectory.path, "ProductDemoDB.db");
    return await openDatabase(
        path, version: 1,
        onOpen: (db) {},
        onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE ProductDemo ("
                  "id INTEGER PRIMARY KEY,"
                  "name TEXT,"
                  "description TEXT,"
                  "price INTEGER,"
                  "image TEXT"")"
          );
          await db.execute(
              "INSERT INTO ProductDemo ('id', 'name', 'description', 'price', 'image')values(?, ?, ?, ?, ?)",
          [1, "iPhone", "iPhone is the stylist phone ever", 1000, "iphone.png"]
          );
         /* await db.execute(
          "INSERT INTO ProductDemo ('id', 'name', 'description', 'price', 'image')
          values? (?, ?, ?, ?, ?)",
          [2, "Pixel", "Pixel is the most feature phone ever", 800, "pixel.png"]
          );
          await db.execute(
          "INSERT INTO ProductDemo ('id', 'name', 'description', 'price', 'image')
          values (?, ?, ?, ?, ?)",
          [3, "Laptop", "Laptop is most productive development tool", 2000, "laptop.png"]
          );
          await db.execute(
          "INSERT INTO ProductDemo ('id', 'name', 'description', 'price', 'image')
          values (?, ?, ?, ?, ?)",
          [4, "Tablet", "Laptop is most productive development tool", 1500, "tablet.png"]
          );
          await db.execute(
          "INSERT INTO ProductDemo ('id', 'name', 'description', 'price', 'image')
          values (?, ?, ?, ?, ?)",
          [5, "Pendrive", "Pendrive is useful storage medium", 100, "pendrive.png"]
          );
          await db.execute(
          "INSERT INTO ProductDemo ('id', 'name', 'description', 'price', 'image')
          values (?, ?, ?, ?, ?)",
          [6, "Floppy Drive", "Floppy drive is useful rescue storage medium", 20, "floppy.png"]
          );*/
        }
    );
  }
  Future<List<ProductDemo>> getAllProductDemos() async {
    final db = await database;
    List<Map<String,dynamic>>? results = await db!.query(
        "ProductDemo", columns: ProductDemo.columns, orderBy: "id ASC"
    );
    List<ProductDemo>? products =  <ProductDemo>[];
    results.forEach((result) {
      ProductDemo product = ProductDemo.fromMap(result);
      print(product.id.toString()+"ASAASASASASAASASASS========="+product.name.toString());
      //if(product.id==1) {
       // CommonStrAndKey.myCallProductDemodata = product;
     // print( CommonStrAndKey.myCallProductDemodata.id.toString()+" CommonStrAndKey.myCallProductDemodata ASAASASASASAASASASS========="+ CommonStrAndKey.myCallProductDemodata.name.toString());
     // }
      products.add(product);
    });
    return products;
  }
  Future<ProductDemo> getProductDemoById(int id) async {
    final db = await database;
    var result = await db!.query("ProductDemo", where: "id = ", whereArgs: [id]);
    ProductDemo temp=ProductDemo(0,"","",0,"");

    return result.isNotEmpty ? ProductDemo.fromMap(result.first) : temp;
  }


  insert(ProductDemo product) async {
    final db = await database;
    var maxIdResult = await db!.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM ProductDemo");
    var id = maxIdResult.first["last_inserted_id"];
    //var id = 1;
    var result = await db.rawInsert(
        "INSERT Into ProductDemo (id, name, description, price, image)"
            " VALUES (?, ?, ?, ?, ?)",
        [id, product.name, product.description, product.price, product.image]
    );
    return result;
  }
  update(ProductDemo product) async {
    final db = await database;
    var result = await db!.update(
        "ProductDemo", product.toMap(), where: "id = ?", whereArgs: [product.id]
    );
    return result;
  }
  delete(int id) async {
    final db = await database;
    db!.delete("ProductDemo", where: "id = ?", whereArgs: [id]);
  }
  deleteAllData() async {
    final db = await database;
    var maxIdResult = await db!.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM ProductDemo");
    var max = maxIdResult.first["last_inserted_id"];
    int myMax=max as int;
    for(int i=1;i<=myMax;i++)
      {
        db!.delete("ProductDemo", where: "id = ?", whereArgs: [i]);
        print("delete==="+i.toString());
      }

  }
}