import 'package:flutter/material.dart';
import 'package:biblioteca_app/controllers/loan_controler.dart';
import 'package:biblioteca_app/controllers/user_controler.dart';
import 'package:biblioteca_app/controllers/books_controler.dart';
import 'package:biblioteca_app/models/loans.dart';
import 'package:biblioteca_app/models/users.dart';
import 'package:biblioteca_app/models/books.dart';

class LoanListView extends StatefulWidget {
  const LoanListView({super.key});

  @override
  State<LoanListView> createState() => _LoanListViewState();
}

class _LoanListViewState extends State<LoanListView> {
  List<LoansModel> _loans = [];
  List<UserModel> _users = [];
  List<BooksModel> _books = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    setState(() => _loading = true);
    final loans = await LoanControler().fetchAll();
    final users = await UserControler().fetchAll();
    final books = await BookControler().fetchAll();
    setState(() {
      _loans = loans;
      _users = users;
      _books = books;
      _loading = false;
    });
  }

  String _getUserName(String? userId) {
    final user = _users.firstWhere(
      (u) => u.id == userId,
      orElse: () => UserModel(id: '', name: 'Desconhecido', email: ''),
    );
    return user.name;
  }

  String _getBookTitle(String? bookId) {
    final book = _books.firstWhere(
      (b) => b.id == bookId,
      orElse: () => BooksModel(
        id: '',
        title: 'Desconhecido',
        author: '',
        avaliable: false,
      ),
    );
    return book.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: EdgeInsets.all(16),
              child: ListView.builder(
                itemCount: _loans.length,
                itemBuilder: (context, index) {
                  final loan = _loans[index];
                  return Card(
                    child: ListTile(
                      title: Text(_getBookTitle(loan.bookId)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Usuário: ${_getUserName(loan.userId)}'),
                          Text('Início: ${loan.startDate}'),
                          Text('Devolução: ${loan.dueDate}'),
                          Text(
                            'Devolvido: ${loan.returned == 'true' ? 'Sim' : 'Não'}',
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed('/loanForm');
          if (result == true) {
            _load(); // Recarrega a lista se um empréstimo foi registrado
          }
        },
        backgroundColor: Color(0xFFEDE6FF),
        elevation: 6,
        child: Icon(Icons.add, color: Colors.purple),
      ),
    );
  }
}
