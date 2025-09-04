import 'package:biblioteca_app/models/loans.dart';
import 'package:biblioteca_app/services/api_service.dart';

class LoanControler {
  // Listar todos os empréstimos
  Future<List<LoansModel>> fetchAll() async {
    final list = await ApiService.getList("loans?_sort=startDate");
    return list.map<LoansModel>((item) => LoansModel.fromJson(item)).toList();
  }

  // Criar novo empréstimo
  Future<LoansModel> create(LoansModel l) async {
    final created = await ApiService.post("loans", l.toJson());
    return LoansModel.fromJson(created);
  }

  // Buscar um empréstimo
  Future<LoansModel> fetchOne(String id) async {
    final loan = await ApiService.getOne("loans", id);
    return LoansModel.fromJson(loan);
  }

  // Atualizar empréstimo
  Future<LoansModel> update(LoansModel l) async {
    final updated = await ApiService.put("loans", l.toJson(), l.id!);
    return LoansModel.fromJson(updated);
  }

  // Excluir empréstimo
  Future<void> delete(String id) async {
    await ApiService.delete("loans", id);
  }
}
