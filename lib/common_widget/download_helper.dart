import 'dart:io';
import 'package:objectdb/objectdb.dart';

import 'package:path_provider/path_provider.dart';
import 'package:objectdb/src/objectdb_storage_filesystem.dart';

class DownloadsDB {
  getPath() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = documentDirectory.path + '/downloads.db';
    return path;
  }

  final path = Directory.current.path + '/my.db';

// create database instance and open

  //Insertion
  add(Map item) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path1 = documentDirectory.path + '/downloads.db';
    final db = ObjectDB(FileSystemStorage(path1));
   // db._open();
    db.insert(item);
   // db.tidy();
    await db.close();
  }

  Future<int> remove(Map item) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path1 = documentDirectory.path + '/downloads.db';
    final db = ObjectDB(FileSystemStorage(path1));
   // db.open();
    int val = await db.remove(item);
   // db.tidy();
    await db.close();
    return val;
  }

  Future removeAllWithId(Map item) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path1 = documentDirectory.path + '/downloads.db';
    final db = ObjectDB(FileSystemStorage(path1));
  //  db.open();
    List val = await db.find(item);
    val.forEach((element) {
      db.remove(element);
    });
   // db.tidy();
    await db.close();
  }

  Future<List> check(Map item) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path1 = documentDirectory.path + '/downloads.db';

    final db = ObjectDB(FileSystemStorage(path1));

    List val = await db.find(item);

    await db.close();
    return val;
  }

  clear() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path1 = documentDirectory.path + '/downloads.db';
    final db = ObjectDB(FileSystemStorage(path1));

    db.remove({});
  }
}
