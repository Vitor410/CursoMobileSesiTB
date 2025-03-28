import 'package:flutter/material.dart';
import 'package:sa04_widget_navegacao/view/tela_cadasto_view.dart';

import 'view/tela_cadastro_view.dart';
import 'view/tela_confirmacao_view.dart';
import 'view/tela_inicial_view.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: { //3 tela de navegação do App
      "/": (context)=> TelaInicialView(),
      "/cadastro":(context)=>TelaCadastroView(),
      "/confirmacao":(context) => TelaConfirmacaoView()
    },
  ));
}

//quando era uma unica tema -> continuava na Class