import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sa_localizacao_mapa/controllers/point_controller.dart';
import 'package:sa_localizacao_mapa/models/location_point.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  //atributos
  //lista para aramazenar os pontos que serão inserido no map
  List<LocationPoint> _pontos = [];
  //obj para manipulação dos métodos do controller
  final _pointController = PointController();
  //flutter_map -> biblioteca para manipulação de map
  //obj para controlar o map ( bilbioteca própria do flutterMap)
  final _mapController = MapController();

  bool _isLoading = false;
  String? _erro;

  //método para adicionar pontos no MAPA
  void _adicionarPontoMapa() async{
    setState(() {
      _isLoading = true;
      _erro = null;//limpa o erro
    });
    try {
      //pegar a localização
      LocationPoint novaLocalizacao = await _pointController.pegarPonto();
      _pontos.add(novaLocalizacao);
      //manipular meu map para ele deslocar para o novo ponto
      _mapController.move(LatLng(
        novaLocalizacao.latitude,
        novaLocalizacao.longitude), 11);
    } catch (e) {
      _erro = e.toString();
      //mostrar o erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_erro!))
      );
    } finally{ //executa de qualquer jeito (com erro ou sem erro)
      setState(() {
        _isLoading = false;
      });
    }
  }

  //método para limpar pontos no MAPA
  void _limparPontos() {
    setState(() {
      _pontos.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //botão para adicioanr novas localizações
      //e o mapa com os pontos
      appBar: AppBar(
        title: Text("Mapa de Localização"),
        actions: [
          IconButton(
            onPressed: _isLoading ? null : _adicionarPontoMapa,
            icon: _isLoading
            ? CircularProgressIndicator()
            : Icon(Icons.add_location_alt)),
          IconButton(
            onPressed: _limparPontos,
            icon: Icon(Icons.clear))
        ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: LatLng(-22.3353, -47.2406),
          initialZoom: 11
        ),
        children: [
          //camada do MAP
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            userAgentPackageName: "com.example.sa_localizacao_mapa",
          ),
          //Camada de Marcações
          MarkerLayer(
            markers: _pontos.map((ponto){
              return Marker(
                point: LatLng(ponto.latitude, ponto.longitude),
                width: 50,
                height: 50, 
                child: Icon(Icons.location_on, color: Colors.red, size: 35,));
            }).toList())
        ]),
    );
  }
}