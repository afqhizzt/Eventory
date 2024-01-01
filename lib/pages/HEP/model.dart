class Userr {
  int id;
  String name;
  String username;
  String email;
  String staffNo;
  String password;

  Userr(
    this.id,
    this.name,
    this.username,
    this.email,
    this.staffNo,
    this.password,
  );

  factory Userr.fromJson(Map<String, dynamic> json) => Userr(
        int.parse(json["id"]),
        json["name"],
        json["username"],
        json["email"],
        json["staffNo"],
        json["password"],
      );

  Map<String, dynamic> toJson() => {
        'name': name.toString(),
        'username': username.toString(),
        'email': email.toString(),
        'staffNo': staffNo.toString(),
        //\'password': password.toString(),
      };
}
