import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() { // roda minha aplicação
  runApp(const MainApp());
}

class MainApp extends StatelessWidget { // janela de aplicação
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp( //base de construção
      home: Scaffold( // modelo de pagina
      appBar: AppBar (title: Text("App hello world")),
        body: Center(
          child: ElevatedButton(
            onPressed: () => Fluttertoast.showToast(
              msg: "Hello, World!!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER
            ) ,
            child: Text("Ver Mensagem"),
          ),
        ),
      ),
    );
  }
}
