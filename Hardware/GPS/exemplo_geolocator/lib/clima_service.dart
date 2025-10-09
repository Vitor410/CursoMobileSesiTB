import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class ClimaService {
  String baseUrl = "https://api.openweathermap.org/data/2.5/weather";
  String apiKey = "07c502fe4ca5a85b7f0a83631747e475";

  Future<Map<String, dynamic>> getCityWeatherPosition(Position position) async {
    final url = Uri.parse(
      '$baseUrl?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric&lang=pt_br',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Erro ao buscar clima: ${response.statusCode}');
    }
  }
}
