class Userr {
  int id;
  String name;
  String username;
  String email;
  String matricNo;
  String password;

  Userr(
    this.id,
    this.name,
    this.username,
    this.email,
    this.matricNo,
    this.password,
  );

  factory Userr.fromJson(Map<String, dynamic> json) => Userr(
        int.parse(json["id"]),
        json["name"],
        json["username"],
        json["email"],
        json["matricNo"],
        json["password"],
      );

  Map<String, dynamic> toJson() => {
        'name': name.toString(),
        'username': username.toString(),
        'email': email.toString(),
        'matricNo': matricNo.toString(),
        //\'password': password.toString(),
      };
}
