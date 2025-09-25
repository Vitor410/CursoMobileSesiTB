import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formative_cine_favorite/views/favorite_view.dart';
import 'package:formative_cine_favorite/views/login.dart';

void main() async{ // Async -> Conect com Firebase
//garanto o carregamento dos widgets antes de conectar com o firebase
  WidgetsFlutterBinding.ensureInitialized();
  //conexão com o firebase
  await Firebase.initializeApp();
  //montagem das Caracretisticas do App
  runApp(MaterialApp(
    title: "CineFavorite",
    home: AuthStream(),
  ));
}

//Listerner para Direciobar a Navegação da Tela Inicial
class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    //verifica se o usuário já esta logado ou não
    return StreamBuilder<User?>(
      // o listener esta na mudança de status do usuário
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context,snapshot){
        //se estiver logado , vai para HomeScreen(Tela FAvorito)
        if(snapshot.hasData){
          return FavoriteView();
        }
        //se não tiver logado
        return LoginView();
      });
  }
}

