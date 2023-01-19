import 'package:flutter/foundation.dart';
import 'package:miam/Menu/models/ingredient.dart';
import 'package:sqflite/sqflite.dart' as sql;

class DatabaseHelper {
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'miamdatabase.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }
  static Future<void> createTables(sql.Database db) async {
    await db.execute("""CREATE TABLE items( id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,title TEXT,description TEXT, createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)""");
    await db.execute("""CREATE TABLE ElementIg(	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,	nom TEXT);""");
    await db.execute("""CREATE TABLE Ingredient(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, idElement INTEGER, quantite DOUBLE, FOREIGN KEY (idElement) REFERENCES ElementIg(id) ) """);
    await db.execute("""CREATE TABLE Recette(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, titre TEXT, etapes TEXT, tmpPreparation DOUBLE, tmpCuisson DOUBLE, calories DOUBLE, estEquilibre TEXT)  """);
    await db.execute("""CREATE TABLE IngredientInRecette(idRecette INTEGER,idIngredient INTEGER, PRIMARY KEY (idRecette, idIngredient), FOREIGN KEY (idRecette) REFERENCES Recette(id),FOREIGN KEY (idIngredient) REFERENCES Ingredient(id)  )""");

  }

  // ITEMS
  static Future<int> createItem(String? title, String? descrption) async {
    final db = await DatabaseHelper.db();
    final data = {'title': title, 'description': descrption};
    return await db.insert('items', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await DatabaseHelper.db();
    return db.query('items', orderBy: "id");
  }
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  static Future<int> updateItem(int id, String title, String? descrption) async {
    final db = await DatabaseHelper.db();
    final data = {'title': title,'description': descrption,'createdAt': DateTime.now().toString()};
    return await db.update('items', data, where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
  // ELEMENTSIG
  static Future<int> createElementIg(String? nom) async {
    final db = await DatabaseHelper.db();
    final data = {'nom': nom};
    return await db.insert('ElementIg', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<ElementIg>> getElementIgs() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res = await db.query('ElementIg', orderBy: "id");
    return List.generate(res.length,(i) {
      return ElementIg(id: res[i]['id'], nom: res[i]['nom']);
    });
  }


  static Future<List<Map<String, dynamic>>> getElementIg(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('ElementIg', where: "id = ?", whereArgs: [id], limit: 1);
  }
  static Future<int> updateElementIg(int id, String nom) async {
    final db = await DatabaseHelper.db();
    final data = {'nom': nom};
    return await db.update('ElementIg', data, where: "id = ?", whereArgs: [id]);
  }
  static Future<void> deleteElementIg(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("ElementIg", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an ElementIg: $err");
    }
  }

  // INGREDIENTS

  // RECETTES

  // INGREDIENT IN RECETTE


}
