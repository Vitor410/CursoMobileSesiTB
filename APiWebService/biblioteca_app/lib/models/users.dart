class UserModel {
  //atributos
  final String? id; // pode ser nulo inicialmente
  final String name;
  final String email;
  //construtor
  UserModel({this.id, required this.name, required this.email});

  //métodos
  //toJson
  Map<String, dynamic> toJson() => {"id": id, "name": name, "email": email};

  //fromJson
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"].toString(),
    name: json["name"],
    email: json["email"].toString());
}
