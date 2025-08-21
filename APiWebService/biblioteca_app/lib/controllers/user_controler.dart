import 'package:biblioteca_app/models/users.dart';
import 'package:biblioteca_app/services/api_service.dart';

class UserControler {
  //métodos
  // GET dos Usuários
  Future<List<UserModel>> fetchAll() async {
    final list = await ApiService.getList("users?_sort=name");
    //retorna a Lista de Usuário Convertidas para User Model
    return list.map<UserModel>((item) => UserModel.fromJson(item)).toList();
  }

  // POST -> Criar novo usuário
  Future<UserModel> create(UserModel u) async {
    final created = await ApiService.post("users", u.toJson());
    // adiciona um Usuário e Retorna o Usuário Criado -> ID
    return UserModel.fromJson(created);
  }

  // GET -> Buscar um Usuário
  Future<UserModel> fetchOne(String id) async {
    final user = await ApiService.getOne("users", id);
    // Retorna o Usuário Encontrado no Banco de Dados
    return UserModel.fromJson(user);
  }

  // PUT -> Atualizar Usuário
  Future<UserModel> update(UserModel u) async {
    final updated = await ApiService.put("users", u.toJson(), u.id!);
    //Retorna o Usuário Atualizado
    return UserModel.fromJson(updated);
  }

  Future<void> delete(String id) async {
    await ApiService.delete("users", id);
    // Não há retorno
  }
}
