class BooksModel {
  //atributos
  final String? id;
  final String title;
  final String author;
  final String available;

  // Construtor
  BooksModel(this.available, {this.id, required this.title, required this.author});

  // Método para converter de JSON para BooksModel
  factory BooksModel.fromJson(Map<String, dynamic> json) {
    return BooksModel(
      json['available'] as String,
      id: json['id'] as String?,
      title: json['title'] as String,
      author: json['author'] as String,
    );
  }

  // Método para converter BooksModel para JSON
 Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'author': author};
  }
}
