import 'package:flutter/foundation.dart';
import 'package:miam/Menu/models/ingredient.dart';
import 'package:sqflite/sqflite.dart' as sql;

import '../models/menu.dart';
import '../models/recette.dart';

class DatabaseHelper {
  /*
   * SINGLETON (Create and Getter de l'instance sql.Database).
   */
  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'miammiam.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
        await insertDatas(database);
      },
    );
  }

  /*
   * Création des 4 tables de données [ ElementIg,Recette,Ingredient,Menu].
   */
  static Future<void> createTables(sql.Database db) async {
    await db.execute("""CREATE TABLE ElementIg(	id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,	nom TEXT);""");
    await db.execute("""CREATE TABLE Recette(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, titre TEXT, etapes TEXT, tmpPreparation DOUBLE, tmpCuisson DOUBLE, calories DOUBLE, estEquilibre TEXT)  """);
    await db.execute("""CREATE TABLE Ingredient(idRecette INTEGER, idElement INTEGER, quantite DOUBLE,PRIMARY KEY (idElement, idRecette), FOREIGN KEY (idRecette) REFERENCES Recette(id), FOREIGN KEY (idElement) REFERENCES ElementIg(id) ) """);
    await db.execute("""CREATE TABLE Menu(idMenu INTEGER, idRecette INTEGER, PRIMARY KEY (idMenu, idRecette), FOREIGN KEY (idRecette) REFERENCES Recette(id),FOREIGN KEY (idMenu) REFERENCES Menu(id)  )""");
  }

  /*
   * Insertion de jeu de données dans les 4 tables de données [ ElementIg,Recette,Ingredient,Menu].
   */
  static Future<void> insertDatas(sql.Database db) async {
    await db.execute("""INSERT INTO ElementIg(nom) VALUES ('Viande_poulet'),('Viande_Boeuf'),('Viande_Porc'),('Poisson_Gras'),('Poisson_Maigre'),('Courgette'),('Tomate'),('Oignon'),('Pates'),('Haricot_Rouge'),('Riz'),('Ail'),('Carotte'),('Poivron'),('Crevette'),('Epice_Curry'),('Epice_Chili'),('Creme_Coco'),('Poireau'); """);
    await db.execute("""INSERT INTO Recette(titre,etapes,tmpPreparation,tmpCuisson,calories,estEquilibre) VALUES ('Chili con carne','',30.0,30.0,352,'PARFAIT'),('Chili sin carne','',30.0,30.0,352,'MODERE'),('Lasagne chevre courgette','',35.0,45.0,352,'IMPARFAIT'),('Nouilles sautées','',45.0,45.0,352,'PARFAIT'),('Tomates farcies','',60.0,30.0,352,'MODERE'),('Paella Express','',60.0,30.0,352,'IMPARFAIT'),('Rougail saucisse','',60.0,30.0,352,'IMPARFAIT'),('Crevette miel sésame','',60.0,30.0,352,'MODERE'),('Curry de crevettes','',60.0,30.0,352,'MODERE'),('Curry de courgette','',60.0,30.0,352,'PARFAIT'),('Blanquette de veau','',60.0,30.0,352,'MODERE'),('Flammekueche','',60.0,30.0,352,'MODERE'),('Gnocchis poulet','',60.0,30.0,352,'MODERE'),('Salade de pois','',60.0,30.0,352,'PARFAIT'),('Pizzas','',75.0,30.0,600,'IMPARFAIT'),('Quiche brocolis','',60.0,45.0,300,'PARFAIT'),('Soupe Mexican','',60.0,30.0,200,'PARFAIT'),('Ramen chicken','',60.0,30.0,200,'MODERE'),('Mapo tofu','',60.0,30.0,352,'MODERE'),('Carbonara','',60.0,30.0,352,'MODERE'),('Jambalaya','',30.0,30.0,600,'IMPARFAIT'),('Brique Courgette Curry','',60.0,30.0,352,'MODERE'),('Quiches du soleil','',60.0,30.0,352,'PARFAIT'); """);
    await db.execute("""INSERT INTO Ingredient(idRecette,idElement, quantite) VALUES (1,1,200),(2,6,200),(3,7,200),(4,9,200),(5,8,200); """);
    await db.execute("""INSERT INTO Menu(idMenu,idRecette) VALUES (1,1),(2,1),(3,1),(4,1),(4,2),(3,2),(2,2),(1,2),(1,3),(4,3);""");
  }


  //// ELEMENTSIG
  /*
   * Fonction d'insertion d'une nouvelle ligne de data pour la table ElementIg.
   * @param String, nom du nouvelle element.
   * @return int, id inserted.
   */
  static Future<int> createElementIg(String? nom) async {
    final db = await DatabaseHelper.db();
    final data = {'nom': nom};
    return await db.insert('ElementIg', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
  /*
   * Fonction query select all sur la table ElementIg.
   * @return List of ElementIg, une liste composé des éléments enregistré en bd sous forme de class ElementIg.
   */
  static Future<List<ElementIg>> getElementIgs() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res =
        await db.query('ElementIg', orderBy: "id");
    return List.generate(res.length, (i) {
      return ElementIg(id: res[i]['id'], nom: res[i]['nom']);
    });
  }
  /*
   * Fonction query select 1 sur la table ElementIg.
   * @param int, id de l'élément recherché.
   * @return ElementIg, l'élément correspondant à l'id.
   */
  static Future<ElementIg> getElementIg(int id) async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res =
        await db.query('ElementIg', where: "id = ?", whereArgs: [id], limit: 1);
    return ElementIg(id: res[0]['id'], nom: res[0]['nom']);
  }
  /*
   * Fonction query modifié une ligne de la table ElementIg.
   * @param int, id de l'élément a modifié.
   * @param string, nom de l'élément modifié.
   * @return int, id updated.
   */
  static Future<int> updateElementIg(int id, String nom) async {
    final db = await DatabaseHelper.db();
    final data = {'nom': nom};
    return await db.update('ElementIg', data, where: "id = ?", whereArgs: [id]);
  }
  /*
   * Fonction query delete 1 sur la table ElementIg.
   * @param int, id de l'élément a supprimé.
   */
  static Future<void> deleteElementIg(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("ElementIg", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an ElementIg: $err");
    }
  }
  //// ELEMENTSIG

  //// RECETTES
  //

  /*
   * Fonction d'insertion d'une nouvelle ligne de data pour la table Recette.
   */
  static Future<int> createRecette(
      String titre,
      String etapes,
      double tmpPreparation,
      double tmpCuisson,
      double calories,
      String estEquilibre) async {
    final db = await DatabaseHelper.db();
    final data = {
      'titre': titre,
      'etapes': etapes,
      'tmpPreparation': tmpPreparation,
      'tmpCuisson': tmpCuisson,
      'calories': calories,
      'estEquilibre': estEquilibre
    };
    return await db.insert('Recette', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Recette>> getRecettes() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res =
        await db.query('Recette', orderBy: "id");
    return List.generate(res.length, (i) {
      return Recette(
          id: res[i]['id'],
          titre: res[i]['titre'],
          etapes: res[i]['etapes'],
          ingredients: <Ingredient>[],
          tmpCuisson: res[i]['tmpCuisson'],
          tmpPreparation: res[i]['tmpPreparation'],
          calories: res[i]['calories'],
          estEquilibre: res[i]['estEquilibre']);
    });
  }

  static Future<Recette> getRecette(int id) async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res =
        await db.query('Recette', where: "id = ?", whereArgs: [id], limit: 1);
    return Recette(
        id: res[0]['id'],
        titre: res[0]['titre'],
        etapes: res[0]['etapes'],
        ingredients: <Ingredient>[],
        tmpCuisson: res[0]['tmpCuisson'],
        tmpPreparation: res[0]['tmpPreparation'],
        calories: res[0]['calories'],
        estEquilibre: res[0]['estEquilibre']);
  }

  static Future<int> updateRecette(
      int id,
      String titre,
      String etapes,
      double tmpPreparation,
      double tmpCuisson,
      double calories,
      String estEquilibre) async {
    final db = await DatabaseHelper.db();
    final data = {
      'titre': titre,
      'etapes': etapes,
      'tmpPreparation': tmpPreparation,
      'tmpCuisson': tmpCuisson,
      'calories': calories,
      'estEquilibre': estEquilibre
    };
    return await db.update('Recette', data, where: "id = ?", whereArgs: [id]);
  }

  static Future<void> deleteRecette(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("Recette", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Recette: $err");
    }
  }
  ////

  //// INGREDIENTS

  /*
   * Fonction d'insertion d'une nouvelle ligne de data pour la table Recette.
   */
  static Future<int> createIngredient(
      int idRecette, int idElementIg, double quantite) async {
    final db = await DatabaseHelper.db();
    final data = {
      'idRecette': idRecette,
      'idElement': idElementIg,
      'quantite': quantite
    };
    return await db.insert('Ingredient', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Ingredient>> getIngredients() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res =
        await db.query('Ingredient', orderBy: "idRecette");
    return List.generate(res.length, (i) {
      return Ingredient(
          id: res[i]['idRecette'],
          elementIg: (getElementIg(res[i]['idElement']) as ElementIg),
          quantite: res[i]['quantite']);
    });
  }
  static Future<List<Ingredient>> getIngredientsByRecette(int idRecette) async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res =
    await db.query('Ingredient', orderBy: "idRecette",where: "idRecette = ?",whereArgs: [idRecette]);
    return List.generate(res.length, (i) {
      return Ingredient(
          id: res[i]['idRecette'],
          elementIg: ElementIg(id:res[i]['idElement'],nom: '') ,
          quantite: res[i]['quantite']);
    });
  }
  static Future<Ingredient> getIngredient(int idRecette, int idElement) async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res = await db.query('Ingredient',
        where: "idRecette = ? AND idElement = ?",
        whereArgs: [idRecette, idElement],
        limit: 1);
    return Ingredient(
        id: res[0]['idRecette'],
        elementIg: (getElementIg(res[0]['idElement']) as ElementIg),
        quantite: res[0]['quantite']);
  }

  static Future<int> updateIngredient(int idRecette, int idElement,
      ElementIg elementIg, double quantite) async {
    final db = await DatabaseHelper.db();
    final data = {'idElement': elementIg.id, 'quantite': quantite};
    return await db.update('Ingredient', data,
        where: "idRecette = ? AND idElement = ?",
        whereArgs: [idRecette, idElement]);
  }

  static Future<void> deleteIngredient(int idRecette, int idElement) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("Ingredient",
          where: "idRecette = ? AND idElement = ?",
          whereArgs: [idRecette, idElement]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Ingredient: $err");
    }
  }
  //// INGREDIENTS

  //// MENU

  /*
   * Fonction d'insertion d'une nouvelle ligne de data pour la table Recette.
   */
  static Future<int> createMenu(int idMenu, int idRecette) async {
    final db = await DatabaseHelper.db();
    final data = {'idMenu': idMenu, 'idRecette': idRecette};
    return await db.insert('Menu', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }
  static Future<List<Map<String, dynamic>>> getMenus2() async {
    final db = await DatabaseHelper.db();
    return db.query('Menu', orderBy: "idMenu");
  }
  static Future<List<Menu>> getMenus() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res =
        await db.query('Menu', orderBy: "idMenu");
    //print('ici 1 ');
    List<Menu> menus = [];
    int idMlast =0;
    Menu current = Menu(idMenu: 0, recettes: [], ingredients: []);
    for(var r in res){
      if (idMlast ==0){
        current = Menu(idMenu: r['idMenu'], recettes: [], ingredients: []);
        //print('ici 1.5 ');
        //print('ici 1.5.1 ' + r['idRecette'].toString());
        current.recettes.add(await getRecette(r['idRecette']) );
      }else{
        if(r['idMenu'] == idMlast){
          //print('ici 1.5.2 ' + r['idRecette'].toString());
          current.recettes.add(await getRecette(r['idRecette']) );
        }else{
          menus.add(current);
          current = Menu(idMenu: r['idMenu'], recettes: [], ingredients: []);
          //print('ici 1.5.3 ' + r['idRecette'].toString() + ' euh '+ r['idMenu'].toString());
          current.recettes.add(await getRecette(r['idRecette']) );
        }
      }
      idMlast = current.idMenu;
    }
    //print('ici 2 ');
  return menus;
  /*
    return List.generate(res.length, (i) {

      return Menu(
          idMenu: res[i]['idMenu'],
          ingredients: <Ingredient>[],
          recettes: <Recette>[]);
    });
   */
  }
  static Future<int> getLastIdMenu() async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res = await db.query('Menu',limit: 1,orderBy: "idMenu DESC");
    return res[0]['idMenu'];
  }
  static Future<Menu> getMenu(int idMenu, int idRecette) async {
    final db = await DatabaseHelper.db();
    final List<Map<String, dynamic>> res = await db.query('Menu',
        where: "idMenu = ? AND idRecette=?",
        whereArgs: [idMenu, idRecette],
        limit: 1,orderBy: "idMenu");
    return Menu(
        idMenu: res[0]['idMenu'],
        ingredients: <Ingredient>[],
        recettes: <Recette>[]);
  }

  static Future<int> updateMenu(int idMenu, int idRecette, String titre) async {
    final db = await DatabaseHelper.db();
    final data = {'titre': titre};
    return await db.update('Menu', data,
        where: "idMenu = ? AND idRecette=?", whereArgs: [idMenu, idRecette]);
  }

  static Future<void> deleteMenu(int idMenu, int idRecette) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("Menu",
          where: "idMenu = ? AND idRecette=?", whereArgs: [idMenu, idRecette]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an Menu: $err");
    }
  }
  ////

  //// RECETTES IN MENU
  static Future<int> createRecetteInMenu(int idRecette, int idMenu) async {
    final db = await DatabaseHelper.db();
    final data = {'idMenu': idRecette, 'idMenu': idMenu};
    return await db.insert('RecetteInMenu', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getRecetteInMenus() async {
    final db = await DatabaseHelper.db();
    return await db.query('RecetteInMenu', orderBy: "idRecette");
  }

  static Future<List<Map<String, dynamic>>> getRecetteInMenu(
      int idRecette, int idMenu) async {
    final db = await DatabaseHelper.db();
    return await db.query('RecetteInMenu',
        where: "idRecette = ? AND idMenu= ?",
        whereArgs: [idRecette, idMenu],
        limit: 1);
  }

  static Future<int> updateRecetteInMenu(int idRecette, int idMenu) async {
    final db = await DatabaseHelper.db();
    final data = {'idRecette': idRecette, 'idMenu': idMenu};
    return await db.update('RecetteInMenu', data,
        where: "idRecette = ? AND idIngredient= ?",
        whereArgs: [idRecette, idMenu]);
  }

  static Future<void> deleteRecetteInMenu(int idRecette, int idMenu) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("RecetteInMenu",
          where: "idRecette = ? AND idMenu= ?", whereArgs: [idRecette, idMenu]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an RecetteInMenu: $err");
    }
  }
  ////
}
