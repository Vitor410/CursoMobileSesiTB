import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/books_controler.dart';
import 'package:biblioteca_app/models/books.dart';

class BookFormView extends StatefulWidget {
  const BookFormView({super.key});

  @override
  State<BookFormView> createState() => _BookFormViewState();
}

class _BookFormViewState extends State<BookFormView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  bool _available = true;
  final _controller = BookControler();

  void _saveBook() async {
    if (_formKey.currentState!.validate()) {
      final newBook = BooksModel(
        title: _titleController.text,
        author: _authorController.text,
        avaliable: _available,
      );
      await _controller.create(newBook);
      Navigator.of(context).pop(true); // Retorna true para atualizar a lista
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Livro registrado com sucesso!')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Livro')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o título' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(labelText: 'Autor'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Informe o autor' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _available,
                    onChanged: (value) {
                      setState(() {
                        _available = value ?? true;
                      });
                    },
                  ),
                  Text('Disponível'),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveBook,
                  child: Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
