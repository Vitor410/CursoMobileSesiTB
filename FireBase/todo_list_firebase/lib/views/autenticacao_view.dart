import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_firebase/views/login.dart';
import 'package:todo_list_firebase/views/tarefas_view.dart';

//Tela que direciona o usuário de acordo com Status de autenticação
class AutenticacaoView extends StatelessWidget {
  const AutenticacaoView({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //classe User é modelo pronto do FireBaseAuth
      //A MUDANÇA DE TELA É DETERMINADA PELA CONEXÃO DO USUÁRIO AO FIREBASE AUTH
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if(snapshot.hasData){ //se o snapshot contêm dados do Usuário
          //direciona o usuário para a tela de Tarefas
          return TarefasView();
        }
        //caso não contenha dados do usuário
        //direciona para a tela de login
        return LoginView();
      });
  }
}
