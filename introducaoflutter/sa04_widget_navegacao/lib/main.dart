import 'package:flutter/material.dart';
import 'view/tela_cadasto_view.dart';
import 'view/tela_confirmacao_view.dart';
import 'view/tela_inicial_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        //3 tela de navegação do app
        "/": (context) => TelaInicialView(),
        "/cadastro": (context) => TelaCadastroView(),
        "/confirmacao": (context) => TelaConfirmacaoView(),
      },
    ),
  );
}

void runApp(MaterialApp materialApp) {
}

class MaterialApp {
}

class TelaConfirmacaoView {
}

class TelaCadastroView {
}

class TelaInicialView {
}

//quando era uma unica tela -> continuava na Class
