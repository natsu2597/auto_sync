




import 'package:auto_sync/models/file_model_sqflite.dart';
import 'package:sqflite/sqflite.dart';

class FilesDatabase{
  static final FilesDatabase instance = FilesDatabase._init();

  static Database? _database;

  FilesDatabase._init();

  Future<Database> get database async{
    if(_database != null){
      return _database!;
    }
    _database = await _initDB('files.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async{

 

    return await openDatabase(filePath, version: 1,onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async{
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    await db.execute('''
    CREATE TABLE $tableFiles (
      ${FileFields.id} $idType,
      ${FileFields.name} $textType,
      ${FileFields.description} $textType,
      ${FileFields.fileUrl} $textType
    )
    ''');


  }

  Future<FileModelSqflite> create(FileModelSqflite file) async{
    final db = await instance.database;

    final id = await db.insert(tableFiles, file.toMap());
    return file.copyWith(id: id);
  }


  Future<FileModelSqflite> readFile(int id) async{
    final db = await instance.database;

    final maps = await db.query(
      tableFiles,
      columns: FileFields.values,
      where: '${FileFields.id} = ?',
      whereArgs: [id]
    );
    if(maps.isNotEmpty)
    {
      return FileModelSqflite.fromMap(maps.first);
    }
    else{
      throw Exception('ID $id not found');
    }
  }
  
  Future<List<FileModelSqflite>> readAllFiles() async{
    final db = await instance.database;

    final result = await db.query(tableFiles);

    return result.map((e) => FileModelSqflite.fromMap(e)).toList();
  }

  Future close() async{
    final db = await instance.database;
    db.close();
  }
}