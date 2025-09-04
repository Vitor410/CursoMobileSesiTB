import 'package:biblioteca_app/models/books.dart';
import 'package:biblioteca_app/services/api_service.dart';

class BookControler {
  //obs: não precisa instaciar obj de ApiService (métodos static)

  //métodos
  // GET dos Usuários
  Future<List<BooksModel>> fetchAll() async {
    final list = await ApiService.getList(
      "books?_sort=name",
    ); //?_sort=name -> flag para organizar em order alfabetica
    //retorna a Lista de Usuário Convertidas para Book Model List<dynamic> => List<OBJ>
    return list.map<BooksModel>((item) => BooksModel.fromMap(item)).toList();
  }

  // POST -> Criar novo usuário
  Future<BooksModel> create(BooksModel u) async {
    final created = await ApiService.post("books", u.toMap());
    // adiciona um Usuário e Retorna o Usuário Criado -> ID
    return BooksModel.fromMap(created);
  }

  // GET -> Buscar um Usuário
  Future<BooksModel> fetchOne(String id) async {
    final book = await ApiService.getOne("books", id);
    // Retorna o Usuário Encontrado no Banco de Dados
    return BooksModel.fromMap(book);
  }

  // PUT -> Atualizar Usuário
  Future<BooksModel> update(BooksModel u) async {
    final updated = await ApiService.put("books", u.toMap(), u.id!);
    //REtorna o Usuário Atualizado
    return BooksModel.fromMap(updated);
  }

  Future<void> delete(String id) async {
    await ApiService.delete("books", id);
    // Não há retorno, livro deletado com sucesso
  }
}
