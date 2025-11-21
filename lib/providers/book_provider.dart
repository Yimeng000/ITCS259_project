import 'package:flutter/material.dart';
import '../models/book.dart';
import '../db_service.dart';
import '../data/sample_data.dart'; 

class BookProvider extends ChangeNotifier {
  List<Book> books = [];

  Future<void> loadBooks() async {
    books = await DBService.instance.getBooks();

    if (books.isEmpty) {
      for (var book in sampleBooks) {
        await addBook(book);
      }
    } else {
      await refreshBooks(); 
    }
  }

  Future<void> refreshBooks() async {
    books = await DBService.instance.getBooks();
    notifyListeners();
  }

  Future<void> addBook(Book book) async {
    await DBService.instance.insertBook(book);
    await refreshBooks();
  }

  Future<void> updateBook(Book book) async {
    await DBService.instance.updateBook(book);
    await refreshBooks();
  }

  Future<void> deleteBook(int id) async {
    await DBService.instance.deleteBook(id);
    await refreshBooks();
  }

  List<Book> get want => books.where((b) => b.category == "want").toList();
  List<Book> get reading => books.where((b) => b.category == "reading").toList();
  List<Book> get read => books.where((b) => b.category == "read").toList();

  int get wantCount => want.length;
  int get readingCount => reading.length;
  int get readCount => read.length;
}