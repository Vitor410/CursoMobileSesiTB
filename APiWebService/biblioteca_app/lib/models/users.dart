class UserModel {
  //atributos
  final String? id;
  final String name;
  final String email;
  //construtor
  UserModel({this.id, required this.name, required this.email});

  //métodos
  //toJson => OBJ => MAP
  Map<String, dynamic> toJson() {
    final map = {"name": name, "email": email};
    if (id != null) {
      map["id"] = id.toString();
    }
    return map;
  }

  //fromJson MAP => OBJ
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"].toString(),
    name: json["name"].toString(),
    email: json["email"].toString(),
  );
}
