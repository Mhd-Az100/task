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
      {this.firstname,
      this.password,
      this.lastname,
      this.address,
      this.email,
      this.gender,
      this.phone,
      this.picture,
      this.dataofbirth});
  User.fromMap(Map<dynamic, dynamic> map) {
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
    var map = new Map<String, dynamic>();
    map["firstname"] = firstname;
    map["lastname"] = lastname;
    map["email"] = email;
    map["password"] = password;
    map["address"] = address;
    map["dataofbirth"] = dataofbirth;
    map["gender"] = gender;
    map["phone"] = phone;
    map["picture"] = picture;

    return map;
  }
}
