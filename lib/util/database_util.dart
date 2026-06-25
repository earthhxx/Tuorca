import 'package:objectdb/objectdb.dart';
import 'package:objectdb/src/objectdb_storage_filesystem.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseUtil<T> {
  Future<ObjectId> insertData({
    String dbName,
    dynamic data,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final pathStr = '${dir.path}/$dbName.db'; // String
    final storage = FileSystemStorage(pathStr); // pass String
    final db = ObjectDB(storage);

    // No db.open() per API
    await db.remove({});
    final id = await db.insert(data.toJson());
    await db.close();
    return id;
  }

  Future<List<Map<String, dynamic>>> selectData({
    String dbName,
    Map<String, dynamic> query,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final pathStr = '${dir.path}/$dbName.db';
    final storage = FileSystemStorage(pathStr);
    final db = ObjectDB(storage);

    final result = await db.find(query);
    await db.close();
    return result.cast<Map<String, dynamic>>();
  }

  Future<List<Map<String, dynamic>>> selectAllData({
    String dbName,
  }) async {
    return selectData(dbName: dbName, query: {});
  }

  Future<int> removeAll({
    String dbName,
  }) async {
    final dir = await getApplicationDocumentsDirectory();
    final pathStr = '${dir.path}/$dbName.db';
    final storage = FileSystemStorage(pathStr);
    final db = ObjectDB(storage);

    final count = await db.remove({});
    await db.close();
    return count;
  }
}
