import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:web_service_clima/models/clima_model.dart';

class ClimaController {
  final String _apiKey = "69ae14eb0f44be51c415d4bf14b5d1a1"; //chave da API

  //método get
  Future<ClimaModel?> getClima(String cidade) async {
    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cidade&appid=$_apiKey&units=metric&lang=pt_br",
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final dados = json.decode(response.body);
      return ClimaModel.fromJson(dados);
    } else {
      return null;
    }
  }
}
