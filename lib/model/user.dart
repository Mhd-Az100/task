class User {
  int? id;
  String? firstname;
  String? lastname;
  String? address;
  String? password;
  String? email;
  String? phone;
  String? gender;
  String? dataofbirth;

  User({
    this.id,
    this.firstname,
    this.password,
    this.lastname,
    this.address,
    this.email,
    this.gender,
    this.phone,
    this.dataofbirth,
  });

  User.fromJson(Map<dynamic, dynamic> map)
      : this.id = map['id'],
        this.firstname = map['firstname'],
        this.lastname = map['lastname'],
        this.address = map['address'],
        this.password = map['password'],
        this.email = map['email'],
        this.gender = map['gender'],
        this.phone = map['phone'],
        this.dataofbirth = map['dataofbirth'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "firstname": firstname,
      "lastname": lastname,
      "address": address,
      "email": email,
      "password": password,
      "dataofbirth": dataofbirth,
      "gender": gender,
      "phone": phone,
    };
  }
}
