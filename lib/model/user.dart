class User {
  int? id;
  String? firstname;
  String? lastname;
  String? password;
  String? email;
  String? phone;
  String? address;
  String? gender;
  String? dataofbirth;
  String? picture;
  User(
      {this.id,
      this.firstname,
      this.password,
      this.lastname,
      this.address,
      this.email,
      this.gender,
      this.phone,
      this.picture,
      this.dataofbirth});
  User.fromMap(Map<dynamic, dynamic> map) {
    this.id = map['id'];
    this.firstname = map['firstname'];
    this.lastname = map['lastname'];
    this.password = map['password'];
    this.email = map['email'];
    this.address = map['address'];
    this.gender = map['gender'];
    this.phone = map['phone'];
    this.picture = map['picture'];
    this.dataofbirth = map['dataofbirth'];
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
      "address": address,
      "dataofbirth": dataofbirth,
      "gender": gender,
      "phone": phone,
      "picture": picture,
    };
    return map;
  }
}
