import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main(){ //metodo principal para rodar uma aplicação
  runApp(Myapp()); //construtor da classe principal
}

class Myapp extends StatelessWidget{ //classe principal
  @override
  Widget build(BuildContext context) {
    return MaterialApp( //MaterialApp - contem os widget
      home: Scaffold( //tela de vizualização basica
        appBar: AppBar(
          title: Text("Exemplo App Dependencia"),
        ),
        body: Center(
          child: ElevatedButton(
          onPressed: (){
           Fluttertoast.showToast(
            msg: "Olá, mundo!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
           );
          }, 
          child: Text("Clique Aqui")),
        ),
      ),
    );
  }
}