import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(home:MyApp()));
}

class MyApp extends StatelessWidget{
  // lista de imagens
final List<String> imagens = [
      'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0',
      'https://images.unsplash.com/photo-1521747116042-5a810fda9664',
      'https://images.unsplash.com/photo-1504384308090-c894fdcc538d',
      'https://media.istockphoto.com/id/77931645/pt/foto/jovem-mulher-e-menina-ao-ar-livre-com-pessoas-em-segundo-plano.webp?a=1&b=1&s=612x612&w=0&k=20&c=_lbqeKfRiQXFEg_H9TqjfD73qL-PgjxKxksibjDJilo=',
      'https://images.unsplash.com/photo-1526779259212-939e64788e3c?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8OHx8ZnJlZSUyMGltYWdlc3xlbnwwfHwwfHx8MA%3D%3D',
      'https://plus.unsplash.com/premium_photo-1661889099855-b44dc39e88c9?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTd8fGZyZWUlMjBpbWFnZXN8ZW58MHx8MHx8fDA%3D',
      'https://media.istockphoto.com/id/1009803562/pt/foto/group-of-people-on-peak-mountain-climbing-helping-team-work-travel-trekking-success-business.webp?a=1&b=1&s=612x612&w=0&k=20&c=yHq75Q3O4gAwoFgm0bgHApSoklhd21Mzt1FtvUfl9BI=',
      'https://images.unsplash.com/photo-1506619216599-9d16d0903dfd',
      'https://images.unsplash.com/photo-1494172961521-33799ddd43a5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Galeria de Imagens')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: CarouselSlider(
                options: CarouselOptions(height: 300, autoPlay: true),
                items: imagens.map((url) {
                  return Container(
                    margin: EdgeInsets.all(8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(url, fit: BoxFit.cover, width: 1000),
                    ),
                  );
                }).toList(),
              ),
            ),
            Expanded(
          child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Define 3 imagens por linha
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: imagens.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => _mostrarImagem(context, imagens[index]),
              child: Image.network(imagens[index], fit: BoxFit.cover),
            );
          },
        ),
      ),
    ])));
  }

 void _mostrarImagem(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Image.network(url),
      ),
    );
  }
}

