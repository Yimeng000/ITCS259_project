import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/book.dart';

class DBService {
  static final DBService instance = DBService._internal();
  DBService._internal();

  static Database? _db;

  // GET DATABASE
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  // INIT DB
  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "readify.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("""
          CREATE TABLE books (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            author TEXT,
            coverUrl TEXT,
            description TEXT,
            rating REAL,
            category TEXT,
            totalPages INTEGER,
            currentPage INTEGER,
            notes TEXT
          )
        """);
      },
    );
  }

  // CRUD
  Future<int> insertBook(Book book) async {
    final db = await database;
    return await db.insert("books", book.toMap());
  }

  Future<List<Book>> getBooks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query("books", orderBy: "id DESC");

    return maps.map((item) => Book.fromMap(item)).toList();
  }

  Future<int> updateBook(Book book) async {
    final db = await database;
    return await db.update(
      "books",
      book.toMap(),
      where: "id = ?",
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(int id) async {
    final db = await database;
    return await db.delete(
      "books",
      where: "id = ?",
      whereArgs: [id],
    );
  }
}