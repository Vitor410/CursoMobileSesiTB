import 'package:biblioteca_app/models/books.dart';

class BookController {
  static final List<BooksModel> _books = [];

  Future<List<BooksModel>> fetchAll() async {
    // Simula delay de API
    await Future.delayed(Duration(milliseconds: 500));
    return List<BooksModel>.from(_books);
  }

  void addBook(BooksModel book) {
    _books.add(book);
  }
}
