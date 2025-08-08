import 'package:flutter/material.dart';
// biblioteca instalada no pubspec (flutter pub add nome_da_biblioteca)
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'config_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  //atributos
  bool temaEscuro = false;
  String nomeUsuario = "";

  // para carregar informações no começo da aplicação
  @override
  void initState() {
    super.initState();
    carregarPreferencias();
  }

  // métodos async -> não travar aplicação enquanto carregam as informações de uma Base de Dados
  void carregarPreferencias() async {
    //conexão com o cache para pegar informações armazenadas pelo usuário
    final prefs = await SharedPreferences.getInstance();
    //armazenando em um texto as configurações salvas
    String? jsonString = prefs.getString('config');
    if (jsonString != null) {
      //converter o texto/Json em Map/Dart
      Map<String, dynamic> config = json.decode(jsonString);
      // chama a mudança de estado
      setState(() {
        // atribui a bool o valor da chave TemaEscuro, caso null atribui falso
        temaEscuro = config["temaEscuro"] ?? false;
        nomeUsuario = config["nome"] ?? "";
      });
    }
  } // fim do método

  // método build
  @override
  Widget build(BuildContext context) {
    return(MaterialApp(
      title: "App de Configuração",
      // operador Ternário (if else encurtado)
      theme: temaEscuro ? ThemeData.dark() : ThemeData.light(),
      home: ConfigPage(
        temaEscuro: temaEscuro,
        nomeUsuario: nomeUsuario,
        onSalvar: (bool novoTema, String novoNome){
          setState(() {
            temaEscuro = novoTema;
            nomeUsuario = novoNome;
          });
        }
      ),
    ));
  }
}
