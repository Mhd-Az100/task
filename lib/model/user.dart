class User {
  int? id;
  String? firstname;
  String? lastname;
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
    this.email,
    this.gender,
    this.phone,
    this.dataofbirth,
  });

  User.fromJson(Map<dynamic, dynamic> map)
      : this.id = map['id'],
        this.firstname = map['firstname'],
        this.lastname = map['lastname'],
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
      "email": email,
      "password": password,
      "dataofbirth": dataofbirth,
      "gender": gender,
      "phone": phone,
    };
  }
}
