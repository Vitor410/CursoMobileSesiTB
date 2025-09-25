# Cine Favorite (Formativa)
Contruir um Aplicativo do Zero - O CineFavorite que permitirá criar uma conta e buscar filmes em uma API e montar uma galeria pessoal de filmes favoritos, com poster e nota avaliativa do usuário par o filme.

## Objetivos
- Criar uma Galeria Personalizada por Usuário de Filmes Favoritos
- Conectar o APP com uma API(base de dados) de Filmes (TMDB)
- Permitir a Criação de Contas para Cada Usuário
- Listar Filmes po Uma Palavra-Chave

## Levantamento de Requisitos do Projeto
- ### Funcionais

- ### Não Funcionais

## Recursos do Projeto
- Linguagem de Progamação : Flutter/Dart
- API TMDB : Base de Dados para Filmes 
- Firebase: Authentication / FireStore
- Figma: Prototipagem 
- VScode
- GitHub

## Diagramas
1. Classes 
Demonstrar o Funcionamento de Entidades do Sistemas 

- Usuário (User): classe já modelada pelo FirebaseAuth
    - Atributos : email, senha, udi
    - Métodos: login, registrar, logout

- Filmes Favoritos (FavoriteMovie): Classe Modelada pelo DEV
    - Atributos: id, título, PosterPath, Nota
    - Métodos: adicionar, remover, listar, atualizaNota (CRUD)

```mermaid
    
    ClassDiagram
        class User{
            +String uid
            +String email
            +String password
            +createUser()
            +login()
            +logout() 
        }

        class FavoriteMovie{
            +int id
            +String title 
            +String posterPath
            +double Rating 
            +addFavorite()
            +removeFavorite()
            +updateMovieRating()
            +getFavoriteMovies()
        }

        User "1"--"1+" FavoriteMovie: "select"
```
