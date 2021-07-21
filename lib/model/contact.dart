class Contact {
  int? id;
  String? name;
  String? phone;
  String? address;
  int? userid;
  Contact({this.id, this.name, this.phone, this.address, this.userid});

  Contact.fromMap(Map<dynamic, dynamic> map) {
    id = map['id'];
    name = map['name'];
    phone = map['phone'];
    address = map['address'];
    userid = map['userid'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      "name": name,
      "phone": phone,
      "address": address,
      "userid": userid,
    };
    if (id != null) map['id'] = id;
    return map;
  }
}
