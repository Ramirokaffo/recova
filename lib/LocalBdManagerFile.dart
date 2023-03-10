
import 'package:sqflite/sqflite.dart';
import 'package:path/path.Dart';
import 'dart:async';



Future localBdChangeSetting(String settingName, String newSettingValue) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'local.db');
  var database = await openDatabase(path);
  await database.rawUpdate('UPDATE setting SET valeur = ? WHERE name = ?',
      [newSettingValue, settingName]);
  await database.close();
}

Future localBdInsertSetting(String settingName, String settingValue) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'local.db');
  var database = await openDatabase(path);
  await database.transaction((txn) async {
    await txn.rawInsert(
        'INSERT INTO setting (name, valeur) VALUES("$settingName", "$settingValue")');
  });
  await database.close();
}

Future firstConnection2Db() async {
  // Get a location using getDatabasesPath
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'local.db');

// Delete the database
//   await deleteDatabase(path);
// return;
// open the database
  Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE setting (`id` INTEGER NOT NULL , `name` VARCHAR(45) NULL, `valeur` VARCHAR(500) NULL, PRIMARY KEY (`id`));');
        await db.transaction((txn) async {
          await txn.rawInsert(
              'INSERT INTO setting (name, valeur) VALUES("account", "no")');
          await txn.rawInsert(
              'INSERT INTO setting (name, valeur) VALUES("token", "none")');
          await txn.rawInsert(
              'INSERT INTO setting (name, valeur) VALUES("password", "no")');
          await txn.rawInsert(
              'INSERT INTO setting (name, valeur) VALUES("pinIsRequired", "no")');
        });
      });
  // await database.close();
}

Future localBdSelectSetting(String settingName) async {
  var databasesPath = await getDatabasesPath();
  String path = join(databasesPath, 'local.db');
  var database = await openDatabase(path);
  List<Map> list = await database
      .rawQuery('SELECT valeur FROM setting WHERE name = ?', [settingName]);
  return list[0]["valeur"];
}
