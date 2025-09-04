import 'package:biblioteca_app/controllers/books_controler.dart';
import 'package:biblioteca_app/models/books.dart';
import 'package:biblioteca_app/views/books/book_form_view.dart';
import 'package:flutter/material.dart';

class BookListView extends StatefulWidget {
  const BookListView({super.key});

  @override
  State<BookListView> createState() => _BookListViewState();
}

class _BookListViewState extends State<BookListView> {
  //atributos
  final _controller = BookControler();
  List<BooksModel> _books = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load(); //carregar as informações iniciais de books
  }

  void _load() async {
    setState(() => _loading = true);
    try {
      _books = await _controller.fetchAll();
    } catch (e) {
      print('Erro ao carregar livros: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  // Função para excluir livro
  void _deleteBook(BooksModel book) async {
    if (book.id == null) return;
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirmar Exclusão"),
        content: Text("Deseja realmente excluir o livro '${book.title}'?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text("Excluir"),
          ),
        ],
      ),
    );
    if (confirm == true) {
      try {
        await _controller.delete(book.id!);
        _load();
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Erro ao excluir livro")));
      }
    }
  }

  //build da Tela
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //não precisa de Appbar -> já tem a appbar da homeView
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: Expanded(
                child: ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (context, index) {
                    final book = _books[index];
                    return Card(
                      child: ListTile(
                        title: Text(book.title),
                        subtitle: Text(book.author),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBook(book),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => BookFormView()));
          if (result == true) {
            _load(); // Recarrega a lista se um livro foi registrado
          }
        },
        backgroundColor: Color(0xFFEDE6FF),
        elevation: 6,
        child: Icon(Icons.add, color: Colors.purple),
      ),
    );
  }
}

// Removido BooksControler duplicada, utilize a do controller correto

// ...existing code...
