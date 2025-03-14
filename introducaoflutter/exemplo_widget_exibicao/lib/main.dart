import 'package:flutter/material.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  // widget build
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("Exemplo Widget exibição")),
        body: Center(
          child: Column(
            children: [
              Text("Um Texto Qualquer",
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                letterSpacing: 2
              ),),
              Image.network("https://static-00.iconduck.com/assets.00/flutter-icon-2048x2048-ufx4idi8.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover),

              Image.asset("assets/img/einstein.png",
              width: 200,
              height: 200,
              fit: BoxFit.cover),

              Icon(Icons.star,
              size: 100,
              color: Colors.amber),
            ],
          ),
        ),
      ),
    );
  } 
}
