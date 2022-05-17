import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBAdmin {
  Database? myDatabase;
  static final DBAdmin db = DBAdmin._();
  DBAdmin._();

  Future<Database?> getCheckDatabase() async{
    if (myDatabase != null) return myDatabase;
    myDatabase = await initDB(); //Creación de la base de datos
    return myDatabase;
  }

  Future<Database> initDB() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "BookDB.db");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int v) async {
        await db.execute("CREATE TABLE BOOK(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, author TEXT, description TEXT, image TEXT)");
      },
    );
  }


  // READ - Realizar consultas a la tabla

  getBooksRaw() async {
   final Database? db = await getCheckDatabase();
   List res = await db!.rawQuery("SELECT * FROM BOOK");
   print(res);
  }

  getBooks() async{
    final Database? db = await getCheckDatabase();
    List res = await db!.query("BOOK");
    print(res);
  }

  // CREATE - Insertar data en la tabla

  insertBook() async{
    final Database? db = await getCheckDatabase();
    db!.rawInsert("INSERT INTO BOOK(title, author, description, image) VALUES('The Hobbit', 'JRR Tolkien', 'Lorem ipsum', 'https://www...')");
  }




}
