import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MaterialApp(home: ImagePickerScreen()));
}

//criar um exemplo de uso de camera -> biblioteca image_picker

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? _image;
  final ImagePicker _picker =
      ImagePicker(); //obj controlador do uso da camera/galeria

  //métodos
  //método para tirar foto
  void _getImageFromCamera() async {
    //abre a camera e permite tirar uma foto,
    //armazena a foto em um arquivo temporário(pickedFile)
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );
    //verificar se a imagem foi armazenada no cache
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  //método pegar img da galeria
  void _getImageFromGallery() async{
    //abrir a galeria de iamgens do dispositivo
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    //verificar se a imagem foi armazenada no cache
    if(pickedFile !=null){
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  // build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Exemplo Image Picker"),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //campo para mostrar a imagem (ou tirada da Camera ou Selecionada da galeria)
            _image != null
            ? Image.file(_image!, height: 200,)
            : Text("Nenhuma Imagem Selecionada"),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: _getImageFromCamera, child: Text("Tirar foto")),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: _getImageFromGallery, child: Text("Escolher da Galeria"))
          ],
        ),
      ),
    );
  }
}
