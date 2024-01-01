class Userr {
  int id;
  String name;
  String username;
  String email;
  String clubNo;
  String password;

  Userr(
    this.id,
    this.name,
    this.username,
    this.email,
    this.clubNo,
    this.password,
  );

  factory Userr.fromJson(Map<String, dynamic> json) => Userr(
        int.parse(json["id"]),
        json["name"],
        json["username"],
        json["email"],
        json["clubNo"],
        json["password"],
      );

  Map<String, dynamic> toJson() => {
        'name': name.toString(),
        'username': username.toString(),
        'email': email.toString(),
        'clubNo': clubNo.toString(),
        //\'password': password.toString(),
      };
}
