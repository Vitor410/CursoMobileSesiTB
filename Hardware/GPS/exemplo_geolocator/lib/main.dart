// exemplo de uso do GPS

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'clima_service.dart';

void main() {
  runApp(MaterialApp(home: LocationScreen()));
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  //atributos
  String mensagem = "";
  String climaInfo = "";

  //método para pegar a localização do dispoditivo
  Future<Position?> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        mensagem = "Serviço de Localização desabilitado";
      });
      return null;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          mensagem = "Permissão de localização negada";
        });
        return null;
      }
    }
    Position position = await Geolocator.getCurrentPosition();
    setState(() {
      mensagem =
          "Latitude: ${position.latitude} - Longitude: ${position.longitude}";
    });
    return position;
  }

  Future<void> buscarClima() async {
    Position? position = await getLocation();
    if (position != null) {
      try {
        ClimaService climaService = ClimaService();
        Map<String, dynamic> clima = await climaService.getCityWeatherPosition(
          position,
        );
        setState(() {
          climaInfo =
              "Cidade: ${clima["name"]}\nClima: ${clima["weather"][0]["description"]}\nTemperatura: ${clima["main"]["temp"]}°C";
        });
      } catch (e) {
        setState(() {
          climaInfo = "Erro ao buscar clima";
        });
      }
    } else {
      setState(() {
        climaInfo = "Não foi possível obter localização";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    buscarClima();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GPS - Localização")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(mensagem),
            SizedBox(height: 16),
            Text(climaInfo),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await buscarClima();
              },
              child: Text("Obter Localização e Clima"),
            ),
          ],
        ),
      ),
    );
  }
}
