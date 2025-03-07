import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //estudo do Scaffould
      home: Scaffold(
        //bara de navegação superior
        appBar: AppBar(
          title: Text("Exemplo AppBar"),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    color: Colors.red,
                    decoration: BoxDecoration(
                      
                    ),
                  ),
                  Icon(Icons.person)
                ],
              ),
              Text("Coluna 2"), 
              Text("Coluna 3")],
            ),
            Text("Linha 2"),
            Text("Coluna 3")],
          ),
        ),
        drawer: Drawer(
          child: ListView(
            children: [Text("Inicio"), Text("Conteudo"), Text("Contato")],
          ),
        ),
        //barra de navegação inferior
        bottomNavigationBar: (BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Pesquisa"),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Usuarios"),
          ],
        )),
        //botão flutuante
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print("Botão Clicado");
          },
          child: Icon(Icons.add),
        ),
      ),
    );
    //Barra lateral (menu hamburguer)
  }
}
