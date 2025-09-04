import 'package:flutter/material.dart';
import 'package:biblioteca_app/models/books.dart';
import 'package:biblioteca_app/models/users.dart';
import 'package:biblioteca_app/models/loans.dart';
import 'package:biblioteca_app/controllers/books_controler.dart';
import 'package:biblioteca_app/controllers/user_controler.dart';
import 'package:biblioteca_app/controllers/loan_controler.dart';

class LoanFormView extends StatefulWidget {
  const LoanFormView({super.key});

  @override
  State<LoanFormView> createState() => _LoanFormViewState();
}

class _LoanFormViewState extends State<LoanFormView> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedBookId;
  String? _selectedUserId;
  DateTime _startDate = DateTime.now();
  DateTime _dueDate = DateTime.now().add(Duration(days: 7));
  bool _returned = false;

  List<BooksModel> _books = [];
  List<UserModel> _users = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() => _loading = true);
    final books = await BookControler().fetchAll();
    final users = await UserControler().fetchAll();
    setState(() {
      _books = books.where((b) => b.avaliable).toList();
      _users = users;
      _loading = false;
    });
  }

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _dueDate = picked;
        }
      });
    }
  }

  void _saveLoan() async {
    if (_formKey.currentState!.validate()) {
      final loan = LoansModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: _selectedUserId,
        bookId: _selectedBookId,
        startDate: _startDate.toIso8601String().substring(0, 10),
        dueDate: _dueDate.toIso8601String().substring(0, 10),
        returned: _returned.toString(),
      );
      await LoanControler().create(loan);
      Navigator.pop(context, true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Empréstimo registrado com sucesso!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Empréstimo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedBookId,
                items: _books
                    .map(
                      (book) => DropdownMenuItem(
                        value: book.id,
                        child: Text(book.title),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedBookId = value),
                decoration: InputDecoration(labelText: 'Livro'),
                validator: (value) =>
                    value == null ? 'Selecione um livro' : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedUserId,
                items: _users
                    .map(
                      (user) => DropdownMenuItem(
                        value: user.id,
                        child: Text(user.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) => setState(() => _selectedUserId = value),
                decoration: InputDecoration(labelText: 'Usuário'),
                validator: (value) =>
                    value == null ? 'Selecione um usuário' : null,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Início: ${_startDate.toLocal().toString().substring(0, 10)}',
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, true),
                    child: Text('Alterar'),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Devolução: ${_dueDate.toLocal().toString().substring(0, 10)}',
                  ),
                  TextButton(
                    onPressed: () => _selectDate(context, false),
                    child: Text('Alterar'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _returned,
                    onChanged: (value) =>
                        setState(() => _returned = value ?? false),
                  ),
                  Text('Devolvido'),
                ],
              ),
              SizedBox(height: 24),
              Center(
                child: ElevatedButton(
                  onPressed: _saveLoan,
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
